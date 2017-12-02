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
}

protocol EmailValidationSerializer: class {
    func serialize(_ email: String?) -> [String: Any]
}

final class EmailValidationSerializerImpl: EmailValidationSerializer {
    
    func serialize(_ email: String?) -> [String: Any] {
        var dictionary: [String: Any] = [:]
        dictionary.serializeItem(EmailValidationSerializerParameters.email, value: email)
        return dictionary
    }
    
}
