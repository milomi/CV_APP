//
//  LogInView.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 22.10.2017.
//

import Foundation
import UIKit

fileprivate struct Constants {
    
    struct Navigation {
        static let title = "LogIn.title"
        static let headerImage = "LogIn.headerImage"
    }
    
    struct PasswordEditField {
        static let title = "signUp.password"
        static let placeholder = "LogIn.password.placeholder"
        
        struct Constraints {
            static let top = 30
            static let padding = 35
        }
    }
    
    struct EmailEditField {
        static let title = "signUp.email"
        static let placeholder = "signUp.email.placeholder"
        
        struct Constraints {
            static let top = 30
            static let padding = 35
        }
    }
}

final class LogInView: BaseSignUpView {
    
    let passwordEditField: BaseEditField = {
        let field = BaseEditField()
        field.headerLabel.text = Constants.PasswordEditField.title.localized()
        field.textField.attributedPlaceholder = field.setAttributedPlaceholder(string: Constants.PasswordEditField.placeholder.localized())
        return field
    }()
    
    let emailEditField: BaseEditField = {
        let field = BaseEditField()
        field.headerLabel.text = Constants.EmailEditField.title.localized()
        field.textField.attributedPlaceholder = field.setAttributedPlaceholder(string: Constants.EmailEditField.placeholder.localized())
        return field
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupView() {
        super.setupView()
        setupNavigation()
        setupHeaderImage()
        setupPasswordEditField()
        setupEmailEditField()
    }
    
    private func setupNavigation() {
        navigation.title.text = Constants.Navigation.title.localized()
    }
    
    private func setupHeaderImage() {
        headerImage.image = UIImage(named: Constants.Navigation.headerImage)
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
    
    private func setupEmailEditField() {
        contentView.addSubview(emailEditField)
        emailEditField.setupView()
        
        emailEditField.snp.makeConstraints { (make) in
            make.top.equalTo(passwordEditField.snp.bottom).offset(Constants.EmailEditField.Constraints.top)
            make.width.equalTo(passwordEditField.snp.width)
            make.centerX.equalTo(passwordEditField.snp.centerX)
            make.bottom.lessThanOrEqualToSuperview()
        }
    }
}

