//
//  EmailValidationSerializer.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 26.11.2017.
//

import Foundation
import SwiftyJSON

struct EmailValidationSerializerParameters {
    static let email = "email"
    static let isValid = "isValid"
}

protocol EmailValidationSerializer: class {
    func serialize(_ email: String?) -> [String: Any]
    func unserialize(json: JSON) -> Bool
}

final class EmailValidationSerializerImpl: EmailValidationSerializer {
    
    func serialize(_ email: String?) -> [String: Any] {
        var dictionary: [String: Any] = [:]
        dictionary.serializeItem(EmailValidationSerializerParameters.email, value: email)
        return dictionary
    }
    
    func unserialize(json: JSON) -> Bool {
        guard let isValid = json[EmailValidationSerializerParameters.isValid].bool else {
            return false
        }
        
        return isValid
    }
    
}
