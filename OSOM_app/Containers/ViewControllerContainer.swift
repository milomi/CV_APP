//
//  ViewControllerContainer.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 18/07/2017.
//  Copyright © 2017 ITEO Sp. z o.o. All rights reserved.
//

import Foundation
import UIKit

class ViewControllerContainer {
    
    fileprivate let viewModelContainer = ViewModelContainer()
    fileprivate let viewContainer = ViewContainer()
    fileprivate let cellManagerContainer = CellManagerContainer()
    
    static let shared = ViewControllerContainer()
    
    func getWelcome() -> WelcomeScreenViewController {
        return WelcomeScreenViewController(viewModel: viewModelContainer.getWelcome(), mainView: viewContainer.getWelcome())
    }
    
    func getSignUpName() -> SignUpNameViewController {
        let view = ViewContainer.shared.signUpName()
        return SignUpNameViewController(mainView: view)
    }
    
}
