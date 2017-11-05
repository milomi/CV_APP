//
//  AddEducationCell.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 05.11.2017.
//

import Foundation
import UIKit

class AddEducationCell: UITableViewCell {
    
    let mainView = AddEducationCellView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        contentView.addSubview(mainView)
        mainView.setupView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
