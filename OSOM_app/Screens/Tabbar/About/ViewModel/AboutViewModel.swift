//
//  AboutViewModel.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 27.12.2017.
//

import Foundation

protocol AboutViewModelDelegate: class {
}

protocol AboutViewModel: class {
    
    var delegate: AboutViewModelDelegate? { get set }
    func getUser() -> User

}

class AboutViewModelImpl: AboutViewModel {

    weak var delegate: AboutViewModelDelegate?
    
    private let repository: UserDBRepository
    
    init(repository: UserDBRepository) {
        self.repository = repository
    }
    
    func getUser() -> User {
        return repository.getUser()
    }
    

}
