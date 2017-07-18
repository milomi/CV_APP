//
//  String+Localized.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 18/07/2017.
//
//

import Foundation

extension String {
    
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
}
