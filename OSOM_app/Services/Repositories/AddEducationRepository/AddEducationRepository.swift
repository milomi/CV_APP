//
//  AddEducationRepository.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 09.12.2017.
//

import Foundation
import RealmSwift

protocol AddEducationRepository {
    func getSchools() -> Results<School>
    func addSchool(school: School)
}

class AddEducationRepositoryImpl: AddEducationRepository {

    private let schoolDBRepository: SchoolDBRepository
    private let networking: AddEducationNetworking
    private let serializer: EducationSerializer

    
    init(schoolDBRepository: SchoolDBRepository, networking: AddEducationNetworking, serializer: EducationSerializer) {
        self.schoolDBRepository = schoolDBRepository
        self.networking = networking
        self.serializer = serializer
    }
    
    func getSchools() -> Results<School> {
        return schoolDBRepository.getSchools()
    }
    
    func addSchool(school: School) {
        networking.setAddEducationData(parameters: serializer.serialize(school: school))
    }
}
