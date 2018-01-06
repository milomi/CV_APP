//
//  ContactDataCellView.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 02.01.2018.
//

import Foundation
import UIKit

fileprivate struct Constants {
    
    struct HeaderLabel {
        static let fontSize: CGFloat = 20
        
        struct Constraints {
            static let top = 25
            static let leading = 15
            static let bottom = 25
        }
    }
    
    struct DescriptionLabel {
        static let fontSize: CGFloat = 18
        
        struct Constraints {
            static let leading = 15
            static let bottom = 15
        }
    }
}


class ContactDataCellView: UIView {
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.getFontWithSizeAndType(Constants.HeaderLabel.fontSize, type: .bold)
        label.textColor = .black
        return label
    }()
    
    let separator: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.getFontWithSizeAndType(Constants.DescriptionLabel.fontSize, type: .medium)
        label.textColor = UIColor.darkGray
        label.textAlignment = .left
        return label
    }()
    
    func setupView() {
        setupSelf()
        setupHeaderLabel()
        setupSeparator()
        setupDescriptionLabel()
    }
    
    fileprivate func setupSelf() {
        self.backgroundColor = .white
        
        snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalTo(0)
        }
    }

    private func setupHeaderLabel() {
        addSubview(headerLabel)
        
        headerLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(Constants.HeaderLabel.Constraints.leading)
            make.top.equalTo(Constants.HeaderLabel.Constraints.top)
            make.bottom.equalTo(-Constants.HeaderLabel.Constraints.bottom)
        }
    }
    
    private func setupSeparator() {
        addSubview(separator)
        
        separator.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(headerLabel.snp.bottom).offset(13)
            make.height.equalTo(2)
        }
    }
    
    private func setupDescriptionLabel() {
        addSubview(descriptionLabel)
        
        descriptionLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(headerLabel.snp.trailing).offset(Constants.DescriptionLabel.Constraints.leading)
            make.trailing.equalTo(-10)
            make.centerY.equalTo(headerLabel.snp.centerY)
        }
    }
    
}
