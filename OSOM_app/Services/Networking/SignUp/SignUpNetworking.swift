//
//  SignUpNetworking.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 26.11.2017.
//

import Foundation
import SwiftyJSON

protocol SignUpNetworking: class {
    weak var delegate: SignUpNetworkingDelegate? { get set }
    
    func signUp(parameters: [String: Any])
}

protocol SignUpNetworkingDelegate: class {
    func unknownErrorOccured()
    func errorOccured(_ json: JSON)
    func noInternetConnection()
    func registered(_ json: JSON)
}

class SignUpNetworkingImpl: BaseNetworking {
    
    weak var delegate: SignUpNetworkingDelegate?
    
    override func handleUnknownError() {
        delegate?.unknownErrorOccured()
    }
    
    override func handleResponseNoInternetConnection() {
        delegate?.noInternetConnection()
    }
    
    override func handleResponseBadRequest(json: JSON?) {
        if let json = json {
            delegate?.errorOccured(json)
        } else {
            delegate?.unknownErrorOccured()
        }
    }
    
    override func handleResponseSuccess(json: JSON?) {
        if let json = json {
            delegate?.registered(json)
        } else {
            delegate?.unknownErrorOccured()
        }
    }
    
}

extension SignUpNetworkingImpl: SignUpNetworking {
    
    func signUp(parameters: [String: Any]) {
        makeRequest(request: getRequest(parameters: parameters))
    }
    
    fileprivate func getRequest(parameters: [String: Any]) -> HTTPRequest {
        return HTTPRequest(url: getUrl(), method: .post, parameters: parameters)
    }
    
    fileprivate func getUrl() -> String {
        return Endpoints.baseUrl + Endpoints.register
    }
    
}
