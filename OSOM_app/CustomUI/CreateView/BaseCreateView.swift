//
//  BaseCreateView.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 04.11.2017.
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

class BaseCreateView: BaseView {
    
    let navigation: NavigationView = {
        let navigation = NavigationView()
        navigation.title.text = Constants.General.title.localized()
        navigation.rightButton.setTitle(Constants.General.rightButton.localized(), for: .normal)
        return navigation
    }()
    
    let stageHeader: CreationStageHeader = {
        let stageHeader = CreationStageHeader()
        return stageHeader
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
        setupStageHeader()
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
    
    private func setupStageHeader() {
        contentFrame.addSubview(stageHeader)
        
        stageHeader.snp.makeConstraints { (make) in
            make.leading.equalTo(Constants.StageHeader.Constraints.padding)
            make.trailing.equalTo(-Constants.StageHeader.Constraints.padding)
            make.top.equalTo(navigation.snp.bottom)
            make.height.equalTo(60)
        }
    }

    private func setupContentView() {
        contentFrame.addSubview(contentView)
        
        contentView.snp.makeConstraints {
            make in
            make.leading.equalTo(Constants.ContentView.Constraints.padding)
            make.trailing.equalTo(-Constants.ContentView.Constraints.padding)
            make.top.equalTo(stageHeader.snp.bottom)
            make.bottom.equalTo(-Constants.ContentView.Constraints.padding)
        }
    }
    
}
