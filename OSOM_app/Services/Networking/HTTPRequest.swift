//
//  HTTPRequest.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 26.11.2017.
//

import Foundation
import Foundation
import Alamofire

final class HTTPRequest: CustomDebugStringConvertible {
    
    var url: URLConvertible
    var method: HTTPMethod
    var parameters: Alamofire.Parameters?
    var data: Data?
    var headers: HTTPHeaders?
    var numberOfUnauthorizedResponses: Int
    var encoding: ParameterEncoding
    
    var debugDescription: String {
        return "URL - \(url) METHOD - \(method) PARAMETERS - \(String(describing: parameters)) HEADERS - \(String(describing: headers))"
    }
    
    init(url: URLConvertible, method: HTTPMethod, parameters: Alamofire.Parameters?, encoding: ParameterEncoding = JSONEncoding.default) {
        self.url = url
        self.method = method
        self.parameters = parameters
        self.numberOfUnauthorizedResponses = 0
        self.encoding = encoding        
    }
    
}
