//
//  SignUpEmailViewController.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 22.10.2017.
//

import Foundation
import UIKit

final class SignUpEmailViewController: UIViewController {
    
    private let mainView: SignUpEmailView
    var navigator: NavigationController?
    
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
    }
}

extension SignUpEmailViewController: NavigationControllerDelegate {
    func rightAction() {
        mainView.animate(entry: true, completion: {
            let vc = ViewControllerContainer.shared.getSignUpPassword()
            self.navigationController?.pushViewController(vc, animated: false)
        })
    }
    
    func backAction() {
        mainView.animate(entry: false, completion: {
            self.navigationController?.popViewController(animated: false)
        })
    }
        
}
