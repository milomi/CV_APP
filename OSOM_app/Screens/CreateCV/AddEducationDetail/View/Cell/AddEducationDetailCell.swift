//
//  AddEducationDetailDetailCell.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 17.11.2017.
//

import Foundation
import UIKit
import SwiftValidator

fileprivate extension Selector {
    static let handleDatePicker = #selector(AddEducationDetailCell.handleDatePicker)
}

class AddEducationDetailCell: UITableViewCell {
    let mainView = DetailCellView()
    
    var picker: UIDatePicker?

    let validator = Validator()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        contentView.addSubview(mainView)
        mainView.setupView()
        mainView.label.setupTextFieldDelegate(delegate: self)
        registerValidatableFields()
    }
    
    func setupDatePicker() {
        picker = UIDatePicker()
        mainView.label.textField.inputView = picker
        picker?.addTarget(self, action: .handleDatePicker, for: UIControlEvents.valueChanged)
        picker?.datePickerMode = .date
    }
    
    @objc func handleDatePicker() {
        guard let picker = picker else {
            return
        }

        mainView.label.textField.text = DateFormatterHelper.getFormatedDateString(picker.date)
        mainView.label.textField.resignFirstResponder()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AddEducationDetailCell: ValidationDelegate {
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


extension AddEducationDetailCell: UITextFieldDelegate {
    
    func validate() {
        validator.validate(self)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        validator.validate(self)
    }
}
