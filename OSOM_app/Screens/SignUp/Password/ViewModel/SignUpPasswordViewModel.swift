//
//  SignUpPasswordViewModel.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 02.12.2017.
//

import Foundation
import PKHUD
import SwiftyJSON

protocol SignUpPasswordViewModelDelegate: class {
    func signUpSuccessed()
    func signUpFailed()
}


protocol SignUpPasswordViewModel: class {
    weak var delegate: SignUpPasswordViewModelDelegate? { get set }
    
    func register(password: String)
}

final class SignUpPasswordViewModelImpl: SignUpPasswordViewModel {
    
    weak var delegate: SignUpPasswordViewModelDelegate?
    
    private var user: SignUpUserModel
    let repository: SignUpRepository
    
    init(user: SignUpUserModel, repository: SignUpRepository) {
        self.user = user
        self.repository = repository
        repository.delegate = self
    }
    
    func getUser() -> SignUpUserModel {
        return user
    }
    
    func register(password: String) {
        HUD.show(.progress)
        user.password = password
        repository.register(signUpUser: user)
    }
    
}

extension SignUpPasswordViewModelImpl: SignUpRepositoryDelegate {
    
    func accountRegistered() {
        HUD.flash(.success)
        delegate?.signUpSuccessed()
    }
    
    func errorOccured(_ error: String?) {
        HUD.flash(.labeledError(title: "error", subtitle: nil), delay: 1)
        delegate?.signUpFailed()
    }
    
    func noInternetConnection() {
        HUD.flash(.labeledError(title: "No internet", subtitle: nil), delay: 1)
        delegate?.signUpFailed()
    }
    
    func unknownErrorOccured() {
        HUD.flash(.labeledError(title: "error", subtitle: nil), delay: 1)
        delegate?.signUpFailed()
    }
}
