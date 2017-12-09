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
    static let id = "Id"
    static let name = "Name"
    static let startingTime = "StartingTime"
    static let endingTime = "EndingTime"
    static let courseTitle = "CourseTitle"
    static let detailedInfo = "DetailedInfo"
}

protocol EducationSerializer: class {
    func serialize(school: AddSchoolObject) -> [String: Any]
}

final class EducationSerializerImpl: EducationSerializer {
    
    typealias parameters = EducationSerializerParameters
    
    func serialize(school: AddSchoolObject) -> [String: Any] {
        var dictionary: [String: Any] = [:]
        dictionary.serializeItem(parameters.name, value: school.name)
        dictionary.serializeItem(parameters.startingTime, value: school.startingTime)
        dictionary.serializeItem(parameters.endingTime, value: school.endingTime)
        dictionary.serializeItem(parameters.courseTitle, value: school.courseTitle)
        dictionary.serializeItem(parameters.detailedInfo, value: school.detailedInfo ?? "")

        return dictionary
    }
    
    func unserialize(json: JSON) -> Bool {
        return true
    }
    
}
