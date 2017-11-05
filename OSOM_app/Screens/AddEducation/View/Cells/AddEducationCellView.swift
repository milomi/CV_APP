//
//  AddEducationCellView.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 05.11.2017.
//

import Foundation
import UIKit

fileprivate struct Constants {
    struct AddButton {
        static let image = "plusSmall"
        struct Constraints {
            static let leading = 35
            static let size = 57
        }
    }
    
    struct Label {
        struct Constraints {
            static let leading = 20
            static let trailing = -30
            static let top = 2
        }
    }

}

class AddEducationCellView: UIView {
    
    let addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Constants.AddButton.image), for: .normal)
        button.backgroundColor = .white
        button.imageView?.contentMode = .scaleAspectFill
        button.contentMode = .scaleAspectFill
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2.0
        return button
    }()
    
    let label: BaseEditField = {
        let label = BaseEditField()
        label.textField.textColor = UIColor.white
        label.textField.isUserInteractionEnabled = false
        return label
    }()
    
    func setupView() {
        setupSelf()
        setupButton()
        setupLabel()
    }
    
    private func setupSelf() {
        backgroundColor = UIColor.clear
        snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalTo(0)
            make.height.equalTo(92)
        }
    }

    private func setupButton() {
        addSubview(addButton)
        
        addButton.snp.makeConstraints { (make) in
            make.leading.equalTo(Constants.AddButton.Constraints.leading)
            make.centerY.equalToSuperview()
            make.size.equalTo(Constants.AddButton.Constraints.size)
        }
    }
    
    private func setupLabel() {
        addSubview(label)
        
        label.setupView()
        
        label.snp.makeConstraints { (make) in
            make.leading.equalTo(addButton.snp.trailing).offset(Constants.Label.Constraints.leading)
            make.trailing.equalTo(0).offset(Constants.Label.Constraints.trailing)
            make.top.equalTo(addButton.snp.top).offset(Constants.Label.Constraints.top)
        }
        
        label.textField.snp.updateConstraints { (make) in
            make.top.equalTo(label.separator.snp.bottom).offset(9)
        }
    }
    
}
