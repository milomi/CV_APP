//
//  UserDBRepository.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 09.12.2017.
//

import Foundation
import RealmSwift

protocol UserDBRepository: class {
    func logOutUser(sendNotification: Bool)
    func getUser() -> User
    func removeAllUserData()
}

final class UserDBRepositoryImpl: RealmRepositoryImpl<User>, UserDBRepository {
    
    func logOutUser(sendNotification: Bool) {
        if sendNotification {
            NotificationCenter.default.post(name: .invalidToken, object: nil)
        }
    }
    
    func removeAllUserData() {
        realm.beginWrite()
        realm.deleteAll()
        commitWrite()
    }
    
    func getUser() -> User {
        guard let user = getObject() else {
            let user = User()
            addObject(object: user)
            return user
        }
        
        return user
    }
    
}
