//
//  ParamsHeaders.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 26.11.2017.
//

import Foundation
import Foundation

struct Endpoints {
    static let baseUrl = "https://carrierviewer.azurewebsites.net/"
    static let register = "api/accounts/create"
    static let login = "oauth/token"
    static let refreshToken = "oauth/token"
    static let session = "session"
    static let teams = "teams"
    static let addTeam = "team/assign"
    static let emailValidator = "api/accounts/email"
    static let personal = "api/accounts/data/personal"
    static let education = "api/data/school"
    static let section = "api/data/section"
    static let skill = "api/data/skill"
    static let work = "api/data/work"
    static let works = "api/data/works"
    static let schools = "api/data/schools"
    
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
    
    struct ClientSecret {
        static let name = "client_secret"
        static let value = "qMCdFDQuF23RV1Y-1Gq9L3cF3VmuFwVbam4fMTdAfpo"
    }
}
