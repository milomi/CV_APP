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
        let viewModel = viewModelContainer.getLogin()
        return LogInViewController(mainView: view, viewModel: viewModel)
    }
    
    func getCreateAbout() -> CreateAboutViewController {
        let view = ViewContainer.shared.createAbout()
        let viewModel = viewModelContainer.getCreateAbout()
        return CreateAboutViewController(view: view, viewModel: viewModel)
    }
    
    func getAddEducation() -> AddEducationViewController {
        let view = viewContainer.addEducation()
        let cellManager = AddEducationCellManagerImpl(tableView: view.tableView)
        let viewModel = viewModelContainer.getAddEduction()
        return AddEducationViewController(view: view, cellManager: cellManager, viewModel: viewModel)
    }
    
    func getAddEducationDetail(schoolId: Int? = nil) -> AddEducationDetailViewController {
        let view = viewContainer.addEducation()
        let cellManager = AddEducationDetailCellManagerImpl(tableView: view.tableView)
        let viewModel = viewModelContainer.getAddEductionDetail(schoolId)
        return AddEducationDetailViewController(view: view, viewModel: viewModel, cellManager: cellManager)
    }
    
    func getAddWorkplace() -> AddWorkplaceViewController {
        let view = viewContainer.addWorkplace()
        let cellManager = AddWorkplaceCellManagerImpl(tableView: view.tableView)
        let repository = RepositoryContainer.shared.getAddWork()
        return AddWorkplaceViewController(view: view, cellManager: cellManager, viewModel: AddWorkplaceViewModelImpl(repository: repository))
    }
    
    func getAddWorkplaceDetail(workId: Int? = nil) -> AddWorkplaceDetailViewController {
        let view = viewContainer.addWorkplace()
        let cellManager = AddWorkplaceDetailCellManagerImpl(tableView: view.tableView)
        let viewModel = viewModelContainer.getAddWorkDetail(workId)
        return AddWorkplaceDetailViewController(view: view, viewModel: viewModel, cellManager: cellManager)
    }
    
    func getAddSkills() -> AddSkillsViewController {
        let view = viewContainer.addSkills()
        let cellManager = AddSkillsCellManagerImpl(tableView: view.tableView)
        let repository = RepositoryContainer.shared.getSkillsSection()
        let viewModel = AddSkillsViewModelImpl(repository: repository)
        return AddSkillsViewController(view: view, cellManager: cellManager, viewModel: viewModel)
    }
    
    func getAddSkillsDetail(_ sectionId: Int) -> AddSkillsDetailViewController {
        let view = viewContainer.addSkills()
        let cellManager = AddSkillsDetailCellManagerImpl(tableView: view.tableView)
        let viewModel = viewModelContainer.getSkillDetails(sectionId)
        return AddSkillsDetailViewController(view: view, viewModel: viewModel, cellManager: cellManager)
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
    
    func getQRCodeReader() -> QRReaderViewController {        
        return QRReaderViewController()
    }
    
    func getAbout() -> AboutViewController {
        let view = AboutView()
        let viewModel = AboutViewModelImpl(repository: UserDBRepositoryImpl())
        return AboutViewController(view: view, viewModel: viewModel)
    }
    
    func getEducation() -> EducationViewController {
        let view = EducationView()
        let viewModel = EducationViewModelImpl(repository: SchoolDBRepositoryImpl())
        let cellManager = EducationCellManagerImpl(tableView: view.tableView)
    
        
        return EducationViewController(view: view, cellManager: cellManager, viewModel: viewModel)
    }
    
    func getWork() -> WorkViewController {
        let view = WorkView()
        let viewModel = WorkViewModelImpl(repository: WorkDBRepositoryImpl())
        let cellManager = WorkCellManagerImpl(tableView: view.tableView)
        
        
        return WorkViewController(view: view, cellManager: cellManager, viewModel: viewModel)
    }
    
    func getSkills() -> SkillsViewController {
        let view = SkillsView()
        let viewModel = SkillsViewModelImpl(repository: SkillsSectionDBRepositoryImpl())
        let cellManager = SkillsCellManagerImpl(tableView: view.tableView)
        
        
        return SkillsViewController(view: view, cellManager: cellManager, viewModel: viewModel)
    }
    
}
