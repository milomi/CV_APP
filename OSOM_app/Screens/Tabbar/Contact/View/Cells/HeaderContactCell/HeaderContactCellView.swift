//
//  HeaderContactCellView.swift
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
            static let top = 27
            static let leading = 15
        }
    }
    
    struct DateRangeLabel {
        static let fontSize: CGFloat = 15
        
        struct Constraints {
            static let top = 6
            static let bottom = 15
            
        }
    }
    
    struct InfoLabel {
        static let fontSize: CGFloat = 20
        
        struct Constraints {
            static let top = 27
            static let leading = 15
        }
    }
    
    struct DescriptionLabel {
        static let fontSize: CGFloat = 20
        
        struct Constraints {
            static let top = 13
            static let leading = 15
            static let bottom = 27
        }
    }
}


class HeaderContactCellView: UIView {
    
    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.mainGrey
        return view
    }()
    
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
    
    let topSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    func setupView() {
        setupSelf()
        setupTopSeparator()
        setupHeaderView()
        setupHeaderLabel()
        setupSeparator()

    }
    
    fileprivate func setupSelf() {
        self.backgroundColor = .white
        
        snp.makeConstraints { (make) in
            make.height.equalTo(74)
        }
    }
    
    private func setupTopSeparator() {
        addSubview(topSeparator)
        
        topSeparator.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(2)
        }
    }
    
    private func setupHeaderView() {
        addSubview(headerView)
        
        headerView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(topSeparator.snp.bottom)
            make.height.equalTo(70)
        }
    }
    
    private func setupHeaderLabel() {
        headerView.addSubview(headerLabel)
        
        headerLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(Constants.HeaderLabel.Constraints.leading)
            make.trailing.equalTo(-Constants.HeaderLabel.Constraints.leading)
            make.centerY.equalToSuperview()
        }
    }
    

    private func setupSeparator() {
        addSubview(separator)
        
        separator.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(headerView.snp.bottom)
            make.height.equalTo(2)
            make.bottom.equalToSuperview()
        }
    }

    
}