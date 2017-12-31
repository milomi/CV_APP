//
//  WorkViewModel.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 31.12.2017.
//

import Foundation

protocol WorkViewModel: class {
    func getWorks() -> [Work]
}

class WorkViewModelImpl: WorkViewModel {
    
    fileprivate let repository: WorkDBRepository
    
    init(repository: WorkDBRepository) {
        self.repository = repository
    }
    
    func getWorks() -> [Work] {
        return Array(repository.getWorks())
    }
}
