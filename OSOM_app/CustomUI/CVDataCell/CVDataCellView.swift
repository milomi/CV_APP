//
//  CVDataCellView.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 30.12.2017.
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


class CVDataCellView: UIView {
    
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
    
    let dateRangeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.getFontWithSizeAndType(Constants.DateRangeLabel.fontSize, type: .bold)
        label.textColor = UIColor.darkGray
        return label
    }()
    
    let separator: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    let infoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.getFontWithSizeAndType(Constants.HeaderLabel.fontSize, type: .bold)
        label.textColor = .black
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.getFontWithSizeAndType(Constants.DateRangeLabel.fontSize, type: .bold)
        label.numberOfLines = 0
        label.textColor = UIColor.darkGray
        return label
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
        setupDateRangeLabel()
        setupSeparator()
        setupInfoLabel()
        setupDescriptionLabel()
    }
    
    fileprivate func setupSelf() {
        self.backgroundColor = .white
        
        snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalTo(0)
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
        }
    }
    
    private func setupHeaderLabel() {
        headerView.addSubview(headerLabel)
        
        headerLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(Constants.HeaderLabel.Constraints.leading)
            make.trailing.equalTo(-Constants.HeaderLabel.Constraints.leading)
            make.top.equalTo(Constants.HeaderLabel.Constraints.top)
        }
    }
    
    private func setupDateRangeLabel() {
        headerView.addSubview(dateRangeLabel)
        
        dateRangeLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(headerLabel.snp.leading)
            make.trailing.equalTo(headerLabel.snp.trailing)
            make.top.equalTo(headerLabel.snp.bottom).offset(Constants.DateRangeLabel.Constraints.top)
            make.bottom.equalTo(-Constants.DateRangeLabel.Constraints.bottom)
        }
    }
    
    private func setupSeparator() {
        addSubview(separator)
        
        separator.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(headerView.snp.bottom)
            make.height.equalTo(2)
        }
    }
    
    private func setupInfoLabel() {
        addSubview(infoLabel)
        
        infoLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(Constants.InfoLabel.Constraints.leading)
            make.trailing.equalTo(-Constants.InfoLabel.Constraints.leading)
            make.top.equalTo(separator.snp.bottom).offset(Constants.InfoLabel.Constraints.top)
        }
    }
    
    private func setupDescriptionLabel() {
        addSubview(descriptionLabel)
        
        descriptionLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(infoLabel.snp.leading)
            make.trailing.equalTo(infoLabel.snp.trailing)
            make.top.equalTo(infoLabel.snp.bottom).offset(Constants.DescriptionLabel.Constraints.top)
            make.bottom.equalTo(-Constants.DescriptionLabel.Constraints.bottom)
        }
    }

}
