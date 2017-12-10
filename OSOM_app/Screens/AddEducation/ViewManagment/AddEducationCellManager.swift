//
//  AddEducationCellManager.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 05.11.2017.
//

import Foundation
import UIKit

protocol AddEducationCellManagerDelegate: class {
    
}

protocol AddEducationCellManager: class {
    func buildCell(indexPath: IndexPath, viewController: AddEducationViewController, _ school: School?) -> UITableViewCell
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
    
    func buildCell(indexPath: IndexPath, viewController: AddEducationViewController, _ school: School? = nil) -> UITableViewCell {
        
        guard let cell = tableView.getCell(AddEducationCell.self) else {
            return UITableViewCell()
        }
        cell.mainView.label.headerLabel.text = "NAME OF THE SCHOOL"
        cell.mainView.label.textField.text = "school"
        cell.mainView.addButton.tag = indexPath.row
        
        if let school = school {
            cell.mainView.setData(title: school.name)
        }
        cell.delegate = viewController
        return cell
        
    }
}
