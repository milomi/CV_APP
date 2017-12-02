//
//  LoginViewModel.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 02.12.2017.
//

import Foundation
import PKHUD
import SwiftyJSON

protocol LoginViewModelDelegate: class {
    func loginSuccessed()
    func loginFailed()
}


protocol LoginViewModel: class {
    weak var delegate: LoginViewModelDelegate? { get set }
    
    func login(email: String, password: String)
}

final class LoginViewModelImpl: LoginViewModel {
    
    weak var delegate: LoginViewModelDelegate?
    
    let repository: LoginRepository
    
    init(repository: LoginRepository) {
        self.repository = repository
        repository.delegate = self
    }

    
    func login(email: String, password: String) {
        HUD.show(.progress)
        let user = User()
        user.password = password
        user.email = email
        repository.login(loginUser: user)
    }
    
}

extension LoginViewModelImpl: LoginRepositoryDelegate {
    func loginSuccessed() {
        HUD.flash(.success)
        delegate?.loginSuccessed()
    }
    
    func errorOccured(_ error: String?) {
        HUD.flash(.error)
        delegate?.loginFailed()
    }
    
    func noInternetConnection() {
        HUD.flash(.error)
    }
    
    func unknownErrorOccured() {
        HUD.flash(.error)
        delegate?.loginFailed()
    }
    
}

