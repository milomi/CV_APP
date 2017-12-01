//
//  UserRepository.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 26.11.2017.
//

import Foundation

import SwiftyJSON
import Foundation

protocol SignUpRepositoryDelegate: class {
    func accountRegistered()
    func errorOccured(_ error: String?)
    func noInternetConnection()
    func unknownErrorOccured()
}

protocol EmailValidatorDelegate: class {
    func badEmail(_ response: String)
    func emailIsAvailable()
}

protocol SignUpRepository: class {
    weak var delegate: SignUpRepositoryDelegate? { get set }
    weak var emailValidatorDelegate: EmailValidatorDelegate? { get set }
    
    func checkEmail(email: String)
    func register(signUpUser: SignUpUserModel)
}

class SignUpRepositoryImpl: SignUpRepository {
    
    weak var delegate: SignUpRepositoryDelegate?
    weak var emailValidatorDelegate: EmailValidatorDelegate?
    
    fileprivate var emailValidationNetworking: EmailValidationNetworking
    fileprivate var emailValidationSerializer: EmailValidationSerializer
    fileprivate var signUpNetworking: SignUpNetworking
    fileprivate var authorizationSerializer: AuthorizationSerializer
    
    
    init(emailValidationNetworking: EmailValidationNetworking,
         emailValidationSerializer: EmailValidationSerializer,
         signUpNetworking: SignUpNetworking,
         authorizationSerializer: AuthorizationSerializer) {
        self.emailValidationNetworking = emailValidationNetworking
        self.emailValidationSerializer = emailValidationSerializer
        self.signUpNetworking = signUpNetworking
        self.authorizationSerializer = authorizationSerializer
        setupDelegates()
    }
    
    func checkEmail(email: String) {
        emailValidationNetworking.validateEmail(parameters: emailValidationSerializer.serialize(email))
    }
    
    func register(signUpUser user: SignUpUserModel) {
        signUpNetworking.signUp(parameters: authorizationSerializer.serializeSignUp(user))
    }
    
    fileprivate func setupDelegates() {
        emailValidationNetworking.delegate = self
        signUpNetworking.delegate = self
    }
    
}

extension SignUpRepositoryImpl: EmailValidationNetworkingDelegate {
    
    func emailIsAvailable() {
        emailValidatorDelegate?.emailIsAvailable()
    }
    
    func errorOccured(_ json: JSON) {
        delegate?.unknownErrorOccured()
        emailValidatorDelegate?.badEmail("Bad email")
    }
    
    func noInternetConnection() {
        delegate?.noInternetConnection()
        emailValidatorDelegate?.badEmail("Bad email")
    }
    
    func unknownErrorOccured() {
        delegate?.unknownErrorOccured()
        emailValidatorDelegate?.badEmail("Bad email")
        
    }
}


extension SignUpRepositoryImpl: SignUpNetworkingDelegate {
    
    func registered(_ json: JSON) {
        if authorizationSerializer.unserialize(json: json) {
            delegate?.accountRegistered()
        } else {
            delegate?.unknownErrorOccured()
        }
    }
    
}

