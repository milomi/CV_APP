//
//  CreateAboutViewController.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 04.11.2017.
//

import Foundation
import UIKit

final class CreateAboutViewController: UIViewController {
    
    fileprivate let mainView: CreateAboutView
    var navigator: NavigationController?
    
    init(view: CreateAboutView) {
        mainView = view
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
        mainView.fadeIn()
    }
    
    fileprivate func setupView() {
        view = mainView
        mainView.setupView()
    }
}

extension CreateAboutViewController: NavigationControllerDelegate {
    
    fileprivate func setupNavigation() {
        navigator = NavigationController(navigationView: mainView.navigation, navigationController: navigationController)
        navigator?.delegate = self
    }
    
    func rightAction() {
        let vc = ViewControllerContainer.shared.getCreateAbout()
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    func backAction() {
        self.navigationController?.popViewController(animated: false)
    }
}
