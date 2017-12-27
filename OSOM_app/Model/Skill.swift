//
//  Skill.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 18.12.2017.
//

import Foundation
import RealmSwift

class Skill: Object {
    @objc dynamic var id: Int = -1
    @objc dynamic var name: String = ""
    @objc dynamic var ExperienceValue: Int = 0
    @objc dynamic var sectionId: Int = -1
}
