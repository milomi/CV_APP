//
//  AddEducationDetailDetailCellManager.swift
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

enum AddEducationDetailCellType: Int {
    case name = 0
    case startDate
    case endDate
    case courseTitle
    case detailedInfo
    case cellsCount
}



protocol AddEducationDetailCellManagerDelegate: class {
}

protocol AddEducationDetailCellManager: class {
    
    weak var delegate: AddEducationDetailCellManagerDelegate? { get set }

    func isValidate() -> Bool
    func buildCell(indexPath: IndexPath, school: School?) -> UITableViewCell
    func getSchool() -> School 
}

final class AddEducationDetailCellManagerImpl: AddEducationDetailCellManager {
    weak var delegate: AddEducationDetailCellManagerDelegate?
    let tableView: UITableView
    
    init(tableView: UITableView) {
        self.tableView = tableView
        registerCells()
    }
    
    fileprivate func registerCells() {
        tableView.registerCell(AddEducationDetailCell.self)
    }
    
    func buildCell(indexPath: IndexPath, school: School?) -> UITableViewCell {

        
        switch indexPath.row {
        case AddEducationDetailCellType.name.rawValue:
            return createCell(.name, LocalizedStrings.nameTitle,LocalizedStrings.namePlaceholder, text: school?.name)
        case AddEducationDetailCellType.startDate.rawValue:
            return createDatePickerCell(.startDate, LocalizedStrings.startDate, LocalizedStrings.startDatePlaceholder, date: school?.startingTime)
        case AddEducationDetailCellType.endDate.rawValue:
            return createDatePickerCell(.endDate, LocalizedStrings.endDate, LocalizedStrings.endDatePlaceholder, date: school?.endingTime)
        case AddEducationDetailCellType.courseTitle.rawValue:
            return createCell(.courseTitle, LocalizedStrings.courseTitle, LocalizedStrings.courseTitlePlaceholder, text: school?.courseTitle)
        case AddEducationDetailCellType.detailedInfo.rawValue:
            return createCell(.detailedInfo, LocalizedStrings.detailedInfoTitle, LocalizedStrings.detailedInfoPlaceholder, text: school?.detailedInfo)
        default:
            break
        }
        return UITableViewCell()
    }
    
    func createDatePickerCell(_ type: AddEducationDetailCellType, _ header: String, _ placeholder: String, date: Date?) -> UITableViewCell {
        
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
    
    func createCell(_ type: AddEducationDetailCellType, _ header: String, _ placeholder: String, text: String?) -> UITableViewCell {
        guard let cell = tableView.getCell(AddEducationDetailCell.self) else {
            return UITableViewCell()
        }
        
        cell.mainView.label.textField.text = text ?? ""
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
    
    func getSchool() -> School {
        let school = School()
        
        for i in 0...AddEducationDetailCellType.cellsCount.rawValue - 1 {
            if let cell = tableView.cellForRow(at: IndexPath(row: i, section: 0)) as? AddEducationDetailCell {
                addSchoolData(i, school: school, cell: cell)
            }
        }
        
        return school
    }
    
    private func addSchoolData(_ row: Int, school: School, cell: AddEducationDetailCell) {
        
        switch row {
        case AddEducationDetailCellType.name.rawValue:
            school.name = cell.mainView.label.textField.text ?? ""
        case AddEducationDetailCellType.startDate.rawValue:
            school.startingTime = cell.picker?.date ?? Date()
        case AddEducationDetailCellType.endDate.rawValue:
            school.endingTime = cell.picker?.date ?? Date()
        case AddEducationDetailCellType.courseTitle.rawValue:
            school.courseTitle = cell.mainView.label.textField.text ?? ""
        case AddEducationDetailCellType.detailedInfo.rawValue:
            school.detailedInfo = cell.mainView.label.textField.text ?? ""
        default:
            break
        }
    }
    
}
