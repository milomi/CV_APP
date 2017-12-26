//
//  AddEducationCell.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 05.11.2017.
//

import Foundation
import UIKit
import SwiftValidator

fileprivate extension Selector {
    static let onButton = #selector(AddEducationCell.onButton)
}

protocol AddEducationCellDelegate: class {
    func onButton(_ sender: UIButton)
}

class AddEducationCell: UITableViewCell {
    weak var delegate: AddEducationCellDelegate?
    let mainView = AddEducationCellView()
    
    let validator = Validator()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        contentView.addSubview(mainView)
        mainView.setupView()
        mainView.addButton.addTarget(self, action: .onButton, for: .touchUpInside)
        registerValidatableFields()
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

extension AddEducationCell: ValidationDelegate {
    func validationSuccessful() {
        mainView.label.clearError()
    }
    
    func validationFailed(_ errors: [(Validatable, ValidationError)]) {
        for (field, error) in errors {
            if let field = field as? UITextField {
                error.errorLabel?.text = error.errorMessage
                field.shake()
            }
        }
    }
    
    fileprivate func registerValidatableFields() {
        validator.registerField(mainView.label.textField, errorLabel: mainView.label.errorLabel, rules: [RequiredRule()])
    }
}


extension AddEducationCell: UITextFieldDelegate {
    
    func validate() {
        validator.validate(self)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        validator.validate(self)
    }
}
