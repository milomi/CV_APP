//
//  SignUpEmailView.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 22.10.2017.
//

import Foundation
import UIKit

fileprivate struct Constants {
    
    struct EmailEditField {
        static let title = "signUp.email"
        static let placeholder = "signUp.email.placeholder"
        
        struct Constraints {
            static let top = 30
            static let padding = 35
        }
    }

}

final class SignUpEmailView: BaseSignUpView {
    
    let emailEditField: BaseEditField = {
        let field = BaseEditField()
        field.headerLabel.text = Constants.EmailEditField.title.localized()
        field.textField.attributedPlaceholder = field.setAttributedPlaceholder(string: Constants.EmailEditField.placeholder.localized())
        return field
    }()
    
    override func setupView() {
        super.setupView()
        setupEmailEditField()
    }
    
    func fadeIn() {
        emailEditField.fadeIn()
    }
    
    func animate(entry: Bool, completion: (() -> Void)? = nil) {
        let width = self.contentView.bounds.width
        UIView.animate(withDuration: 0.5, animations: {
            self.emailEditField.center.x -= entry ? width : -width
        }, completion: { (data) in
            completion?()
        })
    }
    
    private func setupEmailEditField() {
        contentView.addSubview(emailEditField)
        emailEditField.setupView()
        emailEditField.snp.makeConstraints { (make) in
            make.top.equalTo(Constants.EmailEditField.Constraints.top)
            make.leading.equalTo(Constants.EmailEditField.Constraints.padding)
            make.trailing.equalTo(-Constants.EmailEditField.Constraints.padding)
        }
    }
    
}
