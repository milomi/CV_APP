//
//  SignUpNameView.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 15.10.2017.
//

import Foundation

fileprivate struct Constants {
    struct NameEditField {
        static let title = Name
        static let placeholder = Type your name
    }
}

class SignUpNameView: BaseSignUpView {
    
    let nameEditField: BaseEditField = {
        let field = BaseEditField()
        field.t
        return field
    }()
    
    func setupView() {
        
    }
    
}
