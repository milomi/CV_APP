//
//  CreateAboutView.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 04.11.2017.
//

import Foundation
import UIKit

fileprivate struct Constants {

    struct PhotoButton {
        static let image = "plus"
        struct Constraints {
            static let leading = 35
            static let size = 116
            static let top = 35
        }
    }
    
    struct PhotoLabel {
        static let header = "signUp.about.photoHeader"
        static let labelAdd =  "signUp.about.photoPlaceholder"
        static let labelAdded = "signUp.about.photoText"
        
        struct Constraints {
            static let leading = 20
            static let trailing = -30
            static let top = 2
        }
    }
    
    struct PersonalStatment {
        
        static let header = "signUp.about.personal"
        static let placeholder =  "signUp.about.personal.placeholder"
        
        struct Constraints {
            static let leading = 20
            static let trailing = -30
            static let top = 30
        }
    }
}

class CreateAboutView: BaseCreateView {
    
    let photoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Constants.PhotoButton.image), for: .normal)
        button.backgroundColor = .white
        button.alpha = 0.0
        button.imageView?.contentMode = .scaleAspectFill
        button.contentMode = .scaleAspectFill
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2.0
        return button
    }()
    
    let photoLabel: BaseEditField = {
        let label = BaseEditField()
        label.headerLabel.text = Constants.PhotoLabel.header.localized()
        label.textField.text = Constants.PhotoLabel.labelAdd.localized()
        label.textField.textColor = UIColor.darkerGrey
        label.textField.isUserInteractionEnabled = false
        return label
    }()
    
    let personalStatement: BaseEditTextView = {
        let field = BaseEditTextView()
        field.headerLabel.text = Constants.PersonalStatment.header.localized()
        field.placeholderLabel.text = Constants.PersonalStatment.placeholder.localized()
        return field
    }()
    
    override func setupView() {
        super.setupView()
        stageHeader.setupView(activeElement: 1)
        setupButton()
        setupPhotoLabel()
        setupPersonalStatment()
    }
    
    func fadeIn() {
        UIView.animate(withDuration: 0.5) {
            self.photoButton.alpha = 1.0
        }
        
        let when = DispatchTime.now() + 0.3 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.photoLabel.fadeIn()
        }
    }
    
    private func setupButton() {
        contentView.addSubview(photoButton)
        
        photoButton.snp.makeConstraints { (make) in
            make.top.equalTo(Constants.PhotoButton.Constraints.top)
            make.leading.equalTo(Constants.PhotoButton.Constraints.leading)
            make.size.equalTo(Constants.PhotoButton.Constraints.size)
        }
    }
    
    private func setupPhotoLabel() {
        contentView.addSubview(photoLabel)
        photoLabel.setupView()
        
        photoLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(photoButton.snp.trailing).offset(Constants.PhotoLabel.Constraints.leading)
            make.trailing.equalTo(contentFrame.snp.trailing).offset(Constants.PhotoLabel.Constraints.trailing)
            make.top.equalTo(photoButton.snp.top).offset(Constants.PhotoLabel.Constraints.top)
        }
    }
    
    private func setupPersonalStatment() {
        contentView.addSubview(personalStatement)
        personalStatement.setupView()
        
        personalStatement.snp.makeConstraints { (make) in
            make.leading.equalTo(photoButton.snp.leading)
            make.trailing.equalTo(contentFrame.snp.trailing).offset(Constants.PhotoLabel.Constraints.trailing)
            make.top.equalTo(photoButton.snp.bottom).offset(Constants.PersonalStatment.Constraints.top)
            make.bottom.lessThanOrEqualTo(contentView.snp.bottom)
        }
    }

}
