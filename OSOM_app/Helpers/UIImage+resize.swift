//
//  UIImage+resize.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 05.11.2017.
//

import Foundation
import UIKit

extension UIImage {
    
    func resize(_ targetSize: CGSize) -> UIImage {
        let size = self.size
        if size.width <= targetSize.width && size.height <= targetSize.height {
            return self
        }
        
        let widthRatio  = targetSize.width  / self.size.width
        let heightRatio = targetSize.height / self.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if widthRatio > heightRatio {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let setNewImage = newImage else {
            return UIImage()
        }
        
        let jpgData = UIImageJPEGRepresentation(setNewImage, 0.6)
        
        guard let setJpgData = jpgData else {
            return setNewImage
        }
        
        let jpgImage = UIImage(data: setJpgData)
        
        return jpgImage ?? setNewImage
    }
    
}
