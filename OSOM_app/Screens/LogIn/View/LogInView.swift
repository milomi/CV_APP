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
        static let headerImage = "login"
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
        field.alpha = 0.0
        field.headerLabel.text = Constants.PasswordEditField.title.localized()
        field.setAttributedPlaceholder(string: Constants.PasswordEditField.placeholder.localized())
        field.textField.isSecureTextEntry = true
        return field
    }()
    
    let emailEditField: BaseEditField = {
        let field = BaseEditField()
        field.alpha = 0.0
        field.headerLabel.text = Constants.EmailEditField.title.localized()
        field.setAttributedPlaceholder(string: Constants.EmailEditField.placeholder.localized())
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
        setupEmailEditField()
        setupPasswordEditField()
    }
    
    func clearsErrorLabels() {
        passwordEditField.clearError()
        emailEditField.clearError()
    }
    
    
    func fadeIn() {
        emailEditField.fadeIn()
        let when = DispatchTime.now() + 0.3 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.passwordEditField.fadeIn()
        }
    }
    
    func animate(entry: Bool, completion: (() -> Void)? = nil) {
        let width = self.contentView.bounds.width
        UIView.animate(withDuration: 0.5, animations: {
            self.emailEditField.center.x -= entry ? width : -width
        })
        
        UIView.animate(withDuration: 0.5, delay: 0.3, options: .beginFromCurrentState, animations: {
            self.passwordEditField.center.x -= entry ? width : -width
        }, completion: { (data) in
            if let completion = completion {
                completion()
            }
        })
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
            make.top.equalTo(emailEditField.snp.bottom).offset(Constants.EmailEditField.Constraints.top)
            make.width.equalTo(emailEditField.snp.width)
            make.centerX.equalTo(emailEditField.snp.centerX)
            make.bottom.lessThanOrEqualToSuperview()
        }
    }
    
    private func setupEmailEditField() {
        contentView.addSubview(emailEditField)
        emailEditField.setupView()
        
        emailEditField.snp.makeConstraints { (make) in
            make.top.equalTo(Constants.PasswordEditField.Constraints.top)
            make.leading.equalTo(Constants.PasswordEditField.Constraints.padding)
            make.trailing.equalTo(headerImage.snp.trailing).offset(-Constants.EmailEditField.Constraints.padding)
        }
    }
}

