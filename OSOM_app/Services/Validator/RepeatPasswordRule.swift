//
//  RepeatPasswordRule.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 01.12.2017.
//

import Foundation
import UIKit
import SwiftValidator

fileprivate struct LocalizedString {
    static let errorMessage = "validator.repeatPassword"
}

final class RepeatPasswordRule: Rule {
    
    private var compareField: UITextField
    
    init(compareField: UITextField){
        self.compareField = compareField
    }
    
    func validate(_ value: String) -> Bool {
        guard let text = compareField.text else {
            return false
        }
        
        return text.elementsEqual(value)
    }
    
    func errorMessage() -> String {
        return LocalizedString.errorMessage.localized()
    }
    
}
