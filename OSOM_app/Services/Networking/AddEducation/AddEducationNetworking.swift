//
//  AddEducationNetworking.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 02.12.2017.
//

import Foundation
import SwiftyJSON
import Alamofire

protocol AddEducationNetworking: class {
    
    weak var delegate: AddEducationNetworkingDelegate? { get set }
    
    func setAddEducationData(parameters: [String: Any])
    func updateEducationData(parameters: [String : Any])
}

protocol AddEducationNetworkingDelegate: class {
    func unknownErrorOccured()
    func noInternetConnection()
    func success(_ json: JSON)
}

final class AddEducationNetworkingImpl: BaseNetworking {
    
    weak var delegate: AddEducationNetworkingDelegate?
    
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

extension AddEducationNetworkingImpl: AddEducationNetworking {
    func setAddEducationData(parameters: [String : Any]) {
        makeRequest(request: getRequest(parameters))
    }
    
    func updateEducationData(parameters: [String : Any]) {
        makeRequest(request: getRequest(parameters, method: .put))
    }
    
    fileprivate func getRequest(_ parameters: [String: Any]? = nil, method: HTTPMethod = .post) -> HTTPRequest {
        return HTTPRequest(url: getUrl(), method: method, parameters: parameters, encoding: JSONEncoding.default)
    }
    
    fileprivate func getUrl() -> String {
        return Endpoints.baseUrl + Endpoints.education
    }
    
}
