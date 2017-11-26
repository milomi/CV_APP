//
//  ParamsHeaders.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 26.11.2017.
//

import Foundation
import Foundation

struct Endpoints {
    static let baseUrl = "http://carrierviewer.azurewebsites.net"
    static let register = "register"
    static let login = "oauth/token"
    static let refreshToken = "refresh"
    static let session = "session"
    static let teams = "teams"
    static let addTeam = "team/assign"
}

struct SuccessCodes {
    static let ok = 200
    static let created = 201
}

struct ErrorCodes {
    static let notConnectedToInternet = -1009
    static let authorization = 401
    static let badRequest = 400
    static let invalidCredentials = 422
}

struct HeadersKeys {
    struct ContentType {
        static let name = "Content-Type"
        static let value = "application/json"
    }
    
    struct ContentDataType {
        static let name = "Content-type"
        static let value = "multipart/form-data"
    }
    
    struct Accept {
        static let name = "Accept"
        static let value = "application/json"
    }
    
    struct Authorization {
        static let name = "Authorization"
        static let value = "Bearer "
    }
    
    struct GrantType {
        static let name =  "grant_type"
        static let clientCredentials = "client_credentials"
        static let password = "password"
    }
    
    struct ClientId {
        static let name = "client_id"
        static let value = "iOSApp"
    }
}
