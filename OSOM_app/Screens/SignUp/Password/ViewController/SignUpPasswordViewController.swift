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
    fileprivate var navigator: NavigationController?
    fileprivate let validator = Validator()

    
    init(mainView: SignUpPasswordView) {
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
    }
    
}

extension SignUpPasswordViewController: NavigationControllerDelegate {
    func rightAction() {
        mainView.animate(entry: true, completion: {
            let vc = ViewControllerContainer.shared.getCreateAbout()
            self.navigationController?.pushViewController(vc, animated: false)
        })
    }
    
    func backAction() {
        mainView.animate(entry: false, completion: {
            self.navigationController?.popViewController(animated: false)
        })
    }
}

extension SignUpPasswordViewController: ValidationDelegate {
    func validationSuccessful() {
        mainView.animate(entry: true, completion: {
            let vc = ViewControllerContainer.shared.getSignUpPassword()
            self.navigationController?.pushViewController(vc, animated: false)
        })
    }
    
    func validationFailed(_ errors: [(Validatable, ValidationError)]) {
        for (field, error) in errors {
            if let field = field as? UITextField {
                field.shake()
            }
        }
    }
    
    fileprivate func registerValidatableFields() {
        validator.registerField(mainView.passwordEditField.textField, rules: [RequiredRule(), PasswordRule()])
        validator.registerField(mainView.passwordEditField.textField, rules: [RequiredRule(), PasswordRule()])
    }
}
