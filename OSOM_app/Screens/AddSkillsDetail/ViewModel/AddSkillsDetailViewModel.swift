//
//  AddSkillsDetailViewModel.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 23.12.2017.
//

import Foundation
import RealmSwift

protocol AddSkillsDetailViewModelDelegate: class {
    func reloadData()
}

protocol AddSkillsDetailViewModel: class {
    var delegate: AddSkillsDetailViewModelDelegate? { get set }
    
    func getSkills() -> Results<Skill>
    func getSkill(for index: Int) -> Skill?
}

class AddSkillsDetailViewModelImpl: AddSkillsDetailViewModel {
    
    weak var delegate: AddSkillsDetailViewModelDelegate?
    
    private let sectionId: Int
    private let repository: AddSkillsDetailRepository
    private var notificationToken: NotificationToken?
    private var skills: Results<Skill>
    
    
    init(repository: AddSkillsDetailRepository, sectionId: Int) {
        self.repository = repository
        self.sectionId = sectionId
        skills = repository.getSkillsSection(with: sectionId)
        setupObserver()
    }


    func addSkill(skill: SkillsSection) {
        
    }
    
    func setupObserver() {
        notificationToken = skills.observe { (changes: RealmCollectionChange) in
            self.delegate?.reloadData()
        }
    }
    
    func getSkills() -> Results<Skill> {
        return skills
    }
    
    func getSkill(for index: Int) -> Skill? {
        if index < skills.count {
            return skills[index]
        } else {
            return nil
        }
    }
}
