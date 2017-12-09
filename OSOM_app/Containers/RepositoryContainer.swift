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
    

    func getLogin() -> LoginRepository {
        let networking = AuthorizationNetworkingImpl()
        let serializer = AuthorizationSerializerImpl()
        return LoginRepositoryImpl(authorizationNetworking: networking, authorizationSerializer: serializer)
    }
    
    func getAddEducation() -> AddEducationRepository {
        let dbRepository = SchoolDBRepositoryImpl()
        let networking = AddEducationNetworkingImpl()
        let serializer = EducationSerializerImpl()
        return AddEducationRepositoryImpl(schoolDBRepository: dbRepository, networking: networking, serializer: serializer)
    }
}
