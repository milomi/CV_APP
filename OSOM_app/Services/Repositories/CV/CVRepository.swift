//
//  CVRepository.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 30.12.2017.
//

import Foundation
import SwiftyJSON

protocol CVRepository {
    
    func deserializeToDB(json: JSON)
    
}

class CVRepositoryImpl: CVRepository {
    
    
    private let skillsSerializer = SkillsSerializerImpl()
    private let schoolSerializer = EducationSerializerImpl()
    private let workSerializer = WorkSerializerImpl()
    private let contactSerializer = ContactSerializerImpl()
    private let userSerializer = UserSerializerImpl()

    init() {
        
    }
    
    func deserializeToDB(json: JSON) {
        
        if let schools = schoolSerializer.unserialize(json: json) {
            SchoolDBRepositoryImpl().addSchools(schools: schools)
        }
        
        if let works = workSerializer.unserialize(json: json) {
            WorkDBRepositoryImpl().addWorks(works: works)
        }
        
        if let skillSections = skillsSerializer.unserialize(json: json) {
            
        }
        

        UserDBRepositoryImpl().addObject(object: userSerializer.unserialize(json: json))
        
    }
}
