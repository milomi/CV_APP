//
//  AddWorkplaceCellManager.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 17.11.2017.
//

import Foundation
import UIKit

fileprivate struct LocalizedStrings {
    static let header = "PLACE OF WORK"
    static let textField = "workplace"
}

protocol AddWorkplaceCellManagerDelegate: class {
    
}

protocol AddWorkplaceCellManager: class {
    func buildCell(indexPath: IndexPath, viewController: AddWorkplaceViewController, _ work: Work?) -> UITableViewCell
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
    
    func buildCell(indexPath: IndexPath, viewController: AddWorkplaceViewController, _ work: Work? ) -> UITableViewCell {
        
        guard let cell = tableView.getCell(AddEducationCell.self) else {
            return UITableViewCell()
        }
        cell.mainView.label.headerLabel.text = LocalizedStrings.header
        cell.mainView.label.textField.text = LocalizedStrings.textField
        cell.mainView.addButton.tag = indexPath.row
        
        if let work = work {
            cell.mainView.setData(title: work.name)
        }
        
        cell.delegate = viewController
        
        return cell
        
    }
}
