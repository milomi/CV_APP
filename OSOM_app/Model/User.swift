//
//  User.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 23.11.2017.
//

import Foundation

protocol SignUpUserModel {
    var name: String { get set }
    var surname: String { get set }
    var email: String { get set }
    var password: String { get set }
}

protocol UserPersonalDataModel {
    var profilePhoto: Data? { get set }
    var personalStatement: String? { get set }
}

class User: SignUpUserModel {
    var name: String = ""
    var surname: String = ""
    var email: String = ""
    var password: String = ""
}
