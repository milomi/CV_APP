//
//  SkillsSerializer.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 02.12.2017.
//

import Foundation
import SwiftyJSON
import UIKit

struct SkillsSerializerParameters {
    static let id = "Id"
    static let name = "Name"
    static let skills = "Skills"
    static let experienceValue = "ExperienceValue"
    static let sectionId = "SectionId"
}

protocol SkillsSerializer: class {
    func serializeSkill() -> [String: Any]
    func serializeSection() -> [String: Any] 
}

final class SkillsSerializerImpl: SkillsSerializer {
    
    typealias parameters = SkillsSerializerParameters
    
    func serializeSkill() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        dictionary.serializeItem(parameters.name, value: "")
        dictionary.serializeItem(parameters.experienceValue, value: Date())
        return dictionary
    }
    
    func serializeSection() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        dictionary.serializeItem(parameters.name, value: "")
        return dictionary
    }
    
    func unserialize(json: JSON) -> Bool {
        return true
    }
    
}
