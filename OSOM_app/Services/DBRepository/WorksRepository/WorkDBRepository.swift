//
//  WorkDBRepository.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 17.12.2017.
//

import Foundation
import RealmSwift

protocol WorkDBRepository: class {
    func getWorks() -> Results<Work>
    func getWork(with id: Int) -> Work?
    func addWorks(works: [Work])
}

final class WorkDBRepositoryImpl: RealmRepositoryImpl<Work>, WorkDBRepository {
    
    func getWorks() -> Results<Work> {
        return getObjects()
    }
    
    func getWork(with id: Int) -> Work? {
        let predicate = "id = \(id)"
        return getObjects(withPredicate: predicate).first
    }
    
    func addWorks(works: [Work]) {
        let results = getWorks()
        remove(list: results)
        works.forEach { (Work) in
            addObject(object: Work)
        }
    }
    
}
