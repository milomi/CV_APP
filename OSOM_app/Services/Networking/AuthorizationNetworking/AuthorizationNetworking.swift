//
//  AuthorizationNetworking.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 26.11.2017.
//

import Foundation
import SwiftyJSON
import Alamofire

protocol AuthorizationNetworking: class {
    
    weak var delegate: AuthorizationNetworkingDelegate? { get set }
    
    func getTokenClientCredentials(parameters: [String: Any])
}

protocol AuthorizationNetworkingDelegate: class {
    func unknownErrorOccured()
    func noInternetConnection()
    func handleClientCredentialsSuccess(_ json: JSON)
}

final class AuthorizationNetworkingImpl: BaseNetworking {
    
    weak var delegate: AuthorizationNetworkingDelegate? {
        didSet {
            print("Delegate set")
        }
    }
    
    override func handleUnknownError() {
        delegate?.unknownErrorOccured()
    }
    
    override func handleResponseNoInternetConnection() {
        delegate?.noInternetConnection()
    }
    
    override func handleResponseBadRequest(json: JSON?) {
        delegate?.unknownErrorOccured()
    }
    
    override func handleResponseSuccess(json: JSON?) {
        if let json = json {
            delegate?.handleClientCredentialsSuccess(json)
        } else {
            print("error")
        }
    }
    
}

extension AuthorizationNetworkingImpl: AuthorizationNetworking {
    
    func getTokenClientCredentials(parameters: [String: Any]) {
        makeRequest(request: getRequest(parameters))
    }
    
    fileprivate func getRequest(_ parameters: [String: Any]? = nil) -> HTTPRequest {
        return HTTPRequest(url: getUrl(), method: .post, parameters: parameters, encoding: URLEncoding.default)
    }
    
    fileprivate func getUrl() -> String {
        return Endpoints.baseUrl + Endpoints.login
    }
    
}
