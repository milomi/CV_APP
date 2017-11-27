//
//  SignUpNameViewController.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 15.10.2017.
//

import Foundation
import UIKit
import SwiftValidator

final class SignUpNameViewController: UIViewController {
    
    fileprivate let mainView: SignUpNameView
    fileprivate var navigator: NavigationController?
    fileprivate let validator = Validator()

    init(mainView: SignUpNameView) {
        self.mainView = mainView
        super.init(nibName: nil, bundle: nil)
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

extension SignUpNameViewController: NavigationControllerDelegate {
    func rightAction() {
        validator.validate(self)
    }
    
    func backAction() {
        mainView.animate(entry: false, completion: {
            self.navigationController?.popViewController(animated: false)
        })
    }
}

extension SignUpNameViewController: ValidationDelegate {
    func validationSuccessful() {
        mainView.clearErrorLabels()
        DispatchQueue.main.async(execute: {
            self.mainView.animate(entry: true, completion: {
                let user = User()
                user.name = self.mainView.nameEditField.textField.text ?? ""
                user.surname = self.mainView.surnameEditField.textField.text ?? ""

                let vc = ViewControllerContainer.shared.getSignUpEmail(user: user)
                self.navigationController?.pushViewController(vc, animated: false)
            })
        })
    }
    
    func validationFailed(_ errors: [(Validatable, ValidationError)]) {
        mainView.clearErrorLabels()
        for (field, error) in errors {
            if let field = field as? UITextField {
                error.errorLabel?.text = error.errorMessage
                field.shake()
            }
        }
    }
    
    fileprivate func registerValidatableFields() {
        validator.registerField(mainView.nameEditField.textField, errorLabel: mainView.nameEditField.errorLabel, rules: [RequiredRule()])
        validator.registerField(mainView.surnameEditField.textField, errorLabel: mainView.surnameEditField.errorLabel, rules: [RequiredRule()])
    }
}
