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
    static let refreshToken = "refresh_token"
    static let email = "email"
    static let username = "username"
    static let password = "password"
    static let name = "name"
    static let surname = "surname"
    static let timezone = "timezone"
    static let error = "error"
}

protocol AuthorizationSerializer {
    func unserialize(json: JSON) -> Bool
    func unserializeError(json: JSON?) -> String?
    func serializeRefreshToken() -> [String: Any]
    func serializeAnonymusToken() -> [String: Any]
    func serializeLogin(_ user: SignUpUserModel) -> [String: Any]
    func serializeSignUp(_ user: SignUpUserModel) -> [String: Any]
    func unserializeAnonymusToken(json: JSON?) -> Bool 
}

final class AuthorizationSerializerImpl: AuthorizationSerializer {
    
    func unserialize(json: JSON) -> Bool {
        guard let accessToken = json[AuthorizationSerializerParameters.accessToken].string,
                let refreshToken = json[AuthorizationSerializerParameters.refreshToken].string else {
                return false
        }
        
        UserDefaults.Authorization.set(accessToken, forKey: .accessToken)
        UserDefaults.Authorization.set(refreshToken, forKey: .refreshToken)
        UserDefaults.AccountStatus.set(.logged, forKey: .currentStatus)
        
        return true
    }
    
    func unserializeAnonymusToken(json: JSON?) -> Bool {
        guard let json = json,
            let accessToken = json[AuthorizationSerializerParameters.accessToken].string else {
                return false
        }
        
        UserDefaults.Authorization.set(accessToken, forKey: .accessToken)
        UserDefaults.Authorization.set(nil, forKey: .refreshToken)
        UserDefaults.AccountStatus.set(.anonymus, forKey: .currentStatus)
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
        dictionary.serializeItem(HeadersKeys.ClientId.name, value: HeadersKeys.ClientId.value)
        dictionary.serializeItem(HeadersKeys.ClientSecret.name, value: HeadersKeys.ClientSecret.value)
        
        return dictionary
    }
    
    func serializeLogin(_ user: SignUpUserModel) -> [String : Any] {
        var dictionary: [String: Any] = [:]
        dictionary.serializeItem(HeadersKeys.GrantType.name, value: HeadersKeys.GrantType.password)
        dictionary.serializeItem(HeadersKeys.ClientId.name, value: HeadersKeys.ClientId.value)
        dictionary.serializeItem(HeadersKeys.ClientSecret.name, value: HeadersKeys.ClientSecret.value)
        dictionary.serializeItem(AuthorizationSerializerParameters.username, value: user.email)
        dictionary.serializeItem(AuthorizationSerializerParameters.password, value: user.password)
        return dictionary
    }
    
    func serializeSignUp(_ user: SignUpUserModel) -> [String : Any] {
        var dictionary: [String: Any] = [:]
        
        dictionary.serializeItem(AuthorizationSerializerParameters.name, value: user.name)
        dictionary.serializeItem(AuthorizationSerializerParameters.surname, value: user.surname)
        dictionary.serializeItem(AuthorizationSerializerParameters.email, value: user.email)
        dictionary.serializeItem(AuthorizationSerializerParameters.password, value: user.password)
        dictionary.serializeItem(HeadersKeys.ClientSecret.name, value: HeadersKeys.ClientSecret.value)
        return dictionary
    }
    
    func serializeAnonymusToken() -> [String : Any] {
        var dictionary: [String: Any] = [:]

        dictionary.serializeItem(HeadersKeys.GrantType.name, value: HeadersKeys.GrantType.clientCredentials)
        dictionary.serializeItem(HeadersKeys.ClientId.name, value: HeadersKeys.ClientId.value)
        dictionary.serializeItem(HeadersKeys.ClientSecret.name, value: HeadersKeys.ClientSecret.value)
        
        return dictionary
        
    }
    
}
