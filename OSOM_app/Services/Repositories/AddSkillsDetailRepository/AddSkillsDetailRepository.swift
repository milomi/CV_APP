//
//  AddSkillsDetailRepository.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 23.12.2017.
//

import Foundation
import RealmSwift
import SwiftyJSON

protocol AddSkillsDetailRepositoryDelegate: class {
    func sectionUpdated()
    func sectionDataDownloaded()
}


extension AddSkillsDetailRepositoryDelegate {
    func sectionUpdated() {}
    func sectionDataDownloaded() {}
}

protocol AddSkillsDetailRepository: class {
    
    weak var delegate: AddSkillsDetailRepositoryDelegate? { get set }
    
    func getSkillsSection(with id: Int) -> Results<Skill>
}

class AddSkillsDetailRepositoryImpl: AddSkillsDetailRepository {
    
    weak var delegate: AddSkillsDetailRepositoryDelegate?
    
    private let skillsDBRepository: SkillsDBRepository
    private let networking: SkillsNetworking
    private let addSkillsNetworking: AddSkillsNetworking
    private let serializer: SkillsSerializer
    
    
    init(skillsSectionDBRepository: SkillsDBRepository, networking: SkillsNetworking, addSkillsNetworking: AddSkillsNetworking, serializer: SkillsSerializer) {
        self.skillsDBRepository = skillsSectionDBRepository
        self.networking = networking
        self.addSkillsNetworking = addSkillsNetworking
        self.serializer = serializer
        networking.delegate = self
        addSkillsNetworking.delegate = self
    }
    
    func getSkillsSection(with id: Int) -> Results<Skill> {
        return skillsDBRepository.getSkillsInSection(id: id)
    }
    
    func addSkillToSection(skill: Skill) {
        addSkillsNetworking.setAddSkillsData(parameters: serializer.serializeSkill(skill: skill))
    }
    
}

extension AddSkillsDetailRepositoryImpl: SkillsNetworkingDelegate {
    func unknownErrorOccured() {
    }
    
    func noInternetConnection() {
        delegate?.sectionDataDownloaded()
    }
    
    func success(_ json: JSON) {
        delegate?.sectionDataDownloaded()
    }
    
}

extension AddSkillsDetailRepositoryImpl: AddSkillsNetworkingDelegate {
    func successUploaded(_ json: JSON) {
        delegate?.sectionUpdated()
    }
    
    
}
