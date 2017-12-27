//
//  Work.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 23.11.2017.
//

import Foundation
import RealmSwift

class Work: Object {
    @objc dynamic var id: Int = -1
    @objc dynamic var name: String = ""
    @objc dynamic var startingTime: Date = Date()
    @objc dynamic var endingTime: Date = Date()
    @objc dynamic var jobTitle: String = ""
    @objc dynamic var detailedInfo: String = "" 
}
