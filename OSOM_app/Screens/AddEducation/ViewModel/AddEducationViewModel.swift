//
//  AddEducationViewModel.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 18.11.2017.
//

import Foundation
import RealmSwift

protocol AddEducationViewModelDelegate: class {
    func reloadData()
}

protocol AddEducationViewModel: class {
    weak var delegate: AddEducationViewModelDelegate? { get set }

    func getSchools() -> Results<School>
    func getSchool(for index: Int) -> School?
}

class AddEducationViewModelImpl: AddEducationViewModel {

    weak var delegate: AddEducationViewModelDelegate?
    
    private let schools: Results<School>
    private let repository: AddEducationRepository
    private var notificationToken: NotificationToken?

    
    init(repository: AddEducationRepository) {
        self.repository = repository
        self.schools = repository.getSchools()
        setupObserver()
    }
    
    func getSchools() -> Results<School> {
        return schools
    }
    
    func getSchool(for index: Int) -> School? {
        if schools.count > index {
            return schools[index]
        } else {
            return nil
        }
    }
    
    func addSchool(school: School) {
        repository.addSchool(school: school)
    }
    
    func setupObserver() {
        notificationToken = schools.observe { (changes: RealmCollectionChange) in
            self.delegate?.reloadData()
        }
    }
    
}
