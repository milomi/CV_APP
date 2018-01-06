//
//  AboutViewModel.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 27.12.2017.
//

import Foundation
import PKHUD
import SwiftyJSON

protocol AboutViewModelDelegate: class {
    func userPhotoFetched(photo: UIImage)
}

protocol AboutViewModel: class {
    
    var delegate: AboutViewModelDelegate? { get set }
    func getUser() -> User
    func fetchUserPhoto()

}

class AboutViewModelImpl: AboutViewModel {

    weak var delegate: AboutViewModelDelegate?
    
    private let repository: UserDBRepository
    private let networking: UserPhotoNetworking
    
    init(repository: UserDBRepository) {
        self.repository = repository
        self.networking = UserPhotoNetworkingImpl()
        networking.delegate = self
    }
    
    func getUser() -> User {
        return repository.getUser()
    }
    
    func fetchUserPhoto() {
        networking.getUserPhoto(url: repository.getUser().photoUrl)
    }
    

}

extension AboutViewModelImpl: UserPhotoNetworkingDelegate {
    func unknownErrorOccured() {
        HUD.flash(.error)
    }
    
    func noInternetConnection() {
        HUD.flash(.error)
    }
    
    func success(_ json: JSON) {
        let data = PersonalSerializerImpl().unserializePhoto(json: json)
        delegate?.userPhotoFetched(photo: data ?? #imageLiteral(resourceName: "picturePlaceholder"))
    }
    
    
}
