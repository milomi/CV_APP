//
//  CreateAboutViewModel.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 02.12.2017.
//

import Foundation
import UIKit
import PKHUD
import SwiftyJSON

protocol CreateAboutViewModelDelegate: class {
    func savedWithSuccess()
    func saveFailed()
}

protocol CreateAboutViewModel: class {
    weak var delegate: CreateAboutViewModelDelegate? { get set }
    func saveData(_ personalStatment: String)
    func fetchData()
    func updateUserPhoto(image: UIImage)

}

final class CreateAboutViewModelImpl: CreateAboutViewModel {
    
    weak var delegate: CreateAboutViewModelDelegate?
    
    fileprivate let networking: PersonalNetworking
    fileprivate let serializer: PersonalSerializer
    
    private var userPhoto: UIImage?
    private var personalStatment: String?
    
    init(networking: PersonalNetworking, serializer: PersonalSerializer) {
        self.networking = networking
        self.serializer = serializer
        
        networking.delegate = self
    }
    
    func fetchData() {
        HUD.show(.progress)
        networking.getPersonalData()
    }
    
    func updateUserPhoto(image: UIImage) {
        //HUD.show(.progress)
        self.userPhoto = image
    }
    
    func saveData(_ personalStatment: String) {
        guard let userPhoto = userPhoto else {
            delegate?.saveFailed()
            return
        }
        
        networking.postPersonalData(parameters: serializer.serialize(userPhoto,personalStatment))
    }

}

extension CreateAboutViewModelImpl: PersonalNetworkingDelegate {
    func unknownErrorOccured() {
        HUD.flash(.error)
        delegate?.saveFailed()
    }
    
    func noInternetConnection() {
        HUD.flash(.error)
        delegate?.saveFailed()
    }
    
    func success(_ json: JSON) {
        let data = serializer.unserializeData(json: json)
        HUD.flash(.success)
        delegate?.savedWithSuccess()    
    }
    
}
