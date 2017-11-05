//
//  ViewContainer.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 18/07/2017.
//  Copyright © 2017 ITEO Sp. z o.o. All rights reserved.
//

import Foundation

class ViewContainer {
    
    static let shared = ViewContainer()
    
    func getWelcome() -> WelcomeView {
        return WelcomeView()
    }
    
    func signUpName() -> SignUpNameView {
        return SignUpNameView()
    }
    
    func signUpEmail() -> SignUpEmailView {
        return SignUpEmailView()
    }
    
    func signUpPassword() -> SignUpPasswordView {
        return SignUpPasswordView()
    }
    
    func logIn() -> LogInView {
        return LogInView()
    }
    
    func createAbout() -> CreateAboutView {
        return CreateAboutView()
    }
    
    func addEducation() -> AddEducationView {
        return AddEducationView()
    }
}
