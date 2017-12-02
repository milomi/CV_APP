//
//  BaseEditTextView.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 04.11.2017.
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

class BaseEditTextView: UIView {
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.HeaderLabel.textColor
        label.font = Constants.HeaderLabel.font
        return label
    }()
    
    private let separator: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Separator.backgroundColor
        return view
    }()
    
    let textField: UITextView = {
        let textField = UITextView()
        textField.font = UIFont.getFontWithSizeAndType(20, type: .bold)
        textField.textColor = Constants.TextField.textColor
        textField.backgroundColor = .clear
        textField.isEditable = true
        textField.isScrollEnabled = false 
        textField.isUserInteractionEnabled = true
        return textField
    }()
    
    let placeholderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.getFontWithSizeAndType(20, type: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    func setupView() {
        setupHeader()
        setupSeparator()
        setupTextField()
        setupPlaceholder()
        
        textField.delegate = self
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
            make.trailing.lessThanOrEqualToSuperview()
            make.top.equalTo(separator.snp.bottom).offset(Constants.TextField.Constraints.top)
            make.bottom.equalToSuperview()
        }
    }
    
    private func setupPlaceholder() {
        addSubview(placeholderLabel)
        
        placeholderLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(textField.snp.leading)
            make.trailing.equalTo(textField.snp.trailing)
            make.top.equalTo(textField.snp.top)
        }
    }
    
}

extension BaseEditTextView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        placeholderLabel.alpha = 0.0
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        guard textView.text.isEmpty else {
            placeholderLabel.alpha = 0.0
            return
        }
        placeholderLabel.alpha = 1.0
    }
}
