//
//  TitleCell.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 18/07/2017.
//
//

import Foundation
import UIKit

class TitleCell: UITableViewCell {
    
    let mainView = TitleCellView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        contentView.addSubview(mainView)
        mainView.setupView()
    }
    
    fileprivate func setupCell() {
        backgroundColor = UIColor.clear
        selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        mainView.label.text = ""
    }
    
}
