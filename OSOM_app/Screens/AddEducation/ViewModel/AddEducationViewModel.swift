//
//  AddEducationViewModel.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 18.11.2017.
//

import Foundation
import RealmSwift

protocol AddEducationViewModel: class {
    func getSchools() -> Results<School>
}

class AddEducationViewModelImpl: AddEducationViewModel {
    
    private let schools: Results<School>
    private let repository: AddEducationRepository
    
    init(repository: AddEducationRepository) {
        self.repository = repository
        self.schools = repository.getSchools()
    }
    
    func getSchools() -> Results<School> {
        return schools
    }
    
    func addSchool(school: School) {
        repository.addSchool(school: school)
    }
    
}
