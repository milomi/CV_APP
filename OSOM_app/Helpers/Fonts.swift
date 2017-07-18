//
//  Fonts.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 18/07/2017.
//
//

import UIKit

enum FontType: String {
    case bold = "Montserrat-Bold"
    case extraBold = "Montserrat-ExtraBold"
    case light = "Montserrat-Light"
    case medium = "Montserrat-Medium"
    case regular = "Montserrat-Regular"
}

extension UIFont {
    
    class func getFontWithSizeAndType(_ size: CGFloat, type: FontType) -> UIFont {
        let font = UIFont(name: type.rawValue, size: size)
        assert(font != nil, "Missing font: \(type.rawValue)")
        return font!
    }
    
}
