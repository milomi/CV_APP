//
//  PersonalNetworking.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 02.12.2017.
//

import Foundation
import SwiftyJSON
import Alamofire

protocol PersonalNetworking: class {
    
    weak var delegate: PersonalNetworkingDelegate? { get set }
    
    func setPersonalData(parameters: [String: Any])
}

protocol PersonalNetworkingDelegate: class {
    func unknownErrorOccured()
    func noInternetConnection()
    func success(_ json: JSON)
}

final class PersonalNetworkingImpl: BaseNetworking {
    
    weak var delegate: PersonalNetworkingDelegate?
    
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

extension PersonalNetworkingImpl: PersonalNetworking {
    func setPersonalData(parameters: [String : Any]) {
        makeRequest(request: getRequest(parameters))
    }
    
    fileprivate func getRequest(_ parameters: [String: Any]? = nil) -> HTTPRequest {
        return HTTPRequest(url: getUrl(), method: .post, parameters: parameters, encoding: JSONEncoding.default)
    }
    
    fileprivate func getUrl() -> String {
        return Endpoints.baseUrl + Endpoints.personal
    }
    
}
