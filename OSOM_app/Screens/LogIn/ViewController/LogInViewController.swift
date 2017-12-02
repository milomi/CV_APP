//
//  LogInViewController.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 22.10.2017.
//

import Foundation
import UIKit
import SwiftValidator

fileprivate struct LocalizedStrings {
    static let loginError = "logIn.error"
}

final class LogInViewController: UIViewController {
    
    fileprivate let mainView: LogInView
    fileprivate let viewModel: LoginViewModel
    var navigator: NavigationController?
    fileprivate let validator = Validator()
    
    init(mainView: LogInView, viewModel: LoginViewModel) {
        self.mainView = mainView
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        setupView()
        setupNavigation()
    }

    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.async(execute: {
            self.mainView.fadeIn()
        })
    }
    
    fileprivate func setupNavigation() {
        navigator = NavigationController(navigationView: mainView.navigation, navigationController: navigationController)
        navigator?.delegate = self
    }
    
    private func setupView() {
        view = mainView
        mainView.setupView()
        registerValidatableFields()
    }
}

extension LogInViewController: NavigationControllerDelegate {
    func rightAction() {
        validator.validate(self)
    }
    
    func backAction() {
        mainView.animate(entry: false, completion: {
            self.navigationController?.popViewController(animated: false)
        })
    }
}

extension LogInViewController: ValidationDelegate {
    func validationSuccessful() {
        viewModel.login(email: mainView.emailEditField.textField.text ?? "",
                        password: mainView.passwordEditField.textField.text ?? "")
    }
    
    func validationFailed(_ errors: [(Validatable, ValidationError)]) {
        for (field, error) in errors {
            if let field = field as? UITextField {
                error.errorLabel?.text = error.errorMessage
                field.shake()
            }
        }
    }
    
    fileprivate func registerValidatableFields() {
        validator.registerField(mainView.emailEditField.textField, errorLabel: mainView.emailEditField.errorLabel, rules: [RequiredRule()])
        validator.registerField(mainView.passwordEditField.textField, errorLabel: mainView.passwordEditField.errorLabel, rules: [RequiredRule()])
        
    }
}

extension LogInViewController: LoginViewModelDelegate {
    func loginSuccessed() {
        let vc = ViewControllerContainer.shared.getCreateAbout()
        changeRootVC(newViewController: vc)
    }
    
    func loginFailed() {
        mainView.passwordEditField.errorLabel.text = LocalizedStrings.loginError.localized()
    }
    
}

