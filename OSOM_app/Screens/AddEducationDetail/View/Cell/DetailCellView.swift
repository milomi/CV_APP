//
//  DetailCellView.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 17.11.2017.
//

import Foundation
import UIKit

fileprivate struct Constants {
    
    struct Label {
        struct Constraints {
            static let leading = 35
            static let trailing = -30
            static let top = 2
        }
    }
    
}

class DetailCellView: UIView {
    
    let label: BaseEditField = {
        let label = BaseEditField()
        return label
    }()
    
    func setupView() {
        setupSelf()
        setupLabel()
    }
    
    private func setupSelf() {
        backgroundColor = UIColor.clear
        snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalTo(0)
            make.height.equalTo(92)
        }
    }

    private func setupLabel() {
        addSubview(label)
        
        label.setupView()
        
        label.snp.makeConstraints { (make) in
            make.leading.equalTo(Constants.Label.Constraints.leading)
            make.trailing.equalTo(0).offset(Constants.Label.Constraints.trailing)
            make.centerY.equalToSuperview()
        }
        
        label.textField.snp.updateConstraints { (make) in
            make.top.equalTo(label.separator.snp.bottom).offset(9)
        }
    }
    
}
