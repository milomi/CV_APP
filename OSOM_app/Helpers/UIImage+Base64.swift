//
//  UIImage+Base64.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 02.12.2017.
//

import Foundation
import UIKit

extension UIImage {
    
    fileprivate func getData() -> Data? {
        return UIImagePNGRepresentation(self)
    }
    
    func getBase64String() -> String? {
        return getData()?.base64EncodedString()
    }
    
}
