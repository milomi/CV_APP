//
//  SignUpPasswordViewController.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 22.10.2017.
//

import Foundation
import UIKit
import SwiftValidator

final class SignUpPasswordViewController: UIViewController {
    
    fileprivate let mainView: SignUpPasswordView
    fileprivate let viewModel: SignUpPasswordViewModel
    fileprivate var navigator: NavigationController?
    fileprivate let validator = Validator()

    
    init(mainView: SignUpPasswordView, viewModel: SignUpPasswordViewModel) {
        self.mainView = mainView
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
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

extension SignUpPasswordViewController: NavigationControllerDelegate {
    func rightAction() {
        validator.validate(self)
    }
    
    func backAction() {
        mainView.animate(entry: false, completion: {
            self.navigationController?.popViewController(animated: false)
        })
    }
}

extension SignUpPasswordViewController: ValidationDelegate {
    func validationSuccessful() {
        mainView.clearsErrorLabels()
        viewModel.register(password: mainView.passwordEditField.textField.text ?? "")
    }
    
    func validationFailed(_ errors: [(Validatable, ValidationError)]) {
        mainView.clearsErrorLabels()
        for (field, error) in errors {
            if let field = field as? UITextField {
                error.errorLabel?.text = error.errorMessage
                field.shake()
            }
        }
    }
    
    fileprivate func registerValidatableFields() {
        let repeatPasswordRule = RepeatPasswordRule(compareField: mainView.passwordEditField.textField)
        let minLenght = MinLengthRule(length: 6)

        validator.registerField(mainView.passwordEditField.textField, errorLabel: mainView.passwordEditField.errorLabel, rules: [RequiredRule(), minLenght])
        validator.registerField(mainView.repeatPasswordEditField.textField, errorLabel: mainView.repeatPasswordEditField.errorLabel, rules: [RequiredRule(), repeatPasswordRule])

    }
}

extension SignUpPasswordViewController: SignUpPasswordViewModelDelegate {
    func signUpSuccessed() {
        mainView.animate(entry: true, completion: {
            let vc = ViewControllerContainer.shared.getCreateAbout()
            self.navigationController?.pushViewController(vc, animated: false)
        })
        
    }
    
    func signUpFailed() {
        print("SignUp f")
    }
}
