//
//  ContactViewModel.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 31.12.2017.
//

import Foundation

protocol ContactViewModel: class {
    func getUser() -> User
}

class ContactViewModelImpl: ContactViewModel {
    
    fileprivate let repository: UserDBRepositoryImpl
    
    init(repository: UserDBRepositoryImpl) {
        self.repository = repository
    }
    
    func getUser() -> User {
        return repository.getUser()
    }
}
