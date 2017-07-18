//
//  WelcomeScreenViewModel.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 18/07/2017.
//  Copyright © 2017 ITEO Sp. z o.o. All rights reserved.
//

import Foundation

fileprivate struct LocalizableKeys {
    static let welcomAppName = "welcome_title_label"
    static let welcomeTitle = "welcome_subtitle_label"
    static let welcomeEmployee = "welcome_employee__action"
    static let welcomeEmployer = "welcome_employer_action"
}

protocol WelcomeScreenViewModel: class {
    func getAppNameLabelText() -> String
    func getWelcomeLabelText() -> String
    func getSignInButtonText() -> String
    func getSignUpButtonText() -> String
}

class WelcomeScreenViewModelImpl: WelcomeScreenViewModel {
    
    func getAppNameLabelText() -> String {
        return LocalizableKeys.welcomAppName.localized()
    }
    
    func getWelcomeLabelText() -> String {
        return LocalizableKeys.welcomeTitle.localized()
    }
    
    func getSignInButtonText() -> String {
        return LocalizableKeys.welcomeEmployee.localized()
    }
    
    func getSignUpButtonText() -> String {
        return LocalizableKeys.welcomeEmployer.localized()
    }
}
