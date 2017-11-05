//
//  SignUpEmailViewController.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 22.10.2017.
//

import Foundation
import UIKit
import SwiftValidator

final class SignUpEmailViewController: UIViewController {
    
    fileprivate let mainView: SignUpEmailView
    fileprivate var navigator: NavigationController?
    fileprivate let validator = Validator()
    
    init(mainView: SignUpEmailView) {
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

extension SignUpEmailViewController: NavigationControllerDelegate {
    func rightAction() {
        validator.validate(self)
    }
    
    func backAction() {
        mainView.animate(entry: false, completion: {
            self.navigationController?.popViewController(animated: false)
        })
    }
        
}


extension SignUpEmailViewController: ValidationDelegate {
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
        validator.registerField(mainView.emailEditField.textField, rules: [RequiredRule(), EmailRule()])
    }
}
