//
//  BaseSignUpView.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 15.10.2017.
//

import Foundation
import UIKit
import SnapKit

fileprivate struct Constants {
    struct General {
        static let backgroundColor = UIColor.black
        static let title = "signUp.navigation.title"
        static let rightButton = "signUp.navigation.rightButton"

    }
    
    struct headerImage {
        static let image = "signup"
        static let backgroundColor = UIColor.black
        struct Constraints {
            static let height = 122
        }
    }
    
    struct ContentView {
        static let backgroundColor = UIColor.mainGrey
        struct Constraints {
            static let padding = 4
        }
    }
}

class BaseSignUpView: BaseView {
    
    let navigation: NavigationView = {
        let navigation = NavigationView()
        navigation.title.text = Constants.General.title.localized()
        navigation.rightButton.setTitle(Constants.General.rightButton.localized(), for: .normal)
        return navigation
    }()
    
    let headerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.headerImage.image)
        return imageView
    }()
    
    let contentView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = Constants.ContentView.backgroundColor
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupView() {
        super.setupView()
        setupNavigation()
        setupHeaderImage()
        setupContentView()
    }
    
    private func setupNavigation() {
        contentFrame.addSubview(navigation)
        
        navigation.snp.makeConstraints { (make) in
            make.leading.top.equalTo(Constants.ContentView.Constraints.padding)
            make.trailing.equalTo(-Constants.ContentView.Constraints.padding)
            make.height.equalTo(70)
        }
    }
    
    private func setupHeaderImage() {
        contentFrame.addSubview(headerImage)
        
        headerImage.snp.makeConstraints {
            make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(navigation.snp.bottom)
            make.height.equalTo(Constants.headerImage.Constraints.height)
        }
    }
    
    private func setupContentView() {
        contentFrame.addSubview(contentView)
        
        contentView.snp.makeConstraints {
            make in
            make.leading.equalTo(Constants.ContentView.Constraints.padding)
            make.trailing.equalTo(-Constants.ContentView.Constraints.padding)
            make.top.equalTo(headerImage.snp.bottom)
            make.bottom.equalTo(-Constants.ContentView.Constraints.padding)
        }
    }
}
