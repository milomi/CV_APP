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
        let networking = PersonalNetworkingImpl()
        let serializer = PersonalSerializerImpl()
        return CreateAboutViewModelImpl(networking: networking, serializer: serializer)
    }
    
}
