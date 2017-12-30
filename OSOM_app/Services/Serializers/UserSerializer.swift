//
//  UserSerializer.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 30.12.2017.
//

import Foundation
import SwiftyJSON

struct UserSerializerParameters {
    static let id = "id"
    static let name = "name"
    static let surname = "surname"
    static let personalStatement = "personalStatement"
    static let publicMail = "publicMail"
    static let city = "city"
    static let potfolioUrl = "portfolioUrl"
    static let linkedin = "linkedInAccountUrl"
    static let facebook = "facebookAccountUrl"
    static let profileQrCodeUrl = "profileQrCodeUrl"
    static let profilePhotoUrl = "profilePhotoUrl"
    static let phoneNumber = "phoneNumber"
}

protocol UserSerializer: class {

    func unserialize(json: JSON) -> User
}

class UserSerializerImpl: UserSerializer {
    
    typealias parameters = UserSerializerParameters
    
    func unserialize(json: JSON) -> User {
        
        let user = User()
        
        user.id = json[parameters.id].string ?? ""
        user.name = json[parameters.name].string ?? ""
        user.surname = json[parameters.surname].string ?? ""
        user.personalStatement = json[parameters.personalStatement].string ?? ""
        user.photoUrl = json[parameters.profilePhotoUrl].string ?? ""
        user.profileQrCodeUrl = json[parameters.profileQrCodeUrl].string ?? ""
        user.publicMail = json[parameters.publicMail].string ?? ""
        user.city = json[parameters.city].string ?? ""
        user.phoneNumber = json[parameters.phoneNumber].string ?? ""
        
        
        return user
    
    }
    
}
