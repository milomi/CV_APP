//
//  AddEducationCellManager.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 05.11.2017.
//

import Foundation
import UIKit

protocol AddEducationCellManager: class {
    func buildCell(indexPath: IndexPath) -> UITableViewCell
}

final class AddEducationCellManagerImpl: AddEducationCellManager {
    let tableView: UITableView
    
    init(tableView: UITableView) {
        self.tableView = tableView
        registerCells()
    }
    
    fileprivate func registerCells() {
        tableView.registerCell(AddEducationCell.self)
    }
    
    func buildCell(indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.getCell(AddEducationCell.self) else {
            return UITableViewCell()
        }
        cell.mainView.label.headerLabel.text = "NAME OF THE SCHOOL"
        cell.mainView.label.textField.text = "school"
        return cell
        
    }
}
