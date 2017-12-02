//
//  PersonalSerializer.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 02.12.2017.
//

import Foundation
import SwiftyJSON
import UIKit

struct PersonalSerializerParameters {
    static let profilePhoto = "ProfilePhoto"
    static let personalStatement = "PersonalStatement"
}

protocol PersonalSerializer: class {
    func serialize(_ photo: UIImage, _ personalStatement: String) -> [String: Any]
}

final class PersonalSerializerImpl: PersonalSerializer {
    
    typealias parameters = PersonalSerializerParameters
    
    func serialize(_ photo: UIImage, _ personalStatement: String) -> [String: Any] {
        var dictionary: [String: Any] = [:]
        dictionary.serializeItem(parameters.profilePhoto, value: photo.getBase64String() ?? "")
        dictionary.serializeItem(parameters.personalStatement, value: personalStatement)
        return dictionary
    }
    
}
