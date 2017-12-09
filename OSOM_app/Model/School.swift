//
//  School.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 23.11.2017.
//

import Foundation
import RealmSwift

class School: Object {
    var id: Int?
    var name: String = ""
    var startingTime: String = ""
    var endingTime: String = ""
    var courseTitle: String = ""
    var detailedInfo: String? 
}
