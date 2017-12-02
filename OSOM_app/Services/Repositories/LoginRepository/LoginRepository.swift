//
//  LoginRepository.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 02.12.2017.
//

import Foundation
import SwiftyJSON
import Foundation

protocol LoginRepositoryDelegate: class {
    func loginSuccessed()
    func errorOccured(_ error: String?)
    func noInternetConnection()
    func unknownErrorOccured()
}

protocol LoginRepository: class {
    weak var delegate: LoginRepositoryDelegate? { get set }
    
    func login(loginUser: SignUpUserModel)
}

class LoginRepositoryImpl: LoginRepository {
    
    weak var delegate: LoginRepositoryDelegate?
    
    fileprivate var authorizationNetworking: AuthorizationNetworking
    fileprivate var authorizationSerializer: AuthorizationSerializer
    
    
    init(authorizationNetworking: AuthorizationNetworking,
        authorizationSerializer: AuthorizationSerializer) {
        self.authorizationNetworking = authorizationNetworking
        self.authorizationSerializer = authorizationSerializer
        setupDelegates()
    }
    
    func login(loginUser: SignUpUserModel) {
        authorizationNetworking.getUserCredentials(parameters: authorizationSerializer.serializeLogin(loginUser))
    }
    
    fileprivate func setupDelegates() {
        authorizationNetworking.delegate = self
    }
    
}

extension LoginRepositoryImpl: AuthorizationNetworkingDelegate {
    func handleClientCredentialsSuccess(_ json: JSON) {
        if authorizationSerializer.unserialize(json: json) {
            delegate?.loginSuccessed()
        } else {
            delegate?.unknownErrorOccured()
        }
    }
    
    func errorOccured(_ json: JSON) {
        delegate?.unknownErrorOccured()
    }
    
    func noInternetConnection() {
        delegate?.noInternetConnection()
    }
    
    func unknownErrorOccured() {
        delegate?.unknownErrorOccured()
        
    }
}


