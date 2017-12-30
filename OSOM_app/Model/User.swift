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
    var personalStatement: String { get set }
}

class User: Object, SignUpUserModel, UserPersonalDataModel {
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var surname: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var password: String = ""
    @objc dynamic var personalStatement: String = ""
    @objc dynamic var city: String = ""
    @objc dynamic var publicMail: String = ""
    @objc dynamic var potfolioUrl: String = ""
    @objc dynamic var linkedInAccountUrl: String = ""
    @objc dynamic var profileQrCodeUrl: String = ""
    @objc dynamic var facebookAccountUrl: String = ""
    @objc dynamic var phoneNumber: String = ""
    @objc dynamic var photoUrl: String = ""
    var profilePhoto: UIImage?
}
