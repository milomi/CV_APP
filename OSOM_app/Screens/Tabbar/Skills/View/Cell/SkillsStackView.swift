//
//  SkillsStackViewElement.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 02.01.2018.
//

import Foundation
import UIKit

fileprivate struct Constants {
    struct Element {
        struct Constraints {
            static let padding = 14.asConstraint()
            static let trailing = -20.asConstraint()
            static let top = 11.asConstraint()
            static let bottom = -5.asConstraint()
        }
    }
}


class SkillsElementsView: UIView {
    
    var elements = [SkillElement]()
    var numberOfElements: Int = 0
    
    func clearAll() {
        elements.forEach({ (element) in
            element.removeFromSuperview()
        })
        
        elements.removeAll()
        numberOfElements = 0
    }
    
    func addSkills(skills: [Skill]) {
        
        numberOfElements = skills.count
        
        for index in 0..<numberOfElements {
            addSkillElementToView(skill: skills[index], index: index)
        }
    }
    
    private func addSkillElementToView(skill: Skill, index: Int) {
        let view = SkillElement()
        view.setupView(header: skill.name, progress: 75)
        setupElementView(view, index: index)
    }
    
    fileprivate func setupElementView(_ view: SkillElement, index: Int) {
        elements.append(view)
        
        if index == 0 {
            setupFirstElementView(newElement: view)
        } else if index != numberOfElements - 1 {
            setupElement(lastElement: elements[index - 1], newElement: view)
        } else {
            setupLastElement(lastElement: elements[index - 1], newElement: view)
        }
    }
    
    fileprivate func setupFirstElementView(newElement: UIView) {
        addSubview(newElement)
        newElement.snp.makeConstraints { make in
            make.top.equalTo(0)
            make.leading.trailing.equalTo(0)
        }
    }
    
    fileprivate func setupElement(lastElement: UIView, newElement: UIView) {
        addSubview(newElement)
        newElement.snp.makeConstraints { make in
            make.top.equalTo(lastElement.snp.bottom)
            make.leading.trailing.equalTo(0)
        }
    }
    
    fileprivate func setupLastElement(lastElement: UIView, newElement: UIView) {
        addSubview(newElement)
        newElement.snp.makeConstraints { make in
            make.leading.trailing.equalTo(0)
            make.bottom.equalTo(0)
            make.top.equalTo(lastElement.snp.top)
        }
    }
}
