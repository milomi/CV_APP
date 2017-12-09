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
}

final class SchoolDBRepositoryImpl: RealmRepositoryImpl<School>, SchoolDBRepository {
    
    func getSchools() -> Results<School> {
      return getObjects()
    }
    
}
