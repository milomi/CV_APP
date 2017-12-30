//
//  PersonalStatmentView.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 28.12.2017.
//

import Foundation
import UIKit

fileprivate struct Constants {
    
    struct General {
        static let backgroundColor = UIColor.mainGrey
        
    }
    
    struct ContentImage {
        static let imageName = "about"
        
        struct Constraints {
            static let padding = 2
            static let height = 166
            
        }
    }
    
    
    struct ProfileImage {
        struct Constraints {
            static let size = 136
        }
    }
    
    struct UserNameLabel {
        static let textColor = UIColor.darkText
        static let font = UIFont.getFontWithSizeAndType(26, type: .bold)
        
        struct Constraints {
            static let bottom = 29
            static let top = 25
        }
    }
}

class PersonalStatmentView: UIView {
    
    let contentImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.ContentImage.imageName)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.addShadow()
        return imageView
    }()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.UserNameLabel.textColor
        label.font = Constants.UserNameLabel.font
        label.textAlignment = .center
        return label
    }()
    
    
    func setupView() {
        setupSelf()
        setupContentImage()
        setupProfileImage()
        setupUserNameLabel()
    }
    
    private func setupSelf() {
        backgroundColor = UIColor.mainGrey
        self.clipsToBounds = true
    }
    
    private func setupContentImage() {
        addSubview(contentImage)
        
        contentImage.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(Constants.ContentImage.Constraints.height)
        }
    }
    
    private func setupProfileImage() {
        addSubview(profileImage)
        
        profileImage.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(65)
            make.height.width.equalTo(Constants.ProfileImage.Constraints.size)
        }
    }
    
    private func setupUserNameLabel() {
        addSubview(userNameLabel)
        
        userNameLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-Constants.UserNameLabel.Constraints.bottom)
            make.top.equalTo(profileImage.snp.bottom).offset(Constants.UserNameLabel.Constraints.top)
        }
    }
    
}
