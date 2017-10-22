//
//  WelcomeScreenViewController.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 18/07/2017.
//  Copyright © 2017 ITEO Sp. z o.o. All rights reserved.
//

import UIKit

fileprivate extension Selector {
    static let logIn = #selector(WelcomeScreenViewController.logIn)
    static let signUp = #selector(WelcomeScreenViewController.signUp)
}

class WelcomeScreenViewController: UIViewController {
    
    fileprivate let viewModel: WelcomeScreenViewModel
    fileprivate let mainView: WelcomeView
    
    init(viewModel: WelcomeScreenViewModel, mainView: WelcomeView) {
        self.viewModel = viewModel
        self.mainView = mainView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        navigationController?.isNavigationBarHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    fileprivate func setupView() {
        self.view = mainView
        mainView.logIn.button.addTarget(self, action: .logIn, for: .touchUpInside)
        mainView.signUp.button.addTarget(self, action: .signUp, for: .touchUpInside)
        mainView.setupView()
    }

}

// MARK Actions
extension WelcomeScreenViewController {
    
    @objc func logIn() {
        let controller = ViewControllerContainer.shared.getSignUpName()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func signUp() {
//        let controller = ViewControllerContainer().getSignUp()
//        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}

