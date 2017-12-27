//
//  AddSkillSectionRepository.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 18.12.2017.
//

import Foundation
import RealmSwift
import SwiftyJSON

protocol AddSkillSectionRepositoryDelegate: class {
    func sectionUpdated(sectionId: Int)
    func sectionsDataDownloaded()
    func noInternetConnection()
    func unknownErrorOccured()
}

protocol AddSkillSectionRepository: class {
    
    weak var delegate: AddSkillSectionRepositoryDelegate? { get set }
    
    func getSections() -> Results<SkillsSection>
    func addSkillsSection(section: SkillsSection)
    func getSkillsSection(with: Int) -> SkillsSection?
    func fetchSections()
    func updateSection(section: SkillsSection)
}

class AddSkillSectionRepositoryImpl: AddSkillSectionRepository {

    weak var delegate: AddSkillSectionRepositoryDelegate?
    
    private let sectionsDBRepository: SkillsSectionDBRepository
    private let networking: AddSkillsSectionNetworking
    private let sectionsNetworking: SkillsSectionsNetworking
    private let serializer: SkillsSerializer
    
    
    init(sectionsDBRepository: SkillsSectionDBRepository, networking: AddSkillsSectionNetworking, sectionsNetworking: SkillsSectionsNetworking, serializer: SkillsSerializer) {
        self.sectionsDBRepository = sectionsDBRepository
        self.networking = networking
        self.sectionsNetworking = sectionsNetworking
        self.serializer = serializer
        sectionsNetworking.delegate = self
        networking.delegate = self
    }
    
    func getSections() -> Results<SkillsSection> {
        return sectionsDBRepository.getSkillsSections()
    }
    
    func addSkillsSection(section: SkillsSection) {
        networking.setAddSkillsSectionData(parameters: serializer.serializeSection(section: section))
    }
    
    func fetchSections() {
        sectionsNetworking.getSkillsSections()
    }
    
    func getSkillsSection(with id: Int) -> SkillsSection? {
        return sectionsDBRepository.getSkillsSection(with: id)
    }
    
    
    func updateSection(section: SkillsSection) {
        print("update")
    }
    
}

extension AddSkillSectionRepositoryImpl: AddSkillsSectionNetworkingDelegate {
    func unknownErrorOccured() {
        delegate?.unknownErrorOccured()
    }
    
    func noInternetConnection() {
        delegate?.noInternetConnection()
    }
    
    func success(_ json: JSON) {
        guard let id = serializer.unserializeSectionId(json: json) else {
            delegate?.unknownErrorOccured()
            return
        }
        
        delegate?.sectionUpdated(sectionId: id)
    }
    
}

extension AddSkillSectionRepositoryImpl: SkillsSectionsNetworkingDelegate {
    
    func skillsSectionsDownloaded(_ json: JSON) {
        guard let sections = serializer.unserialize(json: json) else {
            return
        }
        sectionsDBRepository.addSkillsSections(SkillsSections: sections)
        delegate?.sectionsDataDownloaded()
    }
    
}
