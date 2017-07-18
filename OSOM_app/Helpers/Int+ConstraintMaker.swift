//
//  Int+ConstraintMaker.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 18/07/2017.
//
//

import Foundation
import UIKit

extension Int {
    
    func asConstraint(designHeight: CGFloat = 667) -> CGFloat {
        let baseHeight: CGFloat = UIScreen.main.bounds.height
        return CGFloat(self) * baseHeight / designHeight
    }
    
}
