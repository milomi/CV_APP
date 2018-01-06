//
//  CreateAboutNetworking.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 13.12.2017.
//

import Foundation
import SwiftyJSON
import Alamofire


protocol CreateAboutNetworkingDelegate: class {
    func unknownErrorOccured()
    func noInternetConnection()
    func createdSuccess(_ json: JSON)
}

protocol CreateAboutNetworking: class {
    weak var delegate: CreateAboutNetworkingDelegate? { get set }

    func postPersonalData(parameters: [String: Any])
}

final class CreateAboutNetworkingImpl: BaseNetworking {
    
    weak var delegate: CreateAboutNetworkingDelegate?
    
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
            delegate?.createdSuccess(json)
        } else {
            delegate?.unknownErrorOccured()
        }
    }
    
}

extension CreateAboutNetworkingImpl: CreateAboutNetworking {
    func postPersonalData(parameters: [String : Any]) {
        makeRequest(request: getRequest(.post, parameters))
    }
    
    fileprivate func getRequest(_ method: HTTPMethod, _ parameters: [String: Any]? = nil) -> HTTPRequest {
        return HTTPRequest(url: getUrl(), method: method, parameters: parameters, encoding: JSONEncoding.default)
    }
    
    fileprivate func getUrl() -> String {
        return Endpoints.baseUrl + Endpoints.personal
    }
    
}
