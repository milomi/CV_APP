//
//  AuthorizationSerializer.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 26.11.2017.
//

import Foundation
import SwiftyJSON

struct AuthorizationSerializerParameters {
    static let accessToken = "access_token"
    static let refreshToken = "token"
    static let email = "email"
    static let password = "password"
    static let name = "name"
    static let timezone = "timezone"
    static let error = "error"
}

protocol AuthorizationSerializer {
    func unserialize(json: JSON?) -> Bool
    func unserializeError(json: JSON?) -> String?
    func serializeRefreshToken() -> [String: Any]
    func serializeLogin(_ user: AuthorizateUser) -> [String: Any]
    func serializeSignUp(_ user: AuthorizateUser) -> [String: Any]
}

final class AuthorizationSerializerImpl: AuthorizationSerializer {
    
    func unserialize(json: JSON?) -> Bool {
        guard let json = json,
            let accessToken = json[AuthorizationSerializerParameters.accessToken].string,
            let refreshToken = json[AuthorizationSerializerParameters.refreshToken].string else {
                return false
        }
        
        UserDefaults.Authorization.set(accessToken, forKey: .accessToken)
        UserDefaults.Authorization.set(refreshToken, forKey: .refreshToken)
        UserDefaults.AccountStatus.set(.logged, forKey: .currentStatus)
        return true
    }
    
    func unserializeError(json: JSON?) -> String? {
        guard let json = json else {
            return nil
        }
        
        return json[AuthorizationSerializerParameters.error].string
        
    }
    
    func serializeRefreshToken() -> [String : Any] {
        var dictionary: [String: Any] = [:]
        
        guard let refreshToken = UserDefaults.Authorization.string(forKey: .refreshToken) else {
            return dictionary
        }
        dictionary.serializeItem(HeadersKeys.ContentType.name, value: HeadersKeys.ContentType.value)
        dictionary.serializeItem(HeadersKeys.Accept.name, value: HeadersKeys.Accept.value)
        dictionary.serializeItem(HeadersKeys.Authorization.name, value: HeadersKeys.Authorization.value + refreshToken)
        
        return dictionary
    }
    
    func serializeLogin(_ user: AuthorizateUser) -> [String : Any] {
        var dictionary: [String: Any] = [:]
        dictionary.serializeItem(AuthorizationSerializerParameters.email, value: user.email)
        dictionary.serializeItem(AuthorizationSerializerParameters.password, value: user.password)
        return dictionary
    }
    
    func serializeSignUp(_ user: AuthorizateUser) -> [String : Any] {
        var dictionary: [String: Any] = [:]
        
        if let name = user.firstName, let lastName = user.lastName {
            let userName = "\(name) \(lastName)"
            dictionary.serializeItem(AuthorizationSerializerParameters.name, value: userName)
        }
        dictionary.serializeItem(AuthorizationSerializerParameters.email, value: user.email)
        dictionary.serializeItem(AuthorizationSerializerParameters.password, value: user.password)
        dictionary.serializeItem(AuthorizationSerializerParameters.timezone, value: TimeZone.current.identifier)
        return dictionary
    }
    
}
