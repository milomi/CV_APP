//
//  BaseEditField.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 15.10.2017.
//

import Foundation
import UIKit

fileprivate struct Constants {
    struct HeaderLabel {
        static let font = UIFont.getFontWithSizeAndType(12, type: .light)
        static let textColor = UIColor.black
    }
    
    struct Separator {
        static let backgroundColor = UIColor.white
        struct Constraints {
            static let top = 5
            static let height = 2
        }
    }
    
    struct TextField {
        static let font = UIFont.getFontWithSizeAndType(20, type: .bold)
        static let textColor = UIColor.black
        struct Constraints {
            static let top = 21
        }
    }
}

enum BaseEditFieldType {
    case name
    case surname
    case email
    case password
    case repeatPassword
    case none
}

fileprivate extension Selector {
    static let textDidEdit = #selector(BaseEditField.textFieldEdited)
    static let textDidEndEditing = #selector(BaseEditField.textFieldDidEndEditing(_:))
    static let securePasswordEye = #selector(BaseEditField.securePasswordEyeChanged)
}

protocol BaseEditFieldDelegate: class {
    func textFieldEdited()
}

class BaseEditField: UIView {
    
    weak var delegate: BaseEditFieldDelegate?
    let type: BaseEditFieldType = .none
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.HeaderLabel.textColor
        label.font = Constants.HeaderLabel.font
        return label
    }()
    
    let separator: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Separator.backgroundColor
        return view
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.getFontWithSizeAndType(20, type: .bold)
        textField.textColor = Constants.TextField.textColor
        return textField
    }()
    
    let errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.text = " "
        label.font = UIFont.getFontWithSizeAndType(12, type: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    func setupView() {
        setupHeader()
        setupSeparator()
        setupTextField()
        setupErrorLabel()
    }
    
    func clearError() {
        errorLabel.text = " "
    }
    
    func fadeIn(completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.5, animations: {
            self.alpha = 1.0
        }, completion: { data in
            if let completion = completion {
                completion()
            }
        })
        
    }
    
    func fadeOut(completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.5, animations: {
            self.alpha = 0.0
        }, completion: { data in
            if let completion = completion {
                completion()
            }
        })
    }
    
    func setAttributedPlaceholder(string: String) {
        let attributedString = NSAttributedString(string: string,
                                                  attributes: [NSAttributedStringKey.foregroundColor: UIColor.white,
                                                               NSAttributedStringKey.font : UIFont.getFontWithSizeAndType(20, type: .bold)])
        self.textField.attributedPlaceholder = attributedString
    }
    
    private func setupHeader() {
        addSubview(headerLabel)
        
        headerLabel.snp.makeConstraints { (make) in
            make.leading.top.trailing.equalToSuperview()
        }
    }
    
    private func setupSeparator() {
        addSubview(separator)
        
        separator.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(headerLabel.snp.bottom).offset(Constants.Separator.Constraints.top)
            make.height.equalTo(Constants.Separator.Constraints.height)
        }
    }
    
    private func setupTextField() {
        addSubview(textField)
        
        textField.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(separator.snp.bottom).offset(Constants.TextField.Constraints.top)
        }
    }
    
    private func setupErrorLabel() {
        addSubview(errorLabel)
        
        errorLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(textField.snp.bottom).offset(5)
            make.bottom.equalToSuperview()
        }
    }
    
}

extension BaseEditField: UITextFieldDelegate {
    
    func setupTextFieldDelegate(delegate: UITextFieldDelegate? = nil) {
        textField.delegate = delegate ?? self
        textField.addTarget(self, action: .textDidEndEditing, for: .editingDidEnd)
        textField.addTarget(self, action: .textDidEdit, for: .editingChanged)
    }
    
    @objc func textFieldDidEndEditing(_ textField: UITextField) {
    }
    
    
    @objc func textFieldEdited() {
        
    }
    
    @objc func securePasswordEyeChanged() {
        
    }
    
}
