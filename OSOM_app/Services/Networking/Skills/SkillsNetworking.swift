//
//  SkillsNetworking.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 02.12.2017.
//

import Foundation
import SwiftyJSON
import Alamofire

protocol SkillsNetworking: class {
    
    weak var delegate: SkillsNetworkingDelegate? { get set }
    
    func setSkillsData(parameters: [String: Any])
}

protocol SkillsNetworkingDelegate: class {
    func unknownErrorOccured()
    func noInternetConnection()
    func success(_ json: JSON)
}

final class SkillsNetworkingImpl: BaseNetworking {
    
    weak var delegate: SkillsNetworkingDelegate?
    
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

extension SkillsNetworkingImpl: SkillsNetworking {
    func setSkillsData(parameters: [String : Any]) {
        makeRequest(request: getRequest(parameters))
    }
    
    fileprivate func getRequest(_ parameters: [String: Any]? = nil) -> HTTPRequest {
        return HTTPRequest(url: getUrl(), method: .post, parameters: parameters, encoding: JSONEncoding.default)
    }
    
    fileprivate func getUrl() -> String {
        return Endpoints.baseUrl + Endpoints.skill
    }
    
}
