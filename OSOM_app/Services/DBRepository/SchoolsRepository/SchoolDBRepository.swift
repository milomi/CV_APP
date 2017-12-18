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
    func addSchools(schools: [School]) 
}

final class SchoolDBRepositoryImpl: RealmRepositoryImpl<School>, SchoolDBRepository {
    
    func getSchools() -> Results<School> {
      return getObjects()
    }
    
    func getSchool(with id: Int) -> School? {
        let predicate = "schoolID = \(id)"
        return getObjects(withPredicate: predicate).first
    }
    
    func addSchools(schools: [School]) {
        let results = getSchools()
        remove(list: results)
        schools.forEach { (school) in
            addObject(object: school)
        }
    }

}
