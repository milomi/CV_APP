//
//  AddSkillsCellManager.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 18.11.2017.
//

import Foundation
import UIKit

protocol AddSkillsCellManagerDelegate: class {
    
}

protocol AddSkillsCellManager: class {
    func buildCell(indexPath: IndexPath, viewController: AddSkillsViewController) -> UITableViewCell
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
    
    func buildCell(indexPath: IndexPath, viewController: AddSkillsViewController) -> UITableViewCell {
        
        guard let cell = tableView.getCell(AddEducationCell.self) else {
            return UITableViewCell()
        }
        cell.mainView.label.headerLabel.text = "NAME OF SKILL"
        cell.mainView.label.textField.text = "skill"
        cell.mainView.addButton.tag = indexPath.row
        cell.delegate = viewController
        return cell
        
    }
}
