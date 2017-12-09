//
//  School.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 23.11.2017.
//

import Foundation
import RealmSwift

protocol AddSchoolObject {
    var name: String { get set }
    var startingTime: Date { get set }
    var endingTime: Date { get set }
    var courseTitle: String { get set }
    var detailedInfo: String? { get set }
}

class School: Object, AddSchoolObject {
    var schoolID: Int?
    var name: String = ""
    var startingTime: Date = Date()
    var endingTime: Date = Date()
    var courseTitle: String = ""
    var detailedInfo: String?

}



