//
//  WorkSerializer.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 17.12.2017.
//

import Foundation
import SwiftyJSON
import UIKit

struct WorkSerializerParameters {
    static let id = "id"
    static let name = "name"
    static let startingTime = "startingTime"
    static let endingTime = "endingTime"
    static let jobTitle = "jobTitle"
    static let detailedInfo = "detailedInfo"
    static let works = "works"
}

protocol WorkSerializer: class {
    func serialize(work: Work) -> [String: Any]
    func unserialize(json: JSON) -> [Work]?
}

final class WorkSerializerImpl: WorkSerializer {
    
    typealias parameters = WorkSerializerParameters
    
    func serialize(work: Work) -> [String: Any] {
        var dictionary: [String: Any] = [:]
        
        if work.id != -1 {
            dictionary.serializeItem(parameters.id, value: work.id)
        }
        dictionary.serializeItem(parameters.name, value: work.name)
        dictionary.serializeItem(parameters.startingTime, value: work.startingTime.description)
        dictionary.serializeItem(parameters.endingTime, value: work.endingTime.description)
        dictionary.serializeItem(parameters.jobTitle, value: work.jobTitle)
        dictionary.serializeItem(parameters.detailedInfo, value: work.detailedInfo)
        
        return dictionary
    }
    
    func unserialize(json: JSON) -> [Work]? {
        guard let objects = json[parameters.works].array else {
            return nil
        }
        
        var works = [Work]()
        
        objects.forEach { (object) in
            let work = Work()
            work.id = object[parameters.id].int ?? -1
            work.name = object[parameters.name].string ?? ""
            work.startingTime = DateFormatterHelper.getDateFormString(dateString: object[parameters.startingTime].string) ?? Date()
            work.endingTime = DateFormatterHelper.getDateFormString(dateString: object[parameters.endingTime].string) ?? Date()
            work.jobTitle = object[parameters.jobTitle].string ?? ""
            work.detailedInfo = object[parameters.detailedInfo].string ?? ""
            works.append(work)
        }
        
        return works
        
    }
    
}
