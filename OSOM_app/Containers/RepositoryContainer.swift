//
//  RepositoryContainer.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 26.11.2017.
//

import Foundation
import UIKit

class RepositoryContainer {
    
    static let shared = RepositoryContainer()
    
    func getSignUp() -> SignUpRepository {
        return SignUpRepositoryImpl(emailValidationNetworking: EmailValidationNetworkingImpl(), emailValidationSerializer: EmailValidationSerializerImpl(), signUpNetworking: SignUpNetworkingImpl(), authorizationSerializer: AuthorizationSerializerImpl())
    }
    
    func getLogin() -> LoginRepository {
        let networking = AuthorizationNetworkingImpl()
        let serializer = AuthorizationSerializerImpl()
        return LoginRepositoryImpl(authorizationNetworking: networking, authorizationSerializer: serializer)
    }
    
    func getAddEducation() -> AddEducationRepository {
        let dbRepository = SchoolDBRepositoryImpl()
        let networking = AddEducationNetworkingImpl()
        let schoolNetworking = SchoolsNetworkingImpl()
        let serializer = EducationSerializerImpl()
        return AddEducationRepositoryImpl(schoolDBRepository: dbRepository, networking: networking, schoolsNetworking: schoolNetworking, serializer: serializer)
    }
    
    func getCreateAbout() -> CreateAboutRepository {
        let networking = PersonalNetworkingImpl()
        let serializer = PersonalSerializerImpl()
        let createNetworking = CreateAboutNetworkingImpl()
        return CreateAboutRepositoryImpl(networking: networking, createNetworking: createNetworking, serializer: serializer)
    }
    
    func getAddWork() -> AddWorkRepository {
        let addNetworking = AddWorkNetworkingImpl()
        let serializer = WorkSerializerImpl()
        let dbRepository = WorkDBRepositoryImpl()
        let networking = WorksNetworkingImpl()
        
        return AddWorkRepositoryImpl(workDBRepository: dbRepository,
                                     networking: addNetworking,
                                     worksNetworking: networking,
                                     serializer: serializer)
    }
    
    func getSkillsSection() -> AddSkillSectionRepository {
        let skillsSectionDB = SkillsSectionDBRepositoryImpl()
        let skillsSectionNetworking = AddSkillsSectionNetworkingImpl()
        let sectionsNetworking = SkillsSectionsNetworkingImpl()
        let skillsSerializer = SkillsSerializerImpl()
        
        return AddSkillSectionRepositoryImpl(sectionsDBRepository: skillsSectionDB, networking: skillsSectionNetworking, sectionsNetworking: sectionsNetworking, serializer: skillsSerializer)
    }
    
    func getSkillDetailRepository() -> AddSkillsDetailRepository {
        let skillsDBRepository = SkillsDBRepositoryImpl()
        let networking = SkillsNetworkingImpl()
        let addSkillsNetworking = AddSkillsNetworkingImpl()
        let skillsSerializer = SkillsSerializerImpl()
        
        return AddSkillsDetailRepositoryImpl(skillsSectionDBRepository: skillsDBRepository, networking: networking, addSkillsNetworking: addSkillsNetworking, serializer: skillsSerializer)
    }
}
