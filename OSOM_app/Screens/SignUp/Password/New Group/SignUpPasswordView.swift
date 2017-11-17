//
//  SignUpPasswordView.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 22.10.2017.
//

import Foundation
import UIKit

fileprivate struct Constants {
    
    struct PasswordEditField {
        static let title = "signUp.password"
        static let placeholder = "signUp.password.placeholder"
        
        struct Constraints {
            static let top = 30
            static let padding = 35
        }
    }
    
    struct RepeatPasswordEditField {
        static let title = "signUp.repeatPassword"
        static let placeholder = "signUp.repeatPassword.placeholder"
        
        struct Constraints {
            static let top = 30
            static let padding = 35
        }
    }
}

final class SignUpPasswordView: BaseSignUpView {
    
    let passwordEditField: BaseEditField = {
        let field = BaseEditField()
        field.alpha = 0.0
        field.headerLabel.text = Constants.PasswordEditField.title.localized()
        field.setAttributedPlaceholder(string: Constants.PasswordEditField.placeholder.localized())
        return field
    }()
    
    let repeatPasswordEditField: BaseEditField = {
        let field = BaseEditField()
        field.alpha = 0.0
        field.headerLabel.text = Constants.RepeatPasswordEditField.title.localized()
        field.setAttributedPlaceholder(string:  Constants.RepeatPasswordEditField.placeholder.localized())
        return field
    }()
    
    override func setupView() {
        super.setupView()
        setupPasswordEditField()
        setupRepeatPasswordEditField()
    }
    
    func clearsErrorLabels() {
        passwordEditField.clearError()
        repeatPasswordEditField.clearError()
    }
    
    func fadeIn() {
        passwordEditField.fadeIn()
        let when = DispatchTime.now() + 0.3 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.repeatPasswordEditField.fadeIn()
        }
    }
    
    func animate(entry: Bool, completion: (() -> Void)? = nil) {
        let width = self.contentView.bounds.width
        UIView.animate(withDuration: 0.5, animations: {
            self.passwordEditField.center.x -= entry ? width : -width
        })
        
        UIView.animate(withDuration: 0.5, delay: 0.3, options: .beginFromCurrentState, animations: {
            self.repeatPasswordEditField.center.x -= entry ? width : -width
        }, completion: { (data) in
            if let completion = completion {
                completion()
            }
        })
    }
    
    private func setupPasswordEditField() {
        
        contentView.addSubview(passwordEditField)
        passwordEditField.setupView()
        passwordEditField.snp.makeConstraints { (make) in
            make.top.equalTo(Constants.PasswordEditField.Constraints.top)
            make.leading.equalTo(Constants.PasswordEditField.Constraints.padding)
            make.trailing.equalTo(headerImage.snp.trailing).offset(-Constants.PasswordEditField.Constraints.padding)
        }
        
        self.passwordEditField.center.x -= contentView.bounds.width

    }
    
    private func setupRepeatPasswordEditField() {
        contentView.addSubview(repeatPasswordEditField)
        repeatPasswordEditField.setupView()
        
        repeatPasswordEditField.snp.makeConstraints { (make) in
            make.top.equalTo(passwordEditField.snp.bottom).offset(Constants.RepeatPasswordEditField.Constraints.top)
            make.width.equalTo(passwordEditField.snp.width)
            make.centerX.equalTo(passwordEditField.snp.centerX)
            make.bottom.lessThanOrEqualToSuperview()
        }
        
        self.repeatPasswordEditField.center.x -= contentView.bounds.width

    }
}
