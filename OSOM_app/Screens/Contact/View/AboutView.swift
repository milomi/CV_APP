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
    

    private let header: ProfileHeaderView = {
        let header = ProfileHeaderView()
        header.setupView()
        header.userNameLabel.text = "Milosz Bugla"
        header.profileImage.image = #imageLiteral(resourceName: "mia")
        return header
    }()
    
    private let personalStatementView: PersonalStatmentView = {
        let view = PersonalStatmentView()
        view.setupView()
       
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
        setupHeader()
        setupPersonalStatement()
        
    }
    
    func fillView(user: User) {
        header.userNameLabel.text = "\(user.name) \(user.surname)"
        personalStatementView.descriptionLabel.text = user.personalStatement
    }

    private func setupHeader() {
        contentFrame.addSubview(header)
        
        header.snp.makeConstraints { (make) in
            make.leading.equalTo(5)
            make.trailing.equalTo(-5)
            make.top.equalToSuperview()
        }
    }
    
    private func setupPersonalStatement() {
        
        contentFrame.addSubview(personalStatementView)
        
        personalStatementView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
            make.top.equalTo(header.snp.bottom).offset(5)
            make.bottom.equalToSuperview().offset(-5)
            
        }
    }
    
    
}
