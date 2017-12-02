//
//  AddEducationCell.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 05.11.2017.
//

import Foundation
import UIKit

fileprivate extension Selector {
    static let onButton = #selector(AddEducationCell.onButton)
}

protocol AddEducationCellDelegate: class {
    func onButton(_ sender: UIButton)
}

class AddEducationCell: UITableViewCell {
    weak var delegate: AddEducationCellDelegate?
    let mainView = AddEducationCellView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        contentView.addSubview(mainView)
        mainView.setupView()
        mainView.addButton.addTarget(self, action: .onButton, for: .touchUpInside)
    }
    
    @objc fileprivate func onButton(_ sender: UIButton) {
        delegate?.onButton(sender)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        mainView.clearData()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
