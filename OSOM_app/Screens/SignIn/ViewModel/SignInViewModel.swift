//
//  SignInViewModel.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 19/07/2017.
//
//

import Foundation

protocol SignInViewModelDelegate: class {
    func success()
    func error(isErrorFieldHidden: Bool)
    //func showAlert(error: SignInError)
    func showAlert(title: String, message: String)
}

protocol SignInViewModel {
    
    var delegate: SignInViewModelDelegate? { get set }
    var email: String { get set }
    var password: String { get set }
    
    
}

class SignInViewModelImpl: SignInViewModel {

    weak var delegate: SignInViewModelDelegate?
    
    var email: String = "" 
    var password: String = ""

}
