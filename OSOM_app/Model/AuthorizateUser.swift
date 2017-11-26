//
//  AuthorizateUser.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 26.11.2017.
//

import Foundation

protocol AuthorizateUser {
    var email: String? { get set }
    var password: String? { get set }
    var firstName: String? { get set }
    var lastName: String? { get set }
}

final class AuthorizateUserImpl: AuthorizateUser {
    var email: String?
    var password: String?
    var firstName: String?
    var lastName: String?
}
