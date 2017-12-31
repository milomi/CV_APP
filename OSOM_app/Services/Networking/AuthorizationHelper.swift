//
//  AuthorizationHelper.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 26.11.2017.
//

import Foundation
import SwiftyJSON

protocol AuthorizationHelper: class {
    var delegate: AuthorizationHelperDelegate? { get set }
    
    func requestAccessTokenFromRefreshToken()
    func requestClientCredentialsToken()
    func requestUserToken(user: SignUpUserModel)
    func logOut() 
}

protocol AuthorizationHelperDelegate: class {
    func tokenRefreshingDone(success: Bool)
    func handleClientCredentialsSuccess(success: Bool)
}

final class AuthorizationHelperImpl {
    
    weak var delegate: AuthorizationHelperDelegate?
    fileprivate let refreshNetworking: RefreshTokenNetworking
    fileprivate let authorizationNetworking: AuthorizationNetworking
    fileprivate let authorizationSerializer: AuthorizationSerializer
    
    init() {
        self.refreshNetworking = RefreshTokenNetworkingImpl()
        self.authorizationNetworking = AuthorizationNetworkingImpl()
        self.authorizationSerializer = AuthorizationSerializerImpl()
        self.refreshNetworking.delegate = self
        self.authorizationNetworking.delegate = self
    }
    
}

extension AuthorizationHelperImpl: AuthorizationHelper {
    func logOut() {
        NotificationCenter.default.post(name: .invalidToken, object: nil)
    }
    
    
    func requestAccessTokenFromRefreshToken() {
        refreshNetworking.getAccessTokenFromRefresh(parameters: authorizationSerializer.serializeRefreshToken())
    }
    
    func requestClientCredentialsToken() {
        authorizationNetworking.getTokenClientCredentials(parameters: authorizationSerializer.serializeAnonymusToken())
    }
    
    func requestUserToken(user: SignUpUserModel) {
        authorizationNetworking.getUserCredentials(parameters: authorizationSerializer.serializeLogin(user))
    }
    
}

extension AuthorizationHelperImpl: RefreshTokenNetworkingDelegate {
    
    func success(_ json: JSON) {
        if authorizationSerializer.unserialize(json: json) {
            delegate?.tokenRefreshingDone(success: true)
        } else {
            NSLog("error occured while getting token")
        }
    }
    
    func unknownErrorOccured() {
        delegate?.tokenRefreshingDone(success: false)
    }
    
    func noInternetConnection() {
        delegate?.tokenRefreshingDone(success: false)
    }
}

extension AuthorizationHelperImpl: AuthorizationNetworkingDelegate {
    func handleClientCredentialsSuccess(_ json: JSON) {
        if authorizationSerializer.unserializeAnonymusToken(json: json) {
            delegate?.handleClientCredentialsSuccess(success: true)
        } else {
            delegate?.handleClientCredentialsSuccess(success: false)
        }
    }
}
