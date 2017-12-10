//
//  AddEducationRepository.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 09.12.2017.
//

import Foundation
import RealmSwift
import SwiftyJSON

protocol AddEducationRepositoryDelegate: class {
    
}

protocol AddEducationRepository: class {
    func getSchools() -> Results<School>
    func addSchool(school: School)
    func getSchool(with: Int) -> School?
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
    
    func getSchool(with id: Int) -> School? {
       return schoolDBRepository.getSchool(with: id)
    }
}

extension AddEducationRepositoryImpl: AddEducationNetworkingDelegate {
    func unknownErrorOccured() {
        
    }
    
    func noInternetConnection() {
    }
    
    func success(_ json: JSON) {
    
    }
    

}
