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
    
    fileprivate struct LocalizableKeys {
        static let signUp = "mainView.signUp"
        static let logIn = "mainView.logIn"
        static let fb = "mainView.facebook"
    }
    
    struct headerImage {
        static let image = "cvLogo"
        
        struct Constraints {
            static let height = 336
            static let height4 = 266
        }
    }
    
    struct ContentView {
        static let backgroundColor = UIColor.white
        struct Constraints {
            static let padding = 4
        }
    }
    
    struct SigninButton {
        struct Constraints {
            static let top = 35
            static let height = 55
            static let leading = 20
            static let trailing = -20
        }
    }
    struct SignUpButton {
        struct Constraints {
            static let top = 35
            static let height = 55
            static let leading = 20
            static let trailing = -20
            static let bottom = -20
        }
    }
}

class WelcomeView: BaseView {
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor.white
        return scrollView
    }()
    
    private let headerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.headerImage.image)
        return imageView
    }()
    
    let contentView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        return stack
    }()
    
    let logIn: CustomButton = {
        let logIn = CustomButton()
        logIn.button.setTitle(Constants.LocalizableKeys.logIn.localized(), for: .normal)
        return logIn
    }()
    
    let signUp: CustomButton = {
        let signUp = CustomButton()
        signUp.button.setTitle(Constants.LocalizableKeys.signUp.localized(), for: .normal)
        return signUp
    }()
    
    let facebookButton: CustomButton = {
        let facebookButton = CustomButton()
        facebookButton.button.setTitle(Constants.LocalizableKeys.fb.localized(), for: .normal)
        facebookButton.separator.alpha = 0.0
        return facebookButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupView() {
        super.setupView()
        setupHeaderImage()
        setupContentView()
        setupSignIn()
        setupSignUp()
        setupFbButton()
    }
    
    private func setupHeaderImage() {
        contentFrame.addSubview(headerImage)
        
        headerImage.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalToSuperview()
            if UIDevice.current.isScreen4inch() {
                make.height.equalTo(Constants.headerImage.Constraints.height4)
            } else {
                make.height.equalTo(Constants.headerImage.Constraints.height)
            }
        }
    }
    
    private func setupContentView() {
        contentFrame.addSubview(contentView)
        
        contentView.snp.makeConstraints { (make) in
            make.leading.equalTo(Constants.ContentView.Constraints.padding)
            make.trailing.equalTo(-Constants.ContentView.Constraints.padding)
            make.top.equalTo(headerImage.snp.bottom)
            make.bottom.equalTo(-Constants.ContentView.Constraints.padding)
        }
    }
    
    fileprivate func setupSignIn() {
        contentView.addArrangedSubview(signUp)
    }
    
    fileprivate func setupSignUp() {
        contentView.addArrangedSubview(logIn)
    }
    
    fileprivate func setupFbButton() {
        contentView.addArrangedSubview(facebookButton)
    }
    
}
