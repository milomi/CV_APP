//
//  AddEducationDetailViewModel.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 09.12.2017.
//

import Foundation
import PKHUD

protocol AddEducationDetailViewModelDelegate: class {
    func dataSaved()
    func errorOccured()
}

protocol AddEducationDetailViewModel: class {
    weak var delegate: AddEducationDetailViewModelDelegate? { get set }

    func saveSchool(school:School)
    func getSchool() -> School?
}

final class AddEducationDetailViewModelImpl: AddEducationDetailViewModel {
    
    weak var delegate: AddEducationDetailViewModelDelegate?
    private let repository: AddEducationRepository
    private var schoolId: Int = -1 {
        didSet {
            print("why")
        }
    }
    
    init(schoolId: Int?, repository: AddEducationRepository) {
        self.repository = repository
        self.schoolId = schoolId ?? -1
        repository.delegate = self 
    }
    
    func saveSchool(school: School) {
        HUD.show(.progress)
        if schoolId == -1 {
            repository.addSchool(school: school)
        } else {
            school.schoolID = schoolId
            repository.updateSchool(school: school)
        }
    }
    
    func getSchool() -> School? {
        guard let school = repository.getSchool(with: schoolId) else {
            return nil
        }
        
        return school
    }
    
}

extension AddEducationDetailViewModelImpl: AddEducationRepositoryDelegate {
    func schoolUpdated() {
        HUD.flash(.success)
        delegate?.dataSaved()
    }
    
    func noInternetConnection() {
        HUD.flash(.error)
    }
    
    func unknownErrorOccured() {
        HUD.flash(.error)
    }
    
}
