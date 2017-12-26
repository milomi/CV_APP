//
//  AddSkillsCellManager.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 18.11.2017.
//

import Foundation
import UIKit


private struct LocalizedStrings {
    static let header = "NAME OF SKILL"
    static let placeholder = "skill"
}
protocol AddSkillsDetailCellManagerDelegate: class {
    
}

protocol AddSkillsDetailCellManager: class {
    func buildCell(indexPath: IndexPath, viewController: AddSkillsDetailViewController, skill: Skill?) -> UITableViewCell
}

final class AddSkillsDetailCellManagerImpl: AddSkillsDetailCellManager {
    let tableView: UITableView
    
    init(tableView: UITableView) {
        self.tableView = tableView
        registerCells()
    }
    
    fileprivate func registerCells() {
        tableView.registerCell(AddSkillsDetailCell.self)
    }
    
    func buildCell(indexPath: IndexPath, viewController: AddSkillsDetailViewController, skill: Skill? = nil) -> UITableViewCell {
        guard let cell = tableView.getCell(AddSkillsDetailCell.self) else {
            return UITableViewCell()
        }
        
        cell.mainView.label.headerLabel.text = LocalizedStrings.header
        cell.mainView.label.setAttributedPlaceholder(string: LocalizedStrings.placeholder)
        cell.mainView.label.textField.text = skill?.name ?? ""
        let value = skill?.id ?? 0
        cell.mainView.slider.setValue(Float(value), animated: true)
        
        
        return cell
    }
    
}

