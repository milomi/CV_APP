//
//  AddSkillsNetworking.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 24.12.2017.
//

import Foundation
import SwiftyJSON
import Alamofire

protocol AddSkillsNetworking: class {
    
    weak var delegate: AddSkillsNetworkingDelegate? { get set }
    
    func setAddSkillsData(parameters: [String: Any])
}

protocol AddSkillsNetworkingDelegate: class {
    func unknownErrorOccured()
    func noInternetConnection()
    func successUploaded(_ json: JSON)
}

final class AddSkillsNetworkingImpl: BaseNetworking {
    
    weak var delegate: AddSkillsNetworkingDelegate?
    
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
            delegate?.successUploaded(json)
        } else {
            delegate?.unknownErrorOccured()
        }
    }
    
}

extension AddSkillsNetworkingImpl: AddSkillsNetworking {
    func setAddSkillsData(parameters: [String : Any]) {
        makeRequest(request: getRequest(parameters))
    }
    
    fileprivate func getRequest(_ parameters: [String: Any]? = nil) -> HTTPRequest {
        return HTTPRequest(url: getUrl(), method: .post, parameters: parameters, encoding: JSONEncoding.default)
    }
    
    fileprivate func getUrl() -> String {
        return Endpoints.baseUrl + Endpoints.skill
    }
    
}
