//
//  WorksNetworking.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 17.12.2017.
//

import Foundation
import SwiftyJSON
import Alamofire

protocol WorksNetworking: class {
    
    weak var delegate: WorksNetworkingDelegate? { get set }
    
    func getWorks()
}

protocol WorksNetworkingDelegate: class {
    func unknownErrorOccured()
    func noInternetConnection()
    func worksDownloaded(_ json: JSON)
}

final class WorksNetworkingImpl: BaseNetworking {
    
    weak var delegate: WorksNetworkingDelegate?
    
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
            delegate?.worksDownloaded(json)
        } else {
            delegate?.unknownErrorOccured()
        }
    }
    
}

extension WorksNetworkingImpl: WorksNetworking {
    func getWorks() {
        makeRequest(request: getRequest())
    }
    
    fileprivate func getRequest(_ parameters: [String: Any]? = nil) -> HTTPRequest {
        return HTTPRequest(url: getUrl(), method: .get, parameters: parameters, encoding: JSONEncoding.default)
    }
    
    fileprivate func getUrl() -> String {
        return Endpoints.baseUrl + Endpoints.works
    }
    
}
