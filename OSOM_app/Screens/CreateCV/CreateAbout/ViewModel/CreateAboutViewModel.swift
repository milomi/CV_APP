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
    
    fileprivate let repository: CreateAboutRepository
    
    private var userPhoto: UIImage?
    private var personalStatment: String?
    
    init(repository: CreateAboutRepository) {
        self.repository = repository
        repository.delegate = self
    }
    
    func fetchData() {
        repository.getPersonalData()
    }
    
    func updateUserPhoto(image: UIImage) {
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
            HUD.flash(.labeledError(title: "error", subtitle: "No photo"))
            delegate?.saveFailed()
            return
        }
        
        repository.createAbout(userPhoto, personalStatment)
    }

}

extension CreateAboutViewModelImpl: CreateAboutRepositoryDelegate {
    
    func postSuccess() {
        HUD.flash(.success)
        delegate?.savedWithSuccess()
    }
    
    
    func getAboutSuccessed(photo: UIImage, personalStatment: String) {
        userPhoto = photo
        self.personalStatment = personalStatment
        delegate?.reloadData()
    }
    
    func unknownErrorOccured() {
        HUD.flash(.error)
        delegate?.saveFailed()
    }
    
    func noInternetConnection() {
        HUD.flash(.error)
        delegate?.saveFailed()
    }
    
    func errorOccured(_ error: String?) {
        HUD.flash(.error)
        delegate?.saveFailed()
    }
    
}
