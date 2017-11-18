//
//  AddContactsCellManager.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 18.11.2017.
//

import Foundation
import UIKit

fileprivate struct LocalizedStrings {
    static let phoneTitle = "contacts.phone.title"
    static let mailTitle = "contacts.mail.title"
    static let cityTitle = "contacts.city.title"
    static let portfolioTitle = "contacts.portfolio.title"
    static let linkedinTitle = "contacts.linkedin.title"
    static let facebookTitle = "contacts.facebook.title"
    static let phonePlaceholder = "contacts.phone.placeholder"
    static let mailPlaceholder = "contacts.mail.placeholder"
    static let cityPlaceholder = "contacts.city.placeholder"
    static let portfolioPlaceholder = "contacts.portfolio.placeholder"
    static let linkedinPlaceholder = "contacts.linkedin.placeholder"
    static let facebookPlaceholder = "contacts.facebook.placeholder"

}

enum AddContactsDetailCellType: Int {
    case phone = 0
    case mail
    case city
    case portfolio
    case linkedin
    case facebook
    case CellCount
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
        case AddContactsDetailCellType.phone.rawValue:
            return createCell(header: LocalizedStrings.phoneTitle, placeholder: LocalizedStrings.phonePlaceholder)
        case AddContactsDetailCellType.mail.rawValue:
            return createCell(header: LocalizedStrings.mailTitle, placeholder: LocalizedStrings.mailPlaceholder)
        case AddContactsDetailCellType.city.rawValue:
            return createCell(header: LocalizedStrings.cityTitle, placeholder: LocalizedStrings.cityPlaceholder)
        case AddContactsDetailCellType.portfolio.rawValue:
            return createCell(header: LocalizedStrings.portfolioTitle, placeholder: LocalizedStrings.portfolioPlaceholder)
        case AddContactsDetailCellType.linkedin.rawValue:
            return createCell(header: LocalizedStrings.linkedinTitle, placeholder: LocalizedStrings.linkedinPlaceholder)
        case AddContactsDetailCellType.facebook.rawValue:
            return createCell(header: LocalizedStrings.facebookTitle, placeholder: LocalizedStrings.facebookPlaceholder)
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

