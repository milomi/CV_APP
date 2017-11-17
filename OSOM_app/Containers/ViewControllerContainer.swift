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
    
    func getSignUpEmail() -> SignUpEmailViewController {
        let view = ViewContainer.shared.signUpEmail()
        return SignUpEmailViewController(mainView: view)
    }
    
    func getSignUpPassword() -> SignUpPasswordViewController {
        let view = ViewContainer.shared.signUpPassword()
        return SignUpPasswordViewController(mainView: view)
    }
    
    func getLogIn() -> LogInViewController {
        let view = ViewContainer.shared.logIn()
        return LogInViewController(mainView: view)
    }
    
    func getCreateAbout() -> CreateAboutViewController {
        let view = ViewContainer.shared.createAbout()
        return CreateAboutViewController(view: view)
    }
    
    func getAddEducation() -> AddEducationViewController {
        let view = viewContainer.addEducation()
        let cellManager = AddEducationCellManagerImpl(tableView: view.tableView)
        return AddEducationViewController(view: view, cellManager: cellManager)
    }
    
    func getAddEducationDetail() -> AddEducationDetailViewController {
        let view = viewContainer.addEducation()
        let cellManager = AddEducationDetailCellManagerImpl(tableView: view.tableView)
        return AddEducationDetailViewController(view: view, cellManager: cellManager)
    }
    
    func getAddWorkplace() -> AddWorkplaceViewController {
        let view = viewContainer.addWorkplace()
        let cellManager = AddWorkplaceCellManagerImpl(tableView: view.tableView)
        return AddWorkplaceViewController(view: view, cellManager: cellManager)
    }
    
    func getAddWorkplaceDetail() -> AddWorkplaceDetailViewController {
        let view = viewContainer.addWorkplace()
        let cellManager = AddWorkplaceDetailCellManagerImpl(tableView: view.tableView)
        return AddWorkplaceDetailViewController(view: view, cellManager: cellManager)
    }
    
}
