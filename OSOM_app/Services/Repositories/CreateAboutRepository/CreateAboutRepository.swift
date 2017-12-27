//
//  CreateAboutRepository.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 03.12.2017.
//

import Foundation
import SwiftyJSON
import Foundation

protocol CreateAboutRepositoryDelegate: class {
    func getAboutSuccessed(photo: UIImage, personalStatment: String)
    func errorOccured(_ error: String?)
    func noInternetConnection()
    func unknownErrorOccured()
    func postSuccess()
}

protocol CreateAboutRepository: class {
    weak var delegate: CreateAboutRepositoryDelegate? { get set }
    
    func createAbout(_ photo: UIImage, _ personalStatement: String)
    func getPersonalData() 
}

class CreateAboutRepositoryImpl: CreateAboutRepository {
    
    weak var delegate: CreateAboutRepositoryDelegate?
    
    fileprivate var networking: PersonalNetworking
    fileprivate var serializer: PersonalSerializer
    fileprivate var createNetworking: CreateAboutNetworking
    
    init(networking: PersonalNetworking,
         createNetworking: CreateAboutNetworking,
         serializer: PersonalSerializer) {
        self.networking = networking
        self.createNetworking = createNetworking
        self.serializer = serializer
        setupDelegates()
    }

    fileprivate func setupDelegates() {
        networking.delegate = self
        createNetworking.delegate = self
    }
    
    func createAbout(_ photo: UIImage, _ personalStatement: String) {
        createNetworking.postPersonalData(parameters: serializer.serialize(photo, personalStatement))
    }
    
    func getPersonalData() {
        networking.getPersonalData()
    }
    
}

extension CreateAboutRepositoryImpl: PersonalNetworkingDelegate {
    func success(_ json: JSON) {
        let data = serializer.unserializeData(json: json)
        
        guard let photo = data.0, let statment = data.1 else {
            delegate?.unknownErrorOccured()
            return
        }
        
        delegate?.getAboutSuccessed(photo: photo, personalStatment: statment)
    }
    
    func errorOccured(_ json: JSON) {
        delegate?.unknownErrorOccured()
    }
    
    func noInternetConnection() {
        delegate?.noInternetConnection()
    }
    
    func unknownErrorOccured() {
        delegate?.unknownErrorOccured()
    }
    
}

extension CreateAboutRepositoryImpl: CreateAboutNetworkingDelegate {
    func createdSuccess(_ json: JSON) {
        delegate?.postSuccess()
    }

}


