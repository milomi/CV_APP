//
//  ContactSerializer.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 30.12.2017.
//

import Foundation
import SwiftyJSON

struct ContactSerializerParameters {
    static let publicMail = "publicMail"
    static let city = "city"
    static let potfolioUrl = "portfolioUrl"
    static let linkedin = "linkedInAccountUrl"
    static let facebook = "facebookAccountUrl"
    static let profileQrCodeUrl = "profileQrCodeUrl"
    static let phoneNumber = "phoneNumber"
}

protocol ContactSerializer: class {
    
    func unserialize(json: JSON)
}

class ContactSerializerImpl: ContactSerializer {
    
    
    func unserialize(json: JSON) {
        
    }
    
}
