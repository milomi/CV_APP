//
//  EducationViewModel.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 30.12.2017.
//

import Foundation

protocol EducationViewModel: class {
    func getSchools() -> [School]
}

class EducationViewModelImpl: EducationViewModel {
    
    fileprivate let repository: SchoolDBRepository
    
    init(repository: SchoolDBRepository) {
        self.repository = repository
    }
    
    func getSchools() -> [School] {
        return Array(repository.getSchools())
    }
}
