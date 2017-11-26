//
//  UserDefaultsHelper.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 26.11.2017.
//

import Foundation

enum AccountStatus: String  {
    case notLogged = "notLogged"
    case anonymus = "anonynmus"
    case logged = "logged"
}

protocol BoolUserDefaultable {
    associatedtype BoolDefaultKey : RawRepresentable
}

protocol AccountStatusUserDefaultable {
    associatedtype AccountStatusDefaultKey : RawRepresentable
}

protocol StringUserDefaultable {
    associatedtype StringDefaultKey : RawRepresentable
}

protocol IntegerUserDefaultable {
    associatedtype IntegerDefaultKey : RawRepresentable
}

protocol DoubleUserDefaultable {
    associatedtype DoubleDefaultKey : RawRepresentable
}

protocol PushDataUserDefaultable {
    associatedtype StringDefaultKey : RawRepresentable
    associatedtype BoolDefaultKey : RawRepresentable
}

protocol UserIdUserDefaultable {
    associatedtype UserIdDefaultKey : RawRepresentable
}


extension BoolUserDefaultable where BoolDefaultKey.RawValue == String {
    
    static func set(_ value: Bool, forKey key: BoolDefaultKey) {
        let key = key.rawValue
        UserDefaults.standard.set(value, forKey: key)
    }
    
    static func bool(forKey key: BoolDefaultKey) -> Bool {
        let key = key.rawValue
        return UserDefaults.standard.bool(forKey: key)
    }
    
}

extension AccountStatusUserDefaultable where AccountStatusDefaultKey.RawValue == String {
    
    static func set(_ value: AccountStatus?, forKey key: AccountStatusDefaultKey) {
        let key = key.rawValue
        UserDefaults.standard.set(value?.rawValue, forKey: key)
    }
    
    static func set(_ value: String?, forKey key: AccountStatusDefaultKey) {
        let key = key.rawValue
        UserDefaults.standard.set(value, forKey: key)
    }
    
    static func status(forKey key: AccountStatusDefaultKey) -> String? {
        let key = key.rawValue
        return UserDefaults.standard.string(forKey: key)
    }
    
}

extension StringUserDefaultable where StringDefaultKey.RawValue == String {
    
    static func set(_ value: String?, forKey key: StringDefaultKey) {
        let key = key.rawValue
        UserDefaults.standard.set(value, forKey: key)
    }
    
    static func string(forKey key: StringDefaultKey) -> String? {
        let key = key.rawValue
        return UserDefaults.standard.string(forKey: key)
    }
    
}

extension IntegerUserDefaultable where IntegerDefaultKey.RawValue == String {
    
    static func set(_ value: Int, forKey key: IntegerDefaultKey) {
        let key = key.rawValue
        UserDefaults.standard.set(value, forKey: key)
    }
    
    static func int(forKey key: IntegerDefaultKey) -> Int? {
        let key = key.rawValue
        return UserDefaults.standard.integer(forKey: key)
    }
    
}

extension DoubleUserDefaultable where DoubleDefaultKey.RawValue == String {
    
    static func set(_ value: Double, forKey key: DoubleDefaultKey) {
        let key = key.rawValue
        UserDefaults.standard.set(value, forKey: key)
    }
    
    static func double(forKey key: DoubleDefaultKey) -> Double? {
        let key = key.rawValue
        return UserDefaults.standard.double(forKey: key)
    }
    
}

extension PushDataUserDefaultable where StringDefaultKey.RawValue == String, BoolDefaultKey.RawValue == String {
    
    static func set(_ value: String?, forKey key: StringDefaultKey) {
        let key = key.rawValue
        UserDefaults.standard.set(value, forKey: key)
    }
    
    static func string(forKey key: StringDefaultKey) -> String? {
        let key = key.rawValue
        return UserDefaults.standard.string(forKey: key)
    }
    
    static func set(_ value: Bool, forKey key: BoolDefaultKey) {
        let key = key.rawValue
        UserDefaults.standard.set(value, forKey: key)
    }
    
    static func bool(forKey key: BoolDefaultKey) -> Bool {
        let key = key.rawValue
        return UserDefaults.standard.bool(forKey: key)
    }
}

extension UserIdUserDefaultable where UserIdDefaultKey.RawValue == String {
    
    static func set(_ value: String?, forKey key: UserIdDefaultKey) {
        let key = key.rawValue
        UserDefaults.standard.set(value, forKey: key)
    }
    
    static func string(forKey key: UserIdDefaultKey) -> String? {
        let key = key.rawValue
        return UserDefaults.standard.string(forKey: key)
    }
    
}

extension UserDefaults {
    
    struct Authorization: StringUserDefaultable {
        private init() {}
        
        enum StringDefaultKey: String {
            case accessToken
            case refreshToken
        }
        
    }
    
    struct AccountStatus : AccountStatusUserDefaultable {
        private init() {}
        
        enum AccountStatusDefaultKey : String {
            case currentStatus
            case lastLogin
        }
        
    }
    
    static func userLoggedOut() {
        UserDefaults.AccountStatus.set(.notLogged, forKey: .currentStatus)
        UserDefaults.Authorization.set(nil, forKey: .accessToken)
        UserDefaults.Authorization.set(nil, forKey: .refreshToken)
    }
    
}
