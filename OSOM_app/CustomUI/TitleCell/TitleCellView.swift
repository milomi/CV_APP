//
//  TitleCellView.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 18/07/2017.
//
//

import Foundation
import UIKit
import SnapKit

fileprivate struct Constants {
    struct Label {
        struct Constraints {
            static let leading = 26.asConstraint()
            static let trailing = -26.asConstraint()
            static let top = 13.asConstraint()
            static let bottom = -10.asConstraint()
        }
        static let fontSize = 26.asConstraint()
    }
}

class TitleCellView: UIView {
    
    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.getFontWithSizeAndType(Constants.Label.fontSize, type: .bold)
        label.textColor = .white
        return label
    }()
    
    func setupView() {
        setupSelf()
        setupLabel()
    }
    
    fileprivate func setupSelf() {
        snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalTo(0)
        }
    }
    
    fileprivate func setupLabel() {
        addSubview(label)
        label.snp.makeConstraints { (make) in
            make.leading.equalTo(Constants.Label.Constraints.leading)
            make.trailing.equalTo(Constants.Label.Constraints.trailing)
            make.top.equalTo(Constants.Label.Constraints.top)
            make.bottom.equalTo(Constants.Label.Constraints.bottom)
        }
    }
    
}
