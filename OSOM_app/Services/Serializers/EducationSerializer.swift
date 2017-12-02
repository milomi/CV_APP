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
    func serialize() -> [String: Any]
}

final class EducationSerializerImpl: EducationSerializer {
    
    typealias parameters = EducationSerializerParameters
    
    func serialize() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        dictionary.serializeItem(parameters.name, value: "")
        dictionary.serializeItem(parameters.startingTime, value: Date())
        dictionary.serializeItem(parameters.endingTime, value: Date())
        dictionary.serializeItem(parameters.courseTitle, value: "")
        dictionary.serializeItem(parameters.detailedInfo, value: "")

        return dictionary
    }
    
    func unserialize(json: JSON) -> Bool {
        return true
    }
    
}
