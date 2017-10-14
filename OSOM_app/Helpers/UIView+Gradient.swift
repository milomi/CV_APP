//
//  UIView+Gradient.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 19/07/2017.
//
//

import Foundation

import Foundation
import UIKit

extension UIView {
    
    func addGradient(topColor: UIColor, gradientPosition: CGFloat = 0.5) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = UIScreen.main.bounds
        gradient.startPoint = CGPoint(x: 0.5, y: gradientPosition)
        gradient.endPoint = CGPoint(x: 0.5, y: 0)
        gradient.colors = [UIColor.white.cgColor, topColor.cgColor]
        layer.insertSublayer(gradient, at: 0)
    }
    
    func updateGradient(topColor: UIColor) {
        layer.sublayers?.forEach({ (layer) in
            if let layer = layer as? CAGradientLayer {
                layer.colors = [UIColor.white.cgColor, topColor.cgColor]
            }
        })
    }
    
}
