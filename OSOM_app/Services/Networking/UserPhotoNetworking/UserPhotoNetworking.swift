//
//  UserPhotoNetworking.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 02.01.2018.
//

import Foundation
import SwiftyJSON
import Alamofire

protocol UserPhotoNetworking: class {
    
    weak var delegate: UserPhotoNetworkingDelegate? { get set }
    
    func getUserPhoto(url: String)
    
}

protocol UserPhotoNetworkingDelegate: class {
    func unknownErrorOccured()
    func noInternetConnection()
    func success(_ json: JSON)
}

final class UserPhotoNetworkingImpl: BaseNetworking {
    
    weak var delegate: UserPhotoNetworkingDelegate?
    
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

extension UserPhotoNetworkingImpl: UserPhotoNetworking {
    
    func getUserPhoto(url: String)  {
        makeRequest(request: getRequest(url: url))
    }
    
    fileprivate func getRequest(url: String) -> HTTPRequest {
        return HTTPRequest(url: url, method: .get, parameters: nil, encoding: JSONEncoding.default)
    }
}
