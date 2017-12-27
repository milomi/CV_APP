//
//  SkillsSectionDBRepository.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 18.12.2017.
//

import Foundation
import RealmSwift

protocol SkillsSectionDBRepository: class {
    func getSkillsSections() -> Results<SkillsSection>
    func getSkillsSection(with id: Int) -> SkillsSection?
    func addSkillsSections(SkillsSections: [SkillsSection])
}

final class SkillsSectionDBRepositoryImpl: RealmRepositoryImpl<SkillsSection>, SkillsSectionDBRepository {
    
    func getSkillsSections() -> Results<SkillsSection> {
        return getObjects()
    }
    
    func getSkillsSection(with id: Int) -> SkillsSection? {
        let predicate = "id = \(id)"
        return getObjects(withPredicate: predicate).first
    }
    
    func addSkillsSections(SkillsSections: [SkillsSection]) {
        let results = getSkillsSections()
        remove(list: results)
        SkillsSections.forEach { (SkillsSection) in
            addObject(object: SkillsSection)
            commitWrite()

        }
        
    }
    
}
