//
//  SkillsViewModel.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 31.12.2017.
//

import Foundation

protocol SkillsViewModel: class {
    func getSkillsSections() -> [SkillsSection]
}

class SkillsViewModelImpl: SkillsViewModel {
    
    fileprivate let repository: SkillsSectionDBRepository
    
    init(repository: SkillsSectionDBRepository) {
        self.repository = repository
    }
    
    func getSkillsSections() -> [SkillsSection] {
        return Array(repository.getSkillsSections())
    }
}
