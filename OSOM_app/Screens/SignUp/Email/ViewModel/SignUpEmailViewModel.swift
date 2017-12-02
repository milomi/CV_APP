//
//  SignUpEmailViewModel.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 26.11.2017.
//

import Foundation
import PKHUD

protocol SignUpEmailViewModelDelegate: class {
    func badEmail(_ response: String)
    func emailIsAvailable()
}

protocol SignUpEmailViewModel: class {
    weak var delegate: SignUpEmailViewModelDelegate? { get set }

    func checkEmail(email: String)
    func getUser() -> SignUpUserModel
}

final class SignUpEmailViewModelImpl: SignUpEmailViewModel {
    
    weak var delegate: SignUpEmailViewModelDelegate?
    
    private var user: SignUpUserModel
    let repository: SignUpRepository

    init(user: SignUpUserModel, repository: SignUpRepository) {
        self.user = user
        self.repository = repository
        repository.emailValidatorDelegate = self
    }
    
    func getUser() -> SignUpUserModel {
        return user
    }
    
    func checkEmail(email: String) {
        HUD.show(.progress)
        user.email = email
        repository.checkEmail(email: email)
    }
    
}

extension SignUpEmailViewModelImpl: EmailValidatorDelegate {
    func badEmail(_ response: String) {
        HUD.flash(.labeledError(title: "error", subtitle: nil), delay: 1)
        delegate?.badEmail(response)
    }
    
    func emailIsAvailable() {
        HUD.flash(.success)
        delegate?.emailIsAvailable()
    }
    
}
