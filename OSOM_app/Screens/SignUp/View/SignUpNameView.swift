//
//  SignUpNameView.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 15.10.2017.
//

import Foundation
import UIKit

fileprivate struct Constants {
    
    struct NameEditField {
        static let title = "signUp.name"
        static let placeholder = "signUp.name.placeholder"
        
        struct Constraints {
            static let top = 30
            static let padding = 35
        }
    }
    
    struct SurnameEditField {
        static let title = "signUp.surname"
        static let placeholder = "signUp.surname.placeholder"
        
        struct Constraints {
            static let top = 30
            static let padding = 35
        }
    }
}

final class SignUpNameView: BaseSignUpView {
    
    let nameEditField: BaseEditField = {
        let field = BaseEditField()
        field.headerLabel.text = Constants.NameEditField.title.localized()
        field.textField.attributedPlaceholder = field.setAttributedPlaceholder(string: Constants.NameEditField.placeholder.localized())
        return field
    }()
    
    let surnameEditField: BaseEditField = {
        let field = BaseEditField()
        field.headerLabel.text = Constants.SurnameEditField.title.localized()
        field.textField.attributedPlaceholder = field.setAttributedPlaceholder(string:  Constants.SurnameEditField.placeholder.localized())
        return field
    }()
    
    override func setupView() {
        super.setupView()
        setupNameEditField()
        setupSurnameEditField()
    }
    
    private func setupNameEditField() {
        contentView.addSubview(nameEditField)
        nameEditField.setupView()
        nameEditField.snp.makeConstraints { (make) in
            make.top.equalTo(Constants.NameEditField.Constraints.top)
            make.leading.equalTo(Constants.NameEditField.Constraints.padding)
            make.trailing.equalTo(-Constants.NameEditField.Constraints.padding)
        }
    }
    
    private func setupSurnameEditField() {
        contentView.addSubview(surnameEditField)
        surnameEditField.setupView()
        surnameEditField.snp.makeConstraints { (make) in
            make.top.equalTo(nameEditField.snp.bottom).offset(Constants.SurnameEditField.Constraints.top)
            make.width.equalTo(nameEditField.snp.width)
            make.centerX.equalTo(nameEditField.snp.centerX)
            make.bottom.lessThanOrEqualToSuperview()
        }
    }
}
