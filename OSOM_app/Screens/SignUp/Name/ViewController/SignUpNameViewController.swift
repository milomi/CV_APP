//
//  SignUpNameViewController.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 15.10.2017.
//

import Foundation
import UIKit

final class SignUpNameViewController: UIViewController {
    
    private let mainView: SignUpNameView
    var navigator: NavigationController?

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
    }
}

extension SignUpNameViewController: NavigationControllerDelegate {
    func rightAction() {
        DispatchQueue.main.async(execute: {
            self.mainView.animate(entry: true, completion: {
                let vc = ViewControllerContainer.shared.getSignUpEmail()
                self.navigationController?.pushViewController(vc, animated: false)
            })
        })
    }
    
    func backAction() {
        mainView.animate(entry: false, completion: {
            self.navigationController?.popViewController(animated: false)
        })
    }
}
