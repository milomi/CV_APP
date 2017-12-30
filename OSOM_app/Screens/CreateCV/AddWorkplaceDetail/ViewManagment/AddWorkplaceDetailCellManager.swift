//
//  AddWorkplaceDetailCellManager.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 17.11.2017.
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

enum AddWorkplaceDetailCellType: Int {
    case name = 0
    case startDate
    case endDate
    case jobTitle
    case detailedInfo
}

protocol AddWorkplaceDetailCellManagerDelegate: class {
    
}

protocol AddWorkplaceDetailCellManager: class {
    func buildCell(indexPath: IndexPath, work: Work?) -> UITableViewCell
    func getWork() -> Work
    func isValidate() -> Bool
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
    
    func buildCell(indexPath: IndexPath, work: Work?) -> UITableViewCell {
        
        
        switch indexPath.row {
        case AddWorkplaceDetailCellType.name.rawValue:
            return createCell(header: LocalizedStrings.nameTitle, placeholder: LocalizedStrings.namePlaceholder, work?.name)
        case AddWorkplaceDetailCellType.startDate.rawValue:
            return createDatePickerCell(.endDate, LocalizedStrings.startDate, LocalizedStrings.startDatePlaceholder, date: work?.startingTime)
        case AddWorkplaceDetailCellType.endDate.rawValue:
            return createDatePickerCell(.endDate, LocalizedStrings.endDate, LocalizedStrings.endDatePlaceholder, date: work?.endingTime)
        case AddWorkplaceDetailCellType.jobTitle.rawValue:
            return createCell(header: LocalizedStrings.courseTitle, placeholder: LocalizedStrings.courseTitlePlaceholder, work?.jobTitle)
        case AddWorkplaceDetailCellType.detailedInfo.rawValue:
            return createCell(header: LocalizedStrings.detailedInfoTitle, placeholder: LocalizedStrings.detailedInfoPlaceholder, work?.detailedInfo)
        default:
            break
        }
        return UITableViewCell()
    }
    
    func createCell(header: String, placeholder: String, _ text: String?) -> UITableViewCell {
        
        guard let cell = tableView.getCell(AddEducationDetailCell.self) else {
            return UITableViewCell()
        }
        cell.mainView.label.textField.text = text ?? ""
        cell.mainView.label.headerLabel.text = header.localized()
        cell.mainView.label.setAttributedPlaceholder(string: placeholder.localized())
        
        return cell
    }
    
    func createDatePickerCell(_ type: AddWorkplaceDetailCellType, _ header: String, _ placeholder: String, date: Date?) -> UITableViewCell {
        
        guard let cell = tableView.getCell(AddEducationDetailCell.self) else {
            return UITableViewCell()
        }
        cell.setupDatePicker()
        if let date = date {
            cell.mainView.label.textField.text = DateFormatterHelper.getFormatedDateString(date)
        }
        cell.mainView.label.headerLabel.text = header.localized()
        cell.mainView.label.setAttributedPlaceholder(string: placeholder.localized())
        
        return cell
    }
    
    
    func isValidate() -> Bool {
        
        var isError = false
        
        for i in 0...AddEducationDetailCellType.cellsCount.rawValue - 1 {
            if let cell = tableView.cellForRow(at: IndexPath(row: i, section: 0)) as? AddEducationDetailCell {
                cell.validate()
                isError = !cell.validator.errors.isEmpty
            }
        }
        return !isError
    }
    
    func getWork() -> Work {
        let work = Work()
        
        for i in 0...AddEducationDetailCellType.cellsCount.rawValue - 1 {
            if let cell = tableView.cellForRow(at: IndexPath(row: i, section: 0)) as? AddEducationDetailCell {
                addWorkData(i, work: work, cell: cell)
            }
        }
        
        return work
    }
    
    private func addWorkData(_ row: Int, work: Work, cell: AddEducationDetailCell) {
        
        switch row {
        case AddWorkplaceDetailCellType.name.rawValue:
            work.name = cell.mainView.label.textField.text ?? ""
        case AddWorkplaceDetailCellType.startDate.rawValue:
            work.startingTime = cell.picker?.date ?? Date()
        case AddWorkplaceDetailCellType.endDate.rawValue:
            work.endingTime = cell.picker?.date ?? Date()
        case AddWorkplaceDetailCellType.jobTitle.rawValue:
            work.jobTitle = cell.mainView.label.textField.text ?? ""
        case AddWorkplaceDetailCellType.detailedInfo.rawValue:
            work.detailedInfo = cell.mainView.label.textField.text ?? ""
        default:
            break
        }
    }
    
}
