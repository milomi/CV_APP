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

import Foundation
import UIKit
import SnapKit

fileprivate struct Constants {
    struct AppName {
        struct Constraints {
            static let top = 60
            static let height = 40
        }
        struct Font {
            static let size: CGFloat = 50
        }
    }
    struct Title {
        struct Constraints {
            static let top = 35
            static let leading = 40
            static let trailing = -40
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

class WelcomeView: UIView {
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor.white
        return scrollView
    }()
    
    fileprivate let contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    let appNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: Constants.AppName.Font.size)
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let signIn: CustomButton = {
        let button = CustomButton()
        return button
    }()
    
    let signUp: CustomButton = {
        let button = CustomButton()
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAppNameText(text: String) {
        appNameLabel.text = text
    }
    
    func setTitleText(text: String) {
        titleLabel.text = text
    }
    
    func setSignInButtonTitle(title: String) {
        signIn.setTitle(title, for: .normal)
    }
    
    func setSignUpButtonTitle(title: String) {
        signUp.setTitle(title, for: .normal)
    }
    
}

extension WelcomeView {
    
    func setupView() {
        setupSelf()
        setupContentView()
        setupAppLabel()
        setupLabel()
        setupSignIn()
        setupSignUp()
    }
    
    func setupSelf() {
        addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.top.bottom.leading.trailing.equalTo(0)
        }
    }
    
    fileprivate func setupContentView() {
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.top.bottom.leading.trailing.equalTo(0)
            make.centerX.equalTo(scrollView.snp.centerX)
        }
    }
    
    fileprivate func setupAppLabel() {
        contentView.addSubview(appNameLabel)
        appNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(Constants.AppName.Constraints.top)
            make.height.equalTo(Constants.AppName.Constraints.height)
            make.leading.trailing.equalTo(0)
        }
    }
    
    fileprivate func setupLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(appNameLabel.snp.bottom).offset(Constants.Title.Constraints.top)
            make.leading.equalTo(Constants.Title.Constraints.leading)
            make.trailing.equalTo(Constants.Title.Constraints.trailing)
        }
    }
    
    fileprivate func setupSignIn() {
        contentView.addSubview(signIn)
        signIn.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.SigninButton.Constraints.top)
            make.leading.equalTo(Constants.SigninButton.Constraints.leading)
            make.trailing.equalTo(Constants.SigninButton.Constraints.trailing)
            make.height.equalTo(Constants.SigninButton.Constraints.height)
        }
    }
    
    fileprivate func setupSignUp() {
        contentView.addSubview(signUp)
        signUp.snp.makeConstraints { (make) in
            make.top.equalTo(signIn.snp.bottom).offset(Constants.SignUpButton.Constraints.top)
            make.leading.equalTo(Constants.SignUpButton.Constraints.leading)
            make.trailing.equalTo(Constants.SignUpButton.Constraints.trailing)
            make.height.equalTo(Constants.SignUpButton.Constraints.height)
            make.bottom.equalTo(Constants.SignUpButton.Constraints.bottom)
        }
    }
    
}
