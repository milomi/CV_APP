//
//  SkillElement.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 02.01.2018.
//

import Foundation
import UIKit
import GTProgressBar

fileprivate struct Constants {
    
    struct HeaderLabel {
        static let font = UIFont.getFontWithSizeAndType(18, type: .medium)
        static let textColor = UIColor.darkGray
        
        struct Constraints {
            static let leading = 15
            static let top = 17
        }
    }
    
    struct ProgressBar {
        
        struct Constraints {
            static let leading = 15
            static let trailing = 15
            static let width = 120
            static let height = 11
        }
    }
}

class SkillElement: UIView {
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.HeaderLabel.textColor
        label.font = Constants.HeaderLabel.font
        return label
    }()
    
    let progressBar: GTProgressBar = {
        let progressBar = GTProgressBar()
        progressBar.barBorderColor = UIColor(red:0.35, green:0.80, blue:0.36, alpha:1.0)
        progressBar.barFillColor = UIColor(red:0.35, green:0.80, blue:0.36, alpha:1.0)
        progressBar.barBackgroundColor = UIColor(red:0.77, green:0.93, blue:0.78, alpha:1.0)
        progressBar.barBorderWidth = 1
        progressBar.barFillInset = 2
        progressBar.displayLabel = false
        progressBar.barMaxHeight = 12
        progressBar.direction = GTProgressBarDirection.clockwise
        return progressBar
    }()
    
    
    func setupView(header: String, progress: Int) {
        setupHeaderLabel(header: header)
        setupProgressBar(progress)
    }
    
    private func setupHeaderLabel(header: String) {
        headerLabel.text = header
        
        addSubview(headerLabel)
        
        headerLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(Constants.HeaderLabel.Constraints.leading)
            make.top.equalTo(Constants.HeaderLabel.Constraints.top)
            make.bottom.equalTo(0).offset(-10)
        }
    }
    
    private func setupProgressBar(_ progress: Int) {
        progressBar.progress = CGFloat(progress)/100
        
        addSubview(progressBar)
        
        progressBar.snp.makeConstraints { (make) in
            make.leading.greaterThanOrEqualTo(headerLabel.snp.trailing)
            make.trailing.equalTo(-Constants.ProgressBar.Constraints.trailing)
            make.width.equalTo(Constants.ProgressBar.Constraints.width)
            make.height.equalTo(11)
            make.centerY.equalTo(headerLabel.snp.centerY)
        }
    }
    
}
