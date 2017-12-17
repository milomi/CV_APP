//
//  ViewModelContainer.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 18/07/2017.
//  Copyright © 2017 ITEO Sp. z o.o. All rights reserved.
//

import Foundation

class ViewModelContainer {
    
    func getWelcome() -> WelcomeScreenViewModel {
        return WelcomeScreenViewModelImpl()
    }
    
    func getEmail(user: SignUpUserModel) -> SignUpEmailViewModel {
        let repository = RepositoryContainer.shared.getSignUp()

        return SignUpEmailViewModelImpl(user: user, repository: repository)
    }
    
    func getPassword(user: SignUpUserModel) -> SignUpPasswordViewModel {
        let repository = RepositoryContainer.shared.getSignUp()
        return SignUpPasswordViewModelImpl(user: user, repository: repository)
    }
    
    func getCreateAbout() -> CreateAboutViewModel {
        let repository = RepositoryContainer.shared.getCreateAbout()
        return CreateAboutViewModelImpl(repository: repository)
    }
    
    func getLogin() -> LoginViewModel {
        let repository = RepositoryContainer.shared.getLogin()
        return LoginViewModelImpl(repository: repository)
    }
    
    func getAddEduction() -> AddEducationViewModelImpl {
        let repository = RepositoryContainer.shared.getAddEducation()
        return AddEducationViewModelImpl(repository: repository)
    }
    
    func getAddEductionDetail(_ schoolId: Int?) -> AddEducationDetailViewModelImpl {
        let repository = RepositoryContainer.shared.getAddEducation()
        return AddEducationDetailViewModelImpl(schoolId: schoolId, repository: repository)
    }
    
}
