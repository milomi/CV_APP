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
        return SignUpEmailViewModelImpl(user: user, repository: RepositoryContainer.shared.getSignUp())
    }
    
}
