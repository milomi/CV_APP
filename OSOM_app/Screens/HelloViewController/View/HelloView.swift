//
//  HelloView.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 18.11.2017.
//

import Foundation
import UIKit

fileprivate struct Constants {
    struct headerImage {
        static let image = "hiMia"
        
        struct Constraints {
            static let height = 336
            static let height4 = 266
        }
    }
}

final class HelloView: BaseView {
    
    private let headerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.headerImage.image)
        return imageView
    }()
    
    override func setupView() {
        super.setupView()
        setupHeaderImage()
    }
    
    
    private func setupHeaderImage() {
        contentFrame.addSubview(headerImage)
        
        headerImage.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
}
