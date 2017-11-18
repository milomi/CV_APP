//
//  AddSkillsCellManager.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 18.11.2017.
//

import Foundation
import UIKit

protocol AddSkillsDetailCellManagerDelegate: class {
    
}

protocol AddSkillsDetailCellManager: class {
    func buildCell(indexPath: IndexPath, viewController: AddSkillsDetailViewController) -> UITableViewCell
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
    
    func buildCell(indexPath: IndexPath, viewController: AddSkillsDetailViewController) -> UITableViewCell {
        guard let cell = tableView.getCell(AddSkillsDetailCell.self) else {
            return UITableViewCell()
        }
        
        cell.mainView.label.headerLabel.text = "NAME OF SKILL"
        cell.mainView.label.setAttributedPlaceholder(string: "skill")
        
        return cell
    }
    
}

