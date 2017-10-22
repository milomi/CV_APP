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
        field.headerLabel.text = Constants.PasswordEditField.title.localized()
        field.textField.attributedPlaceholder = field.setAttributedPlaceholder(string: Constants.PasswordEditField.placeholder.localized())
        return field
    }()
    
    let repeatPasswordEditField: BaseEditField = {
        let field = BaseEditField()
        field.headerLabel.text = Constants.RepeatPasswordEditField.title.localized()
        field.textField.attributedPlaceholder = field.setAttributedPlaceholder(string:  Constants.RepeatPasswordEditField.placeholder.localized())
        return field
    }()
    
    override func setupView() {
        super.setupView()
        setupPasswordEditField()
        setupRepeatPasswordEditField()
    }
    
    private func setupPasswordEditField() {
        contentView.addSubview(passwordEditField)
        passwordEditField.setupView()
        passwordEditField.snp.makeConstraints { (make) in
            make.top.equalTo(Constants.PasswordEditField.Constraints.top)
            make.leading.equalTo(Constants.PasswordEditField.Constraints.padding)
            make.trailing.equalTo(-Constants.PasswordEditField.Constraints.padding)
        }
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
    }
}
