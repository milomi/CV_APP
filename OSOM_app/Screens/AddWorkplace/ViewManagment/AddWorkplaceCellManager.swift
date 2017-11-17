//
//  AddWorkplaceCellManager.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 17.11.2017.
//

import Foundation
import UIKit

protocol AddWorkplaceCellManagerDelegate: class {
    
}

protocol AddWorkplaceCellManager: class {
    func buildCell(indexPath: IndexPath, viewController: AddWorkplaceViewController) -> UITableViewCell
}

final class AddWorkplaceCellManagerImpl: AddWorkplaceCellManager {
    let tableView: UITableView
    
    init(tableView: UITableView) {
        self.tableView = tableView
        registerCells()
    }
    
    fileprivate func registerCells() {
        tableView.registerCell(AddEducationCell.self)
    }
    
    func buildCell(indexPath: IndexPath, viewController: AddWorkplaceViewController) -> UITableViewCell {
        
        guard let cell = tableView.getCell(AddEducationCell.self) else {
            return UITableViewCell()
        }
        cell.mainView.label.headerLabel.text = "PLACE OF WORK"
        cell.mainView.label.textField.text = "workplace"
        cell.mainView.addButton.tag = indexPath.row
        cell.delegate = viewController
        return cell
        
    }
}
