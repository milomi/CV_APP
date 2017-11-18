//
//  AddSkillsCellView.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 18.11.2017.
//

import Foundation
import UIKit

fileprivate extension Selector {
    static let onChangeValue = #selector(AddSkillsCellView.onChange)
}

fileprivate struct Constants {
    
    struct Label {
        struct Constraints {
            static let leading = 35
            static let trailing = -30
            static let top = 30
        }
    }
    
    struct Slider {
        static let thumbImage = "oval"
    }
    
}

class AddSkillsCellView: UIView {
    
    let label: BaseEditField = {
        let label = BaseEditField()
        return label
    }()
    
    let slider: UISlider = {
        let slider = UISlider()
        slider.setThumbImage(UIImage(named: Constants.Slider.thumbImage), for: .normal)
        slider.minimumTrackTintColor = .black
        slider.addTarget(self, action: .onChangeValue, for: .allEvents)
        slider.minimumValue = 0
        slider.maximumValue = 100
        return slider
    }()
    
    var sliderLabel: UILabel?
    
    func setupView() {
        setupSelf()
        setupLabel()
        setupSlider()
    }
    
    private func setupSelf() {
        backgroundColor = UIColor.clear
        snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalTo(0)
            make.height.equalTo(152)
        }
    }
    
    private func setupLabel() {
        addSubview(label)
        
        label.setupView()
        
        label.snp.makeConstraints { (make) in
            make.leading.equalTo(Constants.Label.Constraints.leading)
            make.trailing.equalTo(0).offset(Constants.Label.Constraints.trailing)
            make.top.equalTo(Constants.Label.Constraints.top)
        }
        
        label.textField.snp.updateConstraints { (make) in
            make.top.equalTo(label.separator.snp.bottom).offset(9)
        }
    }
    
    private func setupSlider() {
        addSubview(slider)
        
        slider.snp.makeConstraints { (make) in
            make.leading.equalTo(label.snp.leading)
            make.trailing.equalTo(label.snp.trailing)
            make.top.equalTo(label.snp.bottom).offset(10)
            make.bottom.equalTo(0)
        }
        
        
    }
    
    @objc func onChange() {
        
        guard let sliderLabel = sliderLabel else {
            if let handleView = slider.subviews.last as? UIImageView {
                let label = UILabel(frame: handleView.bounds)
                label.backgroundColor = .clear
                label.textAlignment = .center
                label.textColor = .black
                label.font = UIFont.getFontWithSizeAndType(13, type: .regular)
                
                handleView.addSubview(label)
                self.sliderLabel = label

            }
            return
        }
    
            //set label font, size, color, etc.
            sliderLabel.text = "\(Int(slider.value))"
    }
    
    
    
}


