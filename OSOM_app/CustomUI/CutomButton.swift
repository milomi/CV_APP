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
    static let buttonBackgroundColor = UIColor(red: 0.84, green: 0.84, blue: 0.84, alpha: 1)
    static let buttonBorderColor = UIColor.gray
    static let buttonTextColor = UIColor.black
    
    struct Separator {
        static let separatorName = "divider"
        struct Constraints {
            static let height = 2
            static let padding = 35
        }
    }
}

class CustomButton: UIView {
    
    let button: UIButton = {
        let button = UIButton()
        button.setTitleColor(Constants.buttonTextColor, for: .normal)
        button.setTitle("LOL", for: .normal)
        return button
    }()
    
    let separator: UIView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.separatorGray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupButton()
        setupSeparator()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton() {
        addSubview(button)
        
        button.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalToSuperview()
        }
    }
    
    private func setupSeparator() {
        addSubview(separator)
        
        separator.snp.makeConstraints { (make) in
            make.leading.equalTo(Constants.Separator.Constraints.padding)
            make.trailing.equalTo(-Constants.Separator.Constraints.padding)
            make.top.equalTo(button.snp.bottom)
            make.bottom.equalToSuperview()
            make.height.equalTo(Constants.Separator.Constraints.height)
        }
    }
    
}
