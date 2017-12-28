//
//  AboutView.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 27.12.2017.
//

import Foundation
import UIKit
import SnapKit

fileprivate struct Constants {
    
    fileprivate struct LocalizableKeys {
        static let signUp = "mainView.signUp"
        static let logIn = "mainView.logIn"
        static let qrCode = "mainView.qrCode"
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

class AboutView: BaseView {
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor.white
        return scrollView
    }()
    
    private let header: ProfileHeaderView = {
        let header = ProfileHeaderView()
        header.setupView()
        header.userNameLabel.text = "Milosz Bugla"
        header.profileImage.image = #imageLiteral(resourceName: "mia")
        return header
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupView() {
        super.setupView()
        setupHeader()
    }
    
    private func setupHeader() {
        contentFrame.addSubview(header)
        
        header.snp.makeConstraints { (make) in
            make.leading.equalTo(5)
            make.trailing.equalTo(-5)
            make.top.equalToSuperview()
            if UIDevice.current.isScreen4inch() {
                make.height.equalTo(Constants.headerImage.Constraints.height4)
            } else {
                make.height.equalTo(Constants.headerImage.Constraints.height)
            }
        }
    }
    
    
}
