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
    func reloadData()
}

protocol CreateAboutViewModel: class {
    weak var delegate: CreateAboutViewModelDelegate? { get set }
    func saveData(_ personalStatment: String)
    func fetchData()
    func updateUserPhoto(image: UIImage)
    func getUserPhoto() -> UIImage?
    func getPersonalStatment() -> String?

}

final class CreateAboutViewModelImpl: CreateAboutViewModel {
    
    weak var delegate: CreateAboutViewModelDelegate?
    
    fileprivate let networking: PersonalNetworking
    fileprivate let serializer: PersonalSerializer
    
    private var userPhoto: UIImage?
    private var personalStatment: String?
    
    private var getQueue = DispatchGroup()
    
    init(networking: PersonalNetworking, serializer: PersonalSerializer) {
        self.networking = networking
        self.serializer = serializer
        
        networking.delegate = self
    }
    
    func fetchData() {
        getQueue.enter()
        HUD.show(.progress)
        networking.getPersonalData()
        notifyWhenFetchingData()
    }
    
    func updateUserPhoto(image: UIImage) {
        HUD.show(.progress)
        self.userPhoto = image
    }
    
    func getUserPhoto() -> UIImage? {
        return userPhoto
    }
    
    func getPersonalStatment() -> String? {
        return personalStatment
    }
    
    func saveData(_ personalStatment: String) {
        HUD.show(.progress)
        guard let userPhoto = userPhoto else {
            delegate?.saveFailed()
            return
        }
        
        networking.postPersonalData(parameters: serializer.serialize(userPhoto,personalStatment))
    }
    
    func notifyWhenFetchingData() {
        
        getQueue.notify(queue: DispatchQueue.main) {
            HUD.hide()
            self.delegate?.reloadData()
        }
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
        
        guard let photo = data.0, let statment = data.1 else {
            HUD.flash(.success)
            delegate?.savedWithSuccess()
            return
        }
        
        getQueue.leave()
        userPhoto = photo
        personalStatment = statment
    }
    
}
