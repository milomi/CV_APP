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
    
    struct HeaderLabel {
        static let text = "Hi Mia!"
        static let font = UIFont.getFontWithSizeAndType(35, type: .bold)
        static let color = UIColor.white
    }
    
    struct AllSetLabel {
        static let text = "You are all set.\nStart sharing your\nrocking CV!"
        static let font = UIFont.getFontWithSizeAndType(20, type: .bold)
        static let color = UIColor.buttonGray
    }
}

final class HelloView: BaseView {
    
    private let headerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.headerImage.image)
        return imageView
    }()
    
    private let headerText: UILabel = {
        let label = UILabel()
        label.font = Constants.HeaderLabel.font
        label.textColor = Constants.HeaderLabel.color
        label.text = Constants.HeaderLabel.text
        return label
    }()
    
    private let allSetLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = Constants.AllSetLabel.font
        label.textColor = Constants.AllSetLabel.color
        label.text = Constants.AllSetLabel.text
        label.contentMode = .center
        return label
    }()
    
    override func setupView() {
        super.setupView()
        setupHeaderImage()
        setupAllSetLabel()
        setupHeaderLabel()
    }
    
    
    private func setupHeaderImage() {
        contentFrame.addSubview(headerImage)
        
        headerImage.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    private func setupAllSetLabel() {
        contentFrame.addSubview(allSetLabel)
        
        allSetLabel.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    private func setupHeaderLabel() {
        contentFrame.addSubview(headerText)
        
        headerText.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(allSetLabel.snp.top).offset(-25)
        }
    }
    
}
