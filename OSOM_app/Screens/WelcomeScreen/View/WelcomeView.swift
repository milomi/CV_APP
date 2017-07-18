//
//  WelcomeView.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 18/07/2017.
//  Copyright © 2017 ITEO Sp. z o.o. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

fileprivate struct Constants {
    struct Constraints {
        static let top = 60
        static let height = 40
    }
    struct Font {
        static let size: CGFloat = 50
    }
}

class WelcomeView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
