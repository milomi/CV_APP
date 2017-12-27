//
//  EducationSerializer.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 02.12.2017.
//

import Foundation
import SwiftyJSON
import UIKit

struct EducationSerializerParameters {
    static let id = "id"
    static let name = "name"
    static let startingTime = "startingTime"
    static let endingTime = "endingTime"
    static let courseTitle = "courseTitle"
    static let detailedInfo = "detailedInfo"
    static let schools = "schools"
}

protocol EducationSerializer: class {
    func serialize(school: School) -> [String: Any]
    func unserialize(json: JSON) -> [School]?
}

final class EducationSerializerImpl: EducationSerializer {
    
    typealias parameters = EducationSerializerParameters
    
    func serialize(school: School) -> [String: Any] {
        var dictionary: [String: Any] = [:]
        
        if school.schoolID != -1 {
            dictionary.serializeItem(parameters.id, value: school.schoolID)
        }
        dictionary.serializeItem(parameters.name, value: school.name)
        dictionary.serializeItem(parameters.startingTime, value: school.startingTime.description)
        dictionary.serializeItem(parameters.endingTime, value: school.endingTime.description)
        dictionary.serializeItem(parameters.courseTitle, value: school.courseTitle)
        dictionary.serializeItem(parameters.detailedInfo, value: school.detailedInfo)

        return dictionary
    }
    
    func unserialize(json: JSON) -> [School]? {
        guard let objects = json[parameters.schools].array else {
            return nil
        }
        
        var schools = [School]()
        
        objects.forEach { (object) in
            let school = School()
            school.schoolID = object[parameters.id].int ?? -1
            school.name = object[parameters.name].string ?? ""
            school.startingTime = DateFormatterHelper.getDateFormString(dateString: object[parameters.startingTime].string) ?? Date()
            school.endingTime = DateFormatterHelper.getDateFormString(dateString: object[parameters.endingTime].string) ?? Date()
            school.courseTitle = object[parameters.courseTitle].string ?? ""
            school.detailedInfo = object[parameters.detailedInfo].string ?? ""
            schools.append(school)
        }
    
        return schools
        
    }
    
}
