//
//  AddSkillsViewModel.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 18.11.2017.
//

import Foundation
import RealmSwift
import PKHUD

protocol AddSkillsViewModelDelegate: class {
    func reloadData()
    func sectionUpdated(sectionId: Int)
}

protocol AddSkillsViewModel: class {
    var delegate: AddSkillsViewModelDelegate? { get set }

    func getSections() -> Results<SkillsSection>
    func getSkillsSection(for index: Int) -> SkillsSection?
    func addSection(with name: String)
    func fetchSections()
}

class AddSkillsViewModelImpl: AddSkillsViewModel {
    
    weak var delegate: AddSkillsViewModelDelegate?
    
    private let sections: Results<SkillsSection>
    private let repository: AddSkillSectionRepository
    private var notificationToken: NotificationToken?
    
    
    init(repository: AddSkillSectionRepository) {
        self.repository = repository
        self.sections = repository.getSections()
        setupObserver()
        repository.delegate = self
    }
    
    func getSections() -> Results<SkillsSection> {
        return sections
    }
    
    func getSkillsSection(for index: Int) -> SkillsSection? {
        if sections.count > index {
            return sections[index]
        } else {
            return nil
        }
    }
    
    func addSection(with name: String) {
        let section = SkillsSection()
        section.name = name
        repository.addSkillsSection(section: section)
    }
    
    func setupObserver() {
        notificationToken = sections.observe { (changes: RealmCollectionChange) in
            self.delegate?.reloadData()
        }
    }
    
    func fetchSections() {
        repository.fetchSections()
    }
}

extension AddSkillsViewModelImpl: AddSkillSectionRepositoryDelegate {
    func sectionUpdated(sectionId: Int) {
        HUD.hide()
        delegate?.sectionUpdated(sectionId: sectionId)
    }

    
    func sectionsDataDownloaded() {
        HUD.hide()
        delegate?.reloadData()
    }
    
    func noInternetConnection() {
        HUD.flash(.error)
    }
    
    func unknownErrorOccured() {
        HUD.flash(.error)
    }

}
