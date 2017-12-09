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
    func CreateAboutSuccessed()
    func errorOccured(_ error: String?)
    func noInternetConnection()
    func unknownErrorOccured()
}

protocol CreateAboutRepository: class {
    weak var delegate: CreateAboutRepositoryDelegate? { get set }
    
    func createAbout(createAboutUser: SignUpUserModel)
}

class CreateAboutRepositoryImpl: CreateAboutRepository {
    
    weak var delegate: CreateAboutRepositoryDelegate?
    
    fileprivate var networking: PersonalNetworking
    fileprivate var serializer: PersonalSerializer
    
    init(networking: PersonalNetworking,
         serializer: PersonalSerializer) {
        self.networking = networking
        self.serializer = serializer
        setupDelegates()
    }

    fileprivate func setupDelegates() {
        networking.delegate = self
    }
    
    func createAbout(createAboutUser: SignUpUserModel) {
        
    }
    
}

extension CreateAboutRepositoryImpl: PersonalNetworkingDelegate {
    func success(_ json: JSON) {
        
    }
    
    func handleClientCredentialsSuccess(_ json: JSON) {
        let personalData =  serializer.unserializeData(json: json)
        delegate?.CreateAboutSuccessed()
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


