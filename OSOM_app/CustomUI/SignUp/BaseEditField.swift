//
//  BaseEditField.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 15.10.2017.
//

import Foundation
import UIKit

fileprivate struct Constants {
    struct HeaderLabel {
        static let font = UIFont.getFontWithSizeAndType(12, type: .light)
        static let textColor = UIColor.black
    }
    
    struct Separator {
        static let backgroundColor = UIColor.white
        struct Constraints {
            static let height = 1
        }
    }
    
    struct TextField {
        static let font = UIFont.getFontWithSizeAndType(20, type: .bold)
        static let textColor = UIColor.black
        struct Constraints {
            static let top = 21
        }
    }
}

class BaseEditField: UIView {
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.HeaderLabel.textColor
        label.font = Constants.HeaderLabel.font
        return label
    }()
    
    private let separator: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Separator.backgroundColor
        return view
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        return textField
    }()
    
    func setupView() {
        setupHeader()
        setupSeparator()
        setupTextField()
    }
    
    private func setupHeader() {
        addSubview(headerLabel)
        
        headerLabel.snp.makeConstraints { (make) in
            make.leading.top.trailing.equalToSuperview()
        }
    }
    
    private func setupSeparator() {
        addSubview(separator)
        
        separator.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(headerLabel.snp.bottom)
            make.height.equalTo(Constants.Separator.Constraints.height)
        }
    }
    
    private func setupTextField() {
        addSubview(textField)
        
        textField.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(Constants.TextField.Constraints.top)
        }
    }
}
