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
    static let profilePhoto = "profilePhoto"
    static let personalStatement = "personalStatement"
    static let picture = "picture"
}

protocol PersonalSerializer: class {
    func serialize(_ photo: UIImage, _ personalStatement: String) -> [String: Any]
    func unserializeData(json: JSON) -> (UIImage?, String?)
    func unserializePhoto(json: JSON) -> UIImage? 
}

final class PersonalSerializerImpl: PersonalSerializer {
    
    typealias parameters = PersonalSerializerParameters
    
    func serialize(_ photo: UIImage, _ personalStatement: String) -> [String: Any] {
        var dictionary: [String: Any] = [:]
        dictionary.serializeItem(parameters.profilePhoto, value: photo.getBase64String() ?? "")
        dictionary.serializeItem(parameters.personalStatement, value: personalStatement)
        return dictionary
    }
    
    func unserializeData(json: JSON) -> (UIImage?, String?) {
        var photo: UIImage?
        var personalData: String?
        
        if let base64String = json[parameters.profilePhoto].string {
            if let imageData = Data(base64Encoded: base64String) {
                photo = UIImage(data: imageData)
            }
        }
        
        personalData = json[parameters.personalStatement].string
        
        return (photo, personalData)
    }
    
    func unserializePhoto(json: JSON) -> UIImage? {
        var photo: UIImage?
        if let base64String = json[parameters.picture].string {
            if let imageData = Data(base64Encoded: base64String) {
                photo = UIImage(data: imageData)
            }
        }
        return photo
    }
    
}
