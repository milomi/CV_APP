//
//  AddSkillSectionNetworking.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 18.12.2017.
//

import Foundation
import SwiftyJSON
import Alamofire

protocol AddSkillsSectionNetworking: class {
    
    weak var delegate: AddSkillsSectionNetworkingDelegate? { get set }
    
    func setAddSkillsSectionData(parameters: [String: Any])
    func updateWorkData(parameters: [String : Any])
}

protocol AddSkillsSectionNetworkingDelegate: class {
    func unknownErrorOccured()
    func noInternetConnection()
    func success(_ json: JSON)
}

final class AddSkillsSectionNetworkingImpl: BaseNetworking {
    
    weak var delegate: AddSkillsSectionNetworkingDelegate?
    
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

extension AddSkillsSectionNetworkingImpl: AddSkillsSectionNetworking {
    func setAddSkillsSectionData(parameters: [String : Any]) {
        makeRequest(request: getRequest(parameters))
    }
    
    func updateWorkData(parameters: [String : Any]) {
        makeRequest(request: getRequest(parameters, method: .put))
    }
    
    fileprivate func getRequest(_ parameters: [String: Any]? = nil, method: HTTPMethod = .post) -> HTTPRequest {
        return HTTPRequest(url: getUrl(), method: method, parameters: parameters, encoding: JSONEncoding.default)
    }
    
    fileprivate func getUrl() -> String {
        return Endpoints.baseUrl + Endpoints.section
    }
    
}
