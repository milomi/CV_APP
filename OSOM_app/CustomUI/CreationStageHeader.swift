//
//  CreationStageHeader.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 04.11.2017.
//

import Foundation
import UIKit

fileprivate struct Constants {
    struct Element {
        static let active = "circleActive"
        static let inactive = "circleInactive"
    }
}

class CreationStageHeader: UIView {
    
    let contentContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    func setupView(activeElement: Int) {
        setupContentContainer()
        setupStageElements(activeElement: activeElement)
    }
    
    private func setupContentContainer() {
        addSubview(contentContainer)
        
        contentContainer.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    private func setupStageElements(activeElement: Int) {
        for i in 1...6 {
            let element = createElement(active: activeElement == i)
            contentContainer.addArrangedSubview(element)
        }
    }
    
    private func createElement(active: Bool) -> UIImageView {
        let imageView = UIImageView()
        let imageName = active ? Constants.Element.active : Constants.Element.inactive
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: imageName)
        return imageView
    }
}
