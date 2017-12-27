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
    static let id = "id"
    static let name = "name"
    static let skills = "skills"
    static let experienceValue = "experienceValue"
    static let sectionId = "sectionId"
    static let skillsSections = "skillsSections"
    static let skillSectionId = "skillSectionId"
}

protocol SkillsSerializer: class {
    func serializeSkill(skill: Skill) -> [String: Any]
    func serializeSection(section: SkillsSection) -> [String: Any]
    func unserialize(json: JSON) -> [SkillsSection]?
    func unserializeSectionId(json: JSON) -> Int? 
}

final class SkillsSerializerImpl: SkillsSerializer {
    
    typealias parameters = SkillsSerializerParameters
    
    func serializeSkill(skill: Skill) -> [String: Any] {
        var dictionary: [String: Any] = [:]
        dictionary.serializeItem(parameters.name, value: skill.name)
        dictionary.serializeItem(parameters.experienceValue, value: skill.experienceValue)
        dictionary.serializeItem(parameters.sectionId, value: skill.sectionId)
        return dictionary
    }
    
    func serializeSection(section: SkillsSection) -> [String: Any] {
        var dictionary: [String: Any] = [:]
        dictionary.serializeItem(parameters.name, value: section.name)
        return dictionary
    }
    
    func unserialize(json: JSON) -> [SkillsSection]? {
        guard let objects = json[parameters.skillsSections].array else {
            return nil
        }
        
        var sections = [SkillsSection]()
        
        objects.forEach { (object) in
            let section = SkillsSection()
            section.id = object[parameters.id].int ?? -1
            section.name = object[parameters.name].string ?? ""
            
            if let skillsJson = object[parameters.skills].array {
                
                skillsJson.forEach({ (skillJson) in
                    let skill = Skill()
                    skill.sectionId = section.id
                    section.skills.append(skill)
                    sections.append(section)
                })
                
            }
            
            sections.append(section)
        }
        
        return sections
        
    }
    
    func unserializeSectionId(json: JSON) -> Int?  {
        guard let sectionId = json[parameters.skillSectionId].int else {
            return nil
        }
        
        return sectionId
    }
    
}
