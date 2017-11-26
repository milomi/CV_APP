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
}

protocol AuthorizationHelperDelegate: class {
    func tokenRefreshingDone(success: Bool)
}

final class AuthorizationHelperImpl {
    
    weak var delegate: AuthorizationHelperDelegate?
    fileprivate let authNetworking: AuthorizationNetworking
    fileprivate let authorizationSerializer: AuthorizationSerializer
    
    init() {
        self.authNetworking = AuthorizationNetworkingImpl()
        self.authorizationSerializer = AuthorizationSerializerImpl()
        self.authNetworking.delegate = self
    }
    
}

extension AuthorizationHelperImpl: AuthorizationHelper {
    
    func requestAccessTokenFromRefreshToken() {
        authNetworking.getAccessTokenFromRefresh(parameters: authorizationSerializer.serializeRefreshToken())
    }
    
}

extension AuthorizationHelperImpl: AuthorizationNetworkingDelegate {
    
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
