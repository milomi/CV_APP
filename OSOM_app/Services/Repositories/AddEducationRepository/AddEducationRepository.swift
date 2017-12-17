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
    func schoolsDataDownloaded()
    func noInternetConnection()
    func unknownErrorOccured()
}

protocol AddEducationRepository: class {
    
    weak var delegate: AddEducationRepositoryDelegate? { get set }

    func getSchools() -> Results<School>
    func addSchool(school: School)
    func getSchool(with: Int) -> School?
    func fetchSchools()
    func updateSchool(school: School)
}

class AddEducationRepositoryImpl: AddEducationRepository {
    
    weak var delegate: AddEducationRepositoryDelegate?

    private let schoolDBRepository: SchoolDBRepository
    private let networking: AddEducationNetworking
    private let schoolsNetworking: SchoolsNetworking
    private let serializer: EducationSerializer

    
    init(schoolDBRepository: SchoolDBRepository, networking: AddEducationNetworking, schoolsNetworking: SchoolsNetworking, serializer: EducationSerializer) {
        self.schoolDBRepository = schoolDBRepository
        self.networking = networking
        self.schoolsNetworking = schoolsNetworking
        self.serializer = serializer
        schoolsNetworking.delegate = self
    }
    
    func getSchools() -> Results<School> {
        return schoolDBRepository.getSchools()
    }
    
    func addSchool(school: School) {
        networking.setAddEducationData(parameters: serializer.serialize(school: school))
    }
    
    func updateSchool(school: School) {
        networking.updateEducationData(parameters: serializer.serialize(school: school))
    }
    
    func getSchool(with id: Int) -> School? {
       return schoolDBRepository.getSchool(with: id)
    }
    
    func fetchSchools() {
        schoolsNetworking.getSchools()
    }
}

extension AddEducationRepositoryImpl: AddEducationNetworkingDelegate {
    func unknownErrorOccured() {
        delegate?.unknownErrorOccured()
    }
    
    func noInternetConnection() {
        delegate?.noInternetConnection()
    }
    
    func success(_ json: JSON) {
        delegate?.schoolsDataDownloaded()
    }
    

}

extension AddEducationRepositoryImpl: SchoolsNetworkingDelegate {
    func schoolsDownloaded(_ json: JSON) {
        guard let schools = serializer.unserialize(json: json) else {
            return
        }
        
        schoolDBRepository.addSchools(schools: schools)
    }
    
    
}
