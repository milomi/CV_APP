//
//  BasePresentationView.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 30.12.2017.
//

import Foundation
import UIKit
import SnapKit

fileprivate struct Constants {
    struct General {
        static let backgroundColor = UIColor.black
        static let title = "signUp.about.title"
        static let rightButton = "signUp.about.rightButton"
    }
    
    struct StageHeader {
        struct Constraints {
            static let padding = 25
        }
    }
    struct ContentView {
        static let backgroundColor = UIColor.mainGrey
        struct Constraints {
            static let padding = 4
        }
    }
}

class BasePresentationView: BaseView {
    
    let navigation: NavigationView = {
        let navigation = NavigationView()
        navigation.leftButton.isHidden = true
        navigation.title.text = Constants.General.title.localized()
        navigation.rightButton.setImage(UIImage(named: "menuBlack"), for: .normal)
        return navigation
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
    }
    
    private func setupNavigation() {
        contentFrame.addSubview(navigation)
        
        navigation.snp.makeConstraints { (make) in
            make.leading.top.equalTo(Constants.ContentView.Constraints.padding)
            make.trailing.equalTo(-Constants.ContentView.Constraints.padding)
            make.height.equalTo(70)
        }
    }
    
}
