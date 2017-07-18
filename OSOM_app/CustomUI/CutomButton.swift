//
//  CutomButton.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 18/07/2017.
//  Copyright © 2017 ITEO Sp. z o.o. All rights reserved.
//

import Foundation
import UIKit

fileprivate struct Constants {
    static let cornerRadius: CGFloat = 5
    static let buttonBackgroundColor = UIColor(colorLiteralRed: 0.84, green: 0.84, blue: 0.84, alpha: 1)
    static let buttonBorderColor = UIColor.gray
    static let buttonTextColor = UIColor.black
}

class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Constants.buttonBackgroundColor
        layer.cornerRadius = Constants.cornerRadius
        layer.borderColor = Constants.buttonBorderColor.cgColor
        layer.borderWidth = 1
        setTitleColor(Constants.buttonTextColor, for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
