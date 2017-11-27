//
//  RepositoryContainer.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 26.11.2017.
//

import Foundation
import UIKit

class RepositoryContainer {
    
    static let shared = RepositoryContainer()
    
    func getSignUp() -> SignUpRepository {
        return SignUpRepositoryImpl(emailValidationNetworking: EmailValidationNetworkingImpl(), emailValidationSerializer: EmailValidationSerializerImpl(), signUpNetworking: SignUpNetworkingImpl(), authorizationSerializer: AuthorizationSerializerImpl())
    }
}
