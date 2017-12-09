//
//  BaseNetworking.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 26.11.2017.
//

import Foundation
import SwiftyJSON
import Alamofire
import SwiftyBeaver

fileprivate struct Constants {
    static let maxNumberOfUnauthorizedRequests = 3
}

protocol Networking {
    func handleResponseSuccess(json: JSON?)
    func handleResponseBadRequest(json: JSON?)
    func handleResponseUnauthorized(request: HTTPRequest)
    func handleUploadProgress(upload: UploadRequest)
    func handleResponseNoInternetConnection()
    func handleUnknownError()
}

class BaseNetworking: Networking {
    
    fileprivate let manager: SessionManager
    fileprivate let log = SwiftyBeaver.self
    fileprivate var authorizationHelper: AuthorizationHelper?
    fileprivate var unauthorizedRequests: [HTTPRequest] = []
    
    init() {
        let configuraion = URLSessionConfiguration.default
        configuraion.timeoutIntervalForRequest = 20
        self.manager = Alamofire.SessionManager(configuration: configuraion)
    }
    
    // MARK: Request
    func makeRequest(request: HTTPRequest) {
        if let _ = request.data {
            makeDataUpload(request: request)
        } else {
            makeDataRequest(request: request)
        }
    }
    
    private func makeDataUpload(request: HTTPRequest) {
        
        request.headers = getHeaders(with: HeadersKeys.ContentDataType.value)
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            if let parameters = request.parameters {
                for (key, value) in parameters {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
            }
            
            if let data = request.data {
                multipartFormData.append(data, withName: "session", fileName: "session.csv", mimeType: "text/csv")
            }
            
        }, usingThreshold: UInt64.init(), to: request.url, method: request.method, headers: request.headers) { (result) in
            switch result {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    if let value = response.value {
                        self.successResponse(json: JSON(value), request: request , response: response)
                    } else {
                        self.handleUnknownError()
                    }
                }
                self.handleUploadProgress(upload: upload)
            case .failure(let error):
                self.log.error("Error in upload: \(error.localizedDescription)")
                self.handleResponseBadRequest(json: JSON(error))
            }
        }
    }
    
    private func makeDataRequest(request: HTTPRequest) {
        if request.headers == nil {
            request.headers = getHeaders()
        }
        if request.numberOfUnauthorizedResponses >= Constants.maxNumberOfUnauthorizedRequests {
            self.handleUnknownError()
            return
        }
        manager.request(request.url, method: request.method, parameters: request.parameters, encoding: request.encoding, headers: request.headers).responseJSON {
            response in
            self.handleResponse(request: request, response: response)
        }
    }
    
    // MARK: Response
    func handleResponse(request: HTTPRequest, response: DataResponse<Any>) {
        switch response.result {
        case .success(let value):
            successResponse(json: JSON(value), request: request, response: response)
        case .failure(let error):
            errorResponse(error: error)
        }
    }
    
    func successResponse(json: JSON?, request: HTTPRequest, response: DataResponse<Any>) {
        if let code = response.response?.statusCode {
            switch code {
            case ErrorCodes.authorization:
                handleResponseUnauthorized(request: request)
            case ErrorCodes.badRequest, ErrorCodes.invalidCredentials:
                handleResponseBadRequest(json: json)
            case SuccessCodes.created, SuccessCodes.ok:
                handleResponseSuccess(json: json)
            default:
                handleUnknownError()
            }
        } else {
            handleUnknownError()
        }
    }
    
    func errorResponse(error: Error) {
        let code = (error as NSError).code
        switch code {
        case ErrorCodes.notConnectedToInternet:
            handleResponseNoInternetConnection()
        default:
            handleUnknownError()
        }
    }
    
    // MARK: Headers
    func getHeaders(with contentType: String = HeadersKeys.ContentType.value) -> [String : String] {
        var headers = [String: String]()
        headers[HeadersKeys.ContentType.name] = contentType
        headers[HeadersKeys.Accept.name] = HeadersKeys.Accept.value
        if let accessToken = UserDefaults.Authorization.string(forKey: .accessToken) {
            headers[HeadersKeys.Authorization.name] = HeadersKeys.Authorization.value + accessToken
        }
        return headers
    }
    
    func handleResponseUnauthorized(request: HTTPRequest) {
        if authorizationHelper == nil {
            authorizationHelper = AuthorizationHelperImpl()
            authorizationHelper?.delegate = self
        }
        
        guard let _ = UserDefaults.Authorization.string(forKey: .refreshToken) else {
            NotificationCenter.default.post(name: .invalidToken, object: nil)
            return
        }
        
        request.numberOfUnauthorizedResponses += 1
        unauthorizedRequests.append(request)
        authorizationHelper?.requestAccessTokenFromRefreshToken()
    }
    
    func handleUnknownError() {
        log.error("You need to override this method in you networking class")
    }
    
    func handleResponseNoInternetConnection() {
        log.error("You need to override this method in you networking class")
    }
    
    func handleResponseBadRequest(json: JSON?) {
        log.error("You need to override this method in you networking class")
    }
    
    func handleResponseSuccess(json: JSON?) {
        log.error("You need to override this method in you networking class")
    }
    
    func handleUploadProgress(upload: UploadRequest) {
        log.error("You need to override this method in you networking class")
    }
    
    fileprivate func refreshAccessToken(_ error: Error?, request: Request, fulfill: @escaping ((_ json: JSON?) -> Void), reject: @escaping ((_ error: NSError) -> ())) {
        
        guard let refreshToken = UserDefaults.Authorization.string(forKey: .refreshToken) else {
            NotificationCenter.default.post(name: .invalidToken, object: nil)
            return
        }
        
        var dictionary: [String: Any] = [:]
        dictionary.serializeItem(HeadersKeys.ContentType.name, value: HeadersKeys.ContentType.value)
        dictionary.serializeItem(HeadersKeys.Accept.name, value: HeadersKeys.Accept.value)
        dictionary.serializeItem(HeadersKeys.Authorization.name, value: HeadersKeys.Authorization.value + refreshToken)
        let request = HTTPRequest(url: getAuthorizationUrl(), method: .post, parameters: dictionary)
        makeRequest(request: request)
    }
    
    fileprivate func getAuthorizationUrl() -> String {
        return Endpoints.baseUrl + Endpoints.refreshToken
    }
}

extension BaseNetworking: AuthorizationHelperDelegate {
    func handleClientCredentialsSuccess(success: Bool) {
        for request in unauthorizedRequests {
            request.headers = nil
            makeRequest(request: request)
        }
        unauthorizedRequests.removeAll()
        
    }
    
    func tokenRefreshingDone(success: Bool) {
        if success {
            for request in unauthorizedRequests {
                request.headers = nil
                makeRequest(request: request)
            }
            unauthorizedRequests.removeAll()
            
        } else {
            authorizationHelper?.requestClientCredentialsToken()
            UserDefaults.userLoggedOut()
            NotificationCenter.default.post(name: .invalidToken, object: nil)
        }
    }
    
}
