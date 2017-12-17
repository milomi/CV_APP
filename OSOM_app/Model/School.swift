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
    var detailedInfo: String { get set }
}

class School: Object, AddSchoolObject {
    @objc dynamic var schoolID: Int = -1
    @objc dynamic var name: String = ""
    @objc dynamic var startingTime: Date = Date()
    @objc dynamic var endingTime: Date = Date()
    @objc dynamic var courseTitle: String = ""
    @objc dynamic var detailedInfo: String = ""
}
