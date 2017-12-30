//
//  CVNetworking.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 30.12.2017.
//

import Foundation
import SwiftyJSON
import Alamofire

protocol CVNetworking: class {
    
    weak var delegate: CVNetworkingDelegate? { get set }
    
    func getCVData(url: String)
}

protocol CVNetworkingDelegate: class {
    func unknownErrorOccured()
    func noInternetConnection()
    func success(_ json: JSON)
}

final class CVNetworkingImpl: BaseNetworking {
    
    weak var delegate: CVNetworkingDelegate?
    
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

extension CVNetworkingImpl: CVNetworking {
    func getCVData(url: String) {
        makeRequest(request: getRequest(url))
    }
    
    fileprivate func getRequest(_ url: String) -> HTTPRequest {
        return HTTPRequest(url: "https://carrierviewer.azurewebsites.net/api/cv/9e39c996-95bf-44ff-904f-3dc32ec7348b", method: .get, parameters: nil, encoding: JSONEncoding.default)
    }
    
    
}
