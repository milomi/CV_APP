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
    
    func getSignUpEmail(user: SignUpUserModel) -> SignUpEmailViewController {
        let view = ViewContainer.shared.signUpEmail()
        let viewModel = viewModelContainer.getEmail(user: user)
        return SignUpEmailViewController(mainView: view, viewModel: viewModel)
    }
    
    func getSignUpPassword(user: SignUpUserModel) -> SignUpPasswordViewController {
        let view = ViewContainer.shared.signUpPassword()
        let viewModel = viewModelContainer.getPassword(user: user)
        return SignUpPasswordViewController(mainView: view, viewModel: viewModel)
    }
    
    func getLogIn() -> LogInViewController {
        let view = ViewContainer.shared.logIn()
        return LogInViewController(mainView: view)
    }
    
    func getCreateAbout() -> CreateAboutViewController {
        let view = ViewContainer.shared.createAbout()
        let viewModel = viewModelContainer.getCreateAbout()
        return CreateAboutViewController(view: view, viewModel: viewModel)
    }
    
    func getAddEducation() -> AddEducationViewController {
        let view = viewContainer.addEducation()
        let cellManager = AddEducationCellManagerImpl(tableView: view.tableView)
        return AddEducationViewController(view: view, cellManager: cellManager, viewModel: AddEducationViewModelImpl())
    }
    
    func getAddEducationDetail() -> AddEducationDetailViewController {
        let view = viewContainer.addEducation()
        let cellManager = AddEducationDetailCellManagerImpl(tableView: view.tableView)
        return AddEducationDetailViewController(view: view, cellManager: cellManager)
    }
    
    func getAddWorkplace() -> AddWorkplaceViewController {
        let view = viewContainer.addWorkplace()
        let cellManager = AddWorkplaceCellManagerImpl(tableView: view.tableView)
        return AddWorkplaceViewController(view: view, cellManager: cellManager, viewModel: AddWorkplaceViewModelImpl())
    }
    
    func getAddWorkplaceDetail() -> AddWorkplaceDetailViewController {
        let view = viewContainer.addWorkplace()
        let cellManager = AddWorkplaceDetailCellManagerImpl(tableView: view.tableView)
        return AddWorkplaceDetailViewController(view: view, cellManager: cellManager)
    }
    
    func getAddSkills() -> AddSkillsViewController {
        let view = viewContainer.addSkills()
        let cellManager = AddSkillsCellManagerImpl(tableView: view.tableView)
        return AddSkillsViewController(view: view, cellManager: cellManager, viewModel: AddSkillsViewModelImpl())
    }
    
    func getAddSkillsDetail() -> AddSkillsDetailViewController {
        let view = viewContainer.addSkills()
        let cellManager = AddSkillsDetailCellManagerImpl(tableView: view.tableView)
        return AddSkillsDetailViewController(view: view, cellManager: cellManager)
    }
    
    func getAddContactsDetail() -> AddContactsDetailViewController {
        let view = viewContainer.addContacts()
        let cellManager = AddContactsDetailCellManagerImpl(tableView: view.tableView)
        return AddContactsDetailViewController(view: view, cellManager: cellManager)
    }
    
    func getHelloViewController() -> HelloViewController {
        let view = HelloView()
        
        return HelloViewController(mainView: view)
    }
    
}
