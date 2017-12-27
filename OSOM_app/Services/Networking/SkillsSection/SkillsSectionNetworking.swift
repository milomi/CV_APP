//
//  SkillsSectionNetworking.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 18.12.2017.
//

import Foundation
import SwiftyJSON
import Alamofire

protocol SkillsSectionsNetworking: class {
    
    weak var delegate: SkillsSectionsNetworkingDelegate? { get set }
    
    func getSkillsSections()
}

protocol SkillsSectionsNetworkingDelegate: class {
    func unknownErrorOccured()
    func noInternetConnection()
    func skillsSectionsDownloaded(_ json: JSON)
}

final class SkillsSectionsNetworkingImpl: BaseNetworking {
    
    weak var delegate: SkillsSectionsNetworkingDelegate?
    
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
            delegate?.skillsSectionsDownloaded(json)
        } else {
            delegate?.unknownErrorOccured()
        }
    }
    
}

extension SkillsSectionsNetworkingImpl: SkillsSectionsNetworking {
    func getSkillsSections() {
        makeRequest(request: getRequest())
    }
    
    fileprivate func getRequest(_ parameters: [String: Any]? = nil) -> HTTPRequest {
        return HTTPRequest(url: getUrl(), method: .get, parameters: parameters, encoding: JSONEncoding.default)
    }
    
    fileprivate func getUrl() -> String {
        return Endpoints.baseUrl + Endpoints.sections
    }
    
}
