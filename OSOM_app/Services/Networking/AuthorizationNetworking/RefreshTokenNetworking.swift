//
//  RefreshTokenNetworking.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 26.11.2017.
//

import Foundation
import SwiftyJSON
import Alamofire

protocol RefreshTokenNetworking: class {
    
    weak var delegate: RefreshTokenNetworkingDelegate? { get set }
    
    func getAccessTokenFromRefresh(parameters: [String: Any])
}

protocol RefreshTokenNetworkingDelegate: class {
    func unknownErrorOccured()
    func noInternetConnection()
    func success(_ json: JSON)
}

final class RefreshTokenNetworkingImpl: BaseNetworking {
    
    weak var delegate: RefreshTokenNetworkingDelegate?
    
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
            delegate?.success(json)
        } else {
            print("error")
        }
    }
    
}

extension RefreshTokenNetworkingImpl: RefreshTokenNetworking {
    
    func getAccessTokenFromRefresh(parameters: [String: Any]) {
        makeRequest(request: getRequest(parameters))
    }
    
    fileprivate func getRequest(_ parameters: [String: Any]? = nil) -> HTTPRequest {
        return HTTPRequest(url: getUrl(), method: .post, parameters: parameters, encoding: URLEncoding.default)
    }
    
    fileprivate func getUrl() -> String {
        return Endpoints.baseUrl + Endpoints.refreshToken
    }
    
}
