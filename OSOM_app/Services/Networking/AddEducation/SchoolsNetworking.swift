//
//  SchoolsNetworking.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 16.12.2017.
//

import Foundation
import SwiftyJSON
import Alamofire

protocol SchoolsNetworking: class {
    
    weak var delegate: SchoolsNetworkingDelegate? { get set }
    
    func getSchools()
}

protocol SchoolsNetworkingDelegate: class {
    func unknownErrorOccured()
    func noInternetConnection()
    func schoolsDownloaded(_ json: JSON)
}

final class SchoolsNetworkingImpl: BaseNetworking {
    
    weak var delegate: SchoolsNetworkingDelegate?
    
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
            delegate?.schoolsDownloaded(json)
        } else {
            print("error")
        }
    }
    
}

extension SchoolsNetworkingImpl: SchoolsNetworking {
    func getSchools() {
        makeRequest(request: getRequest())
    }
    
    fileprivate func getRequest(_ parameters: [String: Any]? = nil) -> HTTPRequest {
        return HTTPRequest(url: getUrl(), method: .get, parameters: parameters, encoding: JSONEncoding.default)
    }
    
    fileprivate func getUrl() -> String {
        return Endpoints.baseUrl + Endpoints.schools
    }
    
}
