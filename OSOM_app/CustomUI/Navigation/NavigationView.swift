//
//  NavigationView.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 22.10.2017.
//

import Foundation
import UIKit

fileprivate struct Constants {
    
    struct LeftButton {
        static let backIcon = "iconBack"
        struct Constraints {
            static let leading = 15
            static let height = 40
        }
    }
    
    struct RightButton {
        static let font = UIFont.getFontWithSizeAndType(18, type: .light)
        static let color = UIColor.black
        struct Constriaints {
            static let trailing = -15
        }
    }
    
    struct Title {
        static let font = UIFont.getFontWithSizeAndType(21, type: .bold)
        static let color = UIColor.black
        struct Constriaints {
            static let leading = 15
        }
    }
}

class NavigationView: UIView {
    
    let leftButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(named: Constants.LeftButton.backIcon), for: .normal)
        button.setTitleColor(UIColor.separatorGray, for: .disabled)
        return button
    }()
    
    let rightButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(UIColor.separatorGray, for: .disabled)
        return button
    }()
    
    let title: UILabel = {
        let label = UILabel()
        label.font = Constants.Title.font
        label.textColor = Constants.Title.color
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        setupLeftButton()
        setupRightButton()
        setupTitle()
    }
    
    private func setupLeftButton() {
        addSubview(leftButton)
        
        leftButton.snp.makeConstraints { (make) in
            make.leading.equalTo(Constants.LeftButton.Constraints.leading)
            make.centerY.equalToSuperview()
        }
    }
    
    private func setupRightButton() {
        addSubview(rightButton)
        
        rightButton.snp.makeConstraints { (make) in
            make.trailing.equalTo(Constants.RightButton.Constriaints.trailing)
            make.centerY.equalToSuperview()
        }
    }
    
    private func setupTitle() {
        addSubview(title)
        
        title.snp.makeConstraints { (make) in
            make.leading.equalTo(leftButton.snp.trailing).offset(Constants.Title.Constriaints.leading)
            make.centerY.equalTo(leftButton.snp.centerY)
        }
    }
    
}
