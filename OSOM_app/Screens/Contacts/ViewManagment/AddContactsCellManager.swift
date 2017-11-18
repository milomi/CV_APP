//
//  AddContactsCellManager.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 18.11.2017.
//

import Foundation
import UIKit

fileprivate struct LocalizedStrings {
    static let nameTitle = "addWorkDetail.name.title"
    static let startDate = "addWorkDetail.startDate.title"
    static let endDate = "addWorkDetail.endDate.title"
    static let courseTitle = "addWorkDetail.jobTitle.title"
    static let detailedInfoTitle = "addWorkDetail.detailedInfo.title"
    static let namePlaceholder = "addWorkDetail.name.placeholder"
    static let startDatePlaceholder = "addWorkDetail.startDate.placeholder"
    static let endDatePlaceholder = "addWorkDetail.endDate.placeholder"
    static let courseTitlePlaceholder = "addWorkDetail.jobTitle.placeholder"
    static let detailedInfoPlaceholder = "addWorkDetail.detailedInfo.placeholder"
}

enum AddContactsDetailCellType: Int {
    case name = 0
    case startDate
    case endDate
    case courseTitle
    case detailedInfo
}



protocol AddContactsDetailCellManagerDelegate: class {
    
}

protocol AddContactsDetailCellManager: class {
    func buildCell(indexPath: IndexPath, viewController: AddContactsDetailViewController) -> UITableViewCell
}

final class AddContactsDetailCellManagerImpl: AddContactsDetailCellManager {
    let tableView: UITableView
    
    init(tableView: UITableView) {
        self.tableView = tableView
        registerCells()
    }
    
    fileprivate func registerCells() {
        tableView.registerCell(AddEducationDetailCell.self)
    }
    
    func buildCell(indexPath: IndexPath, viewController: AddContactsDetailViewController) -> UITableViewCell {
        
        
        switch indexPath.row {
        case AddContactsDetailCellType.name.rawValue:
            return createCell(header: LocalizedStrings.nameTitle, placeholder: LocalizedStrings.namePlaceholder)
        case AddContactsDetailCellType.startDate.rawValue:
            return createCell(header: LocalizedStrings.startDate, placeholder: LocalizedStrings.startDatePlaceholder)
        case AddContactsDetailCellType.endDate.rawValue:
            return createCell(header: LocalizedStrings.endDate, placeholder: LocalizedStrings.endDatePlaceholder)
        case AddContactsDetailCellType.courseTitle.rawValue:
            return createCell(header: LocalizedStrings.courseTitle, placeholder: LocalizedStrings.courseTitlePlaceholder)
        case AddContactsDetailCellType.detailedInfo.rawValue:
            return createCell(header: LocalizedStrings.detailedInfoTitle, placeholder: LocalizedStrings.detailedInfoPlaceholder)
        default:
            break
        }
        return UITableViewCell()
    }
    
    func createCell(header: String, placeholder: String) -> UITableViewCell {
        
        guard let cell = tableView.getCell(AddEducationDetailCell.self) else {
            return UITableViewCell()
        }
        
        cell.mainView.label.headerLabel.text = header.localized()
        cell.mainView.label.setAttributedPlaceholder(string: placeholder.localized())
        
        return cell
    }
}

