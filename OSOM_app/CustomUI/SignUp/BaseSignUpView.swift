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

    }
    struct headerImage {
        static let image = ""
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
    
    private let headerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = Constants.headerImage.backgroundColor
        return imageView
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.ContentView.backgroundColor
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
        setupSelf()
        setupHeaderImage()
        setupContentView()
    }
    
    private func setupSelf() {
        backgroundColor = Constants.General.backgroundColor
    }
    
    private func setupHeaderImage() {
        addSubview(headerImage)
        
        headerImage.snp.makeConstraints {
            make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(Constants.headerImage.Constraints.height)
        }
    }
    
    private func setupContentView() {
        addSubview(contentView)
        
        contentView.snp.makeConstraints {
            make in
            make.leading.equalTo(Constants.ContentView.Constraints.padding)
            make.trailing.equalTo(-Constants.ContentView.Constraints.padding)
            make.top.equalTo(headerImage.snp.bottom)
            make.bottom.equalTo(-Constants.ContentView.Constraints.padding)
        }
    }
}
