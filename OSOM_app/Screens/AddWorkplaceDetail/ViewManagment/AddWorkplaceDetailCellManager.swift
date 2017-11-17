//
//  AddWorkplaceDetailCellManager.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 17.11.2017.
//

import Foundation
import UIKit

fileprivate struct LocalizedStrings {
    static let nameTitle = "addDetailEdu.name.title"
    static let startDate = "addDetailEdu.startDate.title"
    static let endDate = "addDetailEdu.endDate.title"
    static let courseTitle = "addDetailEdu.courseTitle.title"
    static let detailedInfoTitle = "addDetailEdu.detailedInfo.title"
    static let namePlaceholder = "addDetailEdu.name.placeholder"
    static let startDatePlaceholder = "addDetailEdu.startDate.placeholder"
    static let endDatePlaceholder = "addDetailEdu.endDate.placeholder"
    static let courseTitlePlaceholder = "addDetailEdu.courseTitle.placeholder"
    static let detailedInfoPlaceholder = "addDetailEdu.detailedInfo.placeholder"
}

enum AddWorkplaceDetailCellType: Int {
    case name = 0
    case startDate
    case endDate
    case courseTitle
    case detailedInfo
}



protocol AddWorkplaceDetailCellManagerDelegate: class {
    
}

protocol AddWorkplaceDetailCellManager: class {
    func buildCell(indexPath: IndexPath, viewController: AddWorkplaceDetailViewController) -> UITableViewCell
}

final class AddWorkplaceDetailCellManagerImpl: AddWorkplaceDetailCellManager {
    let tableView: UITableView
    
    init(tableView: UITableView) {
        self.tableView = tableView
        registerCells()
    }
    
    fileprivate func registerCells() {
        tableView.registerCell(AddEducationDetailCell.self)
    }
    
    func buildCell(indexPath: IndexPath, viewController: AddWorkplaceDetailViewController) -> UITableViewCell {
        
        
        switch indexPath.row {
        case AddWorkplaceDetailCellType.name.rawValue:
            return createCell(header: LocalizedStrings.nameTitle, placeholder: LocalizedStrings.namePlaceholder)
        case AddWorkplaceDetailCellType.startDate.rawValue:
            return createCell(header: LocalizedStrings.startDate, placeholder: LocalizedStrings.startDatePlaceholder)
        case AddWorkplaceDetailCellType.endDate.rawValue:
            return createCell(header: LocalizedStrings.endDate, placeholder: LocalizedStrings.endDatePlaceholder)
        case AddWorkplaceDetailCellType.courseTitle.rawValue:
            return createCell(header: LocalizedStrings.courseTitle, placeholder: LocalizedStrings.courseTitlePlaceholder)
        case AddWorkplaceDetailCellType.detailedInfo.rawValue:
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
