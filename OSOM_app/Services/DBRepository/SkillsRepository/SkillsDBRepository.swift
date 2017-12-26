//
//  SkillsDBRepository.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 24.12.2017.
//

import Foundation
import RealmSwift

protocol SkillsDBRepository: class {
    func getSkillsInSection(id: Int) -> Results<Skill>
}

final class SkillsDBRepositoryImpl: RealmRepositoryImpl<Skill>, SkillsDBRepository {
    
    func getSkillsInSection(id: Int) -> Results<Skill> {
        let predicate = "sectionId = \(id)"

        return getObjects(withPredicate: predicate)
    }

}
