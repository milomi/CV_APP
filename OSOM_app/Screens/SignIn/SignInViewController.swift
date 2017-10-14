//
//  SignInViewController.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 19/07/2017.
//
//

import Foundation
import UIKit



class SignInEmailStepViewController: UIViewController {
    
    fileprivate let viewModel: SignInViewModel
    fileprivate let mainView: UIView
    
    init(viewModel: SignInViewModel, mainView: UIView) {
        self.viewModel = viewModel
        self.mainView = mainView
        super.init(nibName: nil, bundle: nil)
        //self.viewModel.
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
}
