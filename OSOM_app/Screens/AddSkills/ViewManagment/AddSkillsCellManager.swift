//
//  AddSkillsCellManager.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 18.11.2017.
//

import Foundation
import UIKit

fileprivate struct LocalizedStrings {
    static let header = "NAME OF SKILL"
    static let labelText = "skill"
}

protocol AddSkillsCellManagerDelegate: class {
    
}

protocol AddSkillsCellManager: class {
    func buildCell(indexPath: IndexPath, delegate: AddEducationCellDelegate,  skillsSection: SkillsSection?) -> UITableViewCell
    func checkCellAtRow(row: Int) -> Bool
    func getSkillNameFor(row: Int) -> String? 
}

final class AddSkillsCellManagerImpl: AddSkillsCellManager {
    let tableView: UITableView
    
    init(tableView: UITableView) {
        self.tableView = tableView
        registerCells()
    }
    
    fileprivate func registerCells() {
        tableView.registerCell(AddEducationCell.self)
    }
    
    func buildCell(indexPath: IndexPath, delegate: AddEducationCellDelegate, skillsSection: SkillsSection?) -> UITableViewCell {
        
        guard let cell = tableView.getCell(AddEducationCell.self) else {
            return UITableViewCell()
        }
        
        cell.mainView.label.headerLabel.text = LocalizedStrings.header
        cell.mainView.label.textField.text = skillsSection?.name ?? ""
        cell.mainView.label.setAttributedPlaceholder(string: LocalizedStrings.labelText)
        cell.mainView.addButton.tag = indexPath.row
        cell.mainView.label.textField.isUserInteractionEnabled = true 
        cell.delegate = delegate
        return cell
    }
    
    func checkCellAtRow(row: Int) -> Bool {
        guard let cell = tableView.cellForRow(at: IndexPath(item: row, section: 0)) as? AddEducationCell else {
            return false
        }
        
        cell.validate()
        
        return cell.validator.errors.isEmpty
    }
    
    
    func getSkillNameFor(row: Int) -> String? {
        guard let cell = tableView.cellForRow(at: IndexPath(item: row, section: 0)) as? AddEducationCell else {
            return nil
        }
        
        
        return cell.mainView.label.textField.text
    }
    

    
 
}
