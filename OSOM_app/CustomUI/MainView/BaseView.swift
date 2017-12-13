//
//  BaseView.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 22.10.2017.
//

import Foundation
import UIKit
import SnapKit

fileprivate struct Constants {
    struct General {
        static let backgroundColor = UIColor.white
        
    }
    
    struct ContentFrame {
        static let backgroundColor = UIColor.black
        struct Constraints {
            static let padding = 20
        }
    }
    
}

class BaseView: UIView {
    
    let contentFrame: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.ContentFrame.backgroundColor
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        setupSelf()
        setupContentFrame()
    }
    
    private func setupSelf() {

        backgroundColor = Constants.General.backgroundColor
    }
    
    private func setupContentFrame() {
        addSubview(contentFrame)
        
        contentFrame.snp.makeConstraints { (make) in
            if #available(iOS 11, *) {
                make.top.equalTo(safeAreaLayoutGuide.snp.topMargin).offset(Constants.ContentFrame.Constraints.padding)
                    make.bottom.equalTo(safeAreaLayoutGuide.snp.bottomMargin).offset(-Constants.ContentFrame.Constraints.padding)
            } else {
                make.top.equalTo(self.snp.topMargin).offset(Constants.ContentFrame.Constraints.padding)
                    make.bottom.equalTo(-Constants.ContentFrame.Constraints.padding)
            }
            make.leading.equalTo(Constants.ContentFrame.Constraints.padding)
            make.trailing.equalTo(-Constants.ContentFrame.Constraints.padding)
        }
    }
    

    

}
