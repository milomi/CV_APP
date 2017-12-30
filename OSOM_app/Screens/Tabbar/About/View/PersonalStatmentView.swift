//
//  PersonalStatmentView.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 28.12.2017.
//

import Foundation
import UIKit

fileprivate struct Constants {
    
    struct General {
        static let backgroundColor = UIColor.mainGrey
        
    }

    struct HeaderLabel {
        static let textColor = UIColor.darkText
        static let font = UIFont.getFontWithSizeAndType(18, type: .bold)
        static let text = "Personal Statement"
        
        struct Constraints {
            static let bottom = 20
            static let top = 20
        }
    }
    
    struct Separator {
        static let color = UIColor.black
        
        struct Constraints {
            static let top = 25
        }
    }
    
    struct DescriptionLabel {
        static let textColor = UIColor.darkGray
        static let font = UIFont.getFontWithSizeAndType(16, type: .light)
        
        struct Constraints {
            static let padding = 15
            static let bottom = 24
            static let top = 16
        }
    }
}

class PersonalStatmentView: UIView {
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.HeaderLabel.textColor
        label.font = Constants.HeaderLabel.font
        label.text = Constants.HeaderLabel.text
        label.textAlignment = .left
        return label
    }()
    
    let separator: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor.white
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.DescriptionLabel.textColor
        label.font = Constants.DescriptionLabel.font
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    
    func setupView() {
        setupSelf()
        setupHeaderLabel()
        setupSeparator()
        setupScrollView()
        setupDescriptionLabel()
    }
    
    private func setupSelf() {
        backgroundColor = UIColor.white
        self.clipsToBounds = true
    }
    
    private func setupHeaderLabel() {
        addSubview(headerLabel)
        
        headerLabel.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview()
            make.leading.equalTo(Constants.DescriptionLabel.Constraints.padding)
            make.top.equalTo(0).offset(Constants.HeaderLabel.Constraints.top)
        }
    }
    
    private func setupSeparator() {
        addSubview(separator)
        
        separator.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(headerLabel.snp.bottom).offset(Constants.Separator.Constraints.top)
            make.height.equalTo(2)
        }
    }
    
    
    private func setupScrollView() {
        addSubview(scrollView)
        
        scrollView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(separator.snp.bottom)
        }
    }
    
    
    private func setupDescriptionLabel() {
        scrollView.addSubview(descriptionLabel)
        
        descriptionLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(Constants.DescriptionLabel.Constraints.padding)
            make.trailing.equalTo(self.snp.trailing).offset(-Constants.DescriptionLabel.Constraints.padding)
            make.top.equalToSuperview().offset(Constants.DescriptionLabel.Constraints.top)
            make.bottom.equalToSuperview().offset(-Constants.DescriptionLabel.Constraints.padding)
        }
    }
    
}
