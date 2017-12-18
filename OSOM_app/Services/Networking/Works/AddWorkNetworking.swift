//
//  AddWorkNetworking.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 17.12.2017.
//

import Foundation
import SwiftyJSON
import Alamofire

protocol AddWorkNetworking: class {
    
    weak var delegate: AddWorkNetworkingDelegate? { get set }
    
    func setAddWorkData(parameters: [String: Any])
    func updateWorkData(parameters: [String : Any])
}

protocol AddWorkNetworkingDelegate: class {
    func unknownErrorOccured()
    func noInternetConnection()
    func success(_ json: JSON)
}

final class AddWorkNetworkingImpl: BaseNetworking {
    
    weak var delegate: AddWorkNetworkingDelegate?
    
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
            delegate?.unknownErrorOccured()
        }
    }
    
}

extension AddWorkNetworkingImpl: AddWorkNetworking {
    func setAddWorkData(parameters: [String : Any]) {
        makeRequest(request: getRequest(parameters))
    }
    
    func updateWorkData(parameters: [String : Any]) {
        makeRequest(request: getRequest(parameters, method: .put))
    }
    
    fileprivate func getRequest(_ parameters: [String: Any]? = nil, method: HTTPMethod = .post) -> HTTPRequest {
        return HTTPRequest(url: getUrl(), method: method, parameters: parameters, encoding: JSONEncoding.default)
    }
    
    fileprivate func getUrl() -> String {
        return Endpoints.baseUrl + Endpoints.work
    }
    
}
