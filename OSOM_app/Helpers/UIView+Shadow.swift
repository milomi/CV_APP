//
//  UIView+Shadow.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 19/07/2017.
//
//

import Foundation
import UIKit

extension UIView {
    
    func addShadow(opacity: Float = 0.2) {
        layer.shadowRadius = 5
        layer.shadowOpacity = opacity
        layer.shadowOffset = CGSize(width: 1, height: 2)
    }
    
    func addBorderShadow() {
        addBorderShadowWithColor(UIColor.white)
    }
    
    fileprivate func addBorderShadowWithColor(_ color: UIColor?) {
        let containerWithShadow = UIView()
        if color != nil {
            containerWithShadow.backgroundColor = color
        }
        addSubview(containerWithShadow)
        containerWithShadow.layer.shadowColor = UIColor.black.cgColor
        containerWithShadow.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        containerWithShadow.layer.shadowRadius = 2.5
        containerWithShadow.layer.shadowOpacity = 0.3
        containerWithShadow.snp.makeConstraints {
            make in
            make.top.equalTo(snp.top)
            make.bottom.equalTo(snp.bottom)
            make.leading.equalTo(snp.leading)
            make.trailing.equalTo(snp.trailing)
        }
    }
}
