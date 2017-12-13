//
//  AddEducationDetailViewModel.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 09.12.2017.
//

import Foundation

protocol AddEducationDetailViewModel: class {
    func saveSchool(school:School)
    func getSchool(with id: Int) -> School
}

final class AddEducationDetailViewModelImpl: AddEducationDetailViewModel {
    
    private let repository: AddEducationRepository
    
    init(repository: AddEducationRepository) {
        self.repository = repository
    }
    
    func saveSchool(school: School) {
        repository.addSchool(school: school)
    }
    
    func getSchool(with id: Int) -> School {
        guard let school = repository.getSchool(with: id) else {
            
            let school = School()
            repository.addSchool(school: school)
            return school
        }
        return school
    }
    
}

extension AddEducationDetailViewModelImpl: AddEducationRepositoryDelegate {
    
}
