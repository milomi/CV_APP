//
//  User.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 23.11.2017.
//

import Foundation
import RealmSwift

protocol SignUpUserModel {
    var name: String { get set }
    var surname: String { get set }
    var email: String { get set }
    var password: String { get set }
}

protocol UserPersonalDataModel {
    var profilePhoto: UIImage? { get set }
    var personalStatement: String? { get set }
}

class User: Object, SignUpUserModel, UserPersonalDataModel {
    var name: String = ""
    var surname: String = ""
    var email: String = ""
    var password: String = ""
    var personalStatement: String?
    var profilePhoto: UIImage?
    var schoolList: List<School> = List()
}
