//
//  NavigationController.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 22.10.2017.
//

import Foundation
import UIKit

fileprivate extension Selector {
    static let backAction = #selector(NavigationController.backAction)
    static let rightAction =  #selector(NavigationController.rightAction)
}

protocol NavigationControllerDelegate: class {
    func rightAction()
}

class NavigationController {
    
    weak var delegate: NavigationControllerDelegate?
    
    let view: NavigationView
    var navigationController: UINavigationController?
    
    init(navigationView: NavigationView, navigationController: UINavigationController?) {
        self.view = navigationView
        self.navigationController = navigationController
        setupNavigation()
    }
    
    private func setupNavigation() {
        view.leftButton.addTarget(self, action: .backAction, for: .touchUpInside)
        view.rightButton.addTarget(self, action: .rightAction, for: .touchUpInside)
    }
}

extension NavigationController {
    @objc func backAction() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func rightAction() {
        delegate?.rightAction()
    }
}
