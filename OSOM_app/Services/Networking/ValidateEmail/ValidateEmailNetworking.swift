import SwiftyJSON

protocol EmailValidationNetworking: class {
    weak var delegate: EmailValidationNetworkingDelegate? { get set }
    func validateEmail(parameters: [String: Any])
}

protocol EmailValidationNetworkingDelegate: class {
    func unknownErrorOccured()
    func noInternetConnection()
    func errorOccured(_ json: JSON)
    func responseSuccess(_ json: JSON)
}

class EmailValidationNetworkingImpl: BaseNetworking {
    
    weak var delegate: EmailValidationNetworkingDelegate?
    
    override func handleUnknownError() {
        delegate?.unknownErrorOccured()
    }
    
    override func handleResponseNoInternetConnection() {
        delegate?.noInternetConnection()
    }
    
    override func handleResponseBadRequest(json: JSON?) {
        if let json = json {
            delegate?.errorOccured(json)
        } else {
            delegate?.unknownErrorOccured()
        }
    }
    
    override func handleResponseSuccess(json: JSON?) {
        if let json = json {
            delegate?.responseSuccess(json)
        } else {
            delegate?.unknownErrorOccured()
        }
    }
    
}

extension EmailValidationNetworkingImpl: EmailValidationNetworking {
    
    func validateEmail(parameters: [String: Any]) {
        makeRequest(request: getRequest(parameters: parameters))
    }
    
    fileprivate func getRequest(parameters: [String: Any]) -> HTTPRequest {
        return HTTPRequest(url: getUrl(), method: .post, parameters: parameters)
    }
    
    fileprivate func getUrl() -> String {
        return Endpoints.baseUrl + Endpoints.emailValidator
    }
    
}
