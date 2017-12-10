//
//  SchoolDBRepository.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 09.12.2017.
//

import Foundation
import RealmSwift

protocol SchoolDBRepository: class {
    func getSchools() -> Results<School>
    func getSchool(with id: Int) -> School? 
}

final class SchoolDBRepositoryImpl: RealmRepositoryImpl<School>, SchoolDBRepository {
    
    func getSchools() -> Results<School> {
      return getObjects()
    }
    
    func getSchool(with id: Int) -> School? {
        let predicate = "id = \(id)"
        return getObjects(withPredicate: predicate).first
    }
    
}
