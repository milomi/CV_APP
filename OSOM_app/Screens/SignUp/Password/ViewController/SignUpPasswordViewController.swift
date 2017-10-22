//
//  SignUpPasswordViewController.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 22.10.2017.
//

import Foundation
import UIKit

final class SignUpPasswordViewController: UIViewController {
    
    private let mainView: SignUpPasswordView
    var navigator: NavigationController?
    
    init(mainView: SignUpPasswordView) {
        self.mainView = mainView
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        setupView()
        setupNavigation()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        
    }
}