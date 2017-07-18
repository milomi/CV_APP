//
//  WelcomeScreenViewController.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 18/07/2017.
//  Copyright © 2017 ITEO Sp. z o.o. All rights reserved.
//

import UIKit

fileprivate extension Selector {
    static let EmployeeAction = #selector(WelcomeScreenViewController.EmployeeAction)
    static let EmployerAction = #selector(WelcomeScreenViewController.EmployerAction)
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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func setupView() {
        self.view = mainView
        mainView.setAppNameText(text: viewModel.getAppNameLabelText())
        mainView.setTitleText(text: viewModel.getWelcomeLabelText())
        mainView.setSignInButtonTitle(title: viewModel.getSignInButtonText())
        mainView.setSignUpButtonTitle(title: viewModel.getSignUpButtonText())
        mainView.signIn.addTarget(self, action: .EmployeeAction, for: .touchUpInside)
        mainView.signUp.addTarget(self, action: .EmployerAction, for: .touchUpInside)
        mainView.setupView()
    }
    
    
}

// MARK Actions
extension WelcomeScreenViewController {
    
    func EmployeeAction() {
//        let controller = ViewControllerContainer().getSignIn()
//        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func EmployerAction() {
//        let controller = ViewControllerContainer().getSignUp()
//        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}

