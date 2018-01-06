//
//  ContactCellManager.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 31.12.2017.
//

import Foundation
import UIKit

enum ContactGeneralCellType: Int {
    case phone = 1
    case mail
    case city
    case linkedin
    case facebook
}

fileprivate struct Constants {
    struct LocalizedString {
        
    }
}

protocol ContactCellManagerDelegate: class {
    
}

protocol ContactCellManager: class {
    func buildCell(indexPath: IndexPath, _ user: User?) -> UITableViewCell
    func getHeaderView() -> UIView
    func getSectionForIndex(_ index: Int) -> UIView?
}

final class ContactCellManagerImpl: ContactCellManager {
    let tableView: UITableView
    
    init(tableView: UITableView) {
        self.tableView = tableView
        registerCells()
    }
    
    fileprivate func registerCells() {
        tableView.registerCell(ContactDataCell.self)
    }
    
    func buildCell(indexPath: IndexPath, _ user: User? = nil) -> UITableViewCell {
        
        guard let cell = tableView.getCell(ContactDataCell.self) else {
            return UITableViewCell()
        }
        
        typealias CellType = ContactGeneralCellType
        
        switch indexPath.row {
        case CellType.phone.rawValue:
            cell.mainView.descriptionLabel.text  = user?.phoneNumber ?? ""
            cell.mainView.headerLabel.text = "Number"
        case CellType.mail.rawValue:
            cell.mainView.descriptionLabel.text  = user?.publicMail ?? ""
            cell.mainView.headerLabel.text = "Mail"
        case CellType.city.rawValue:
            cell.mainView.descriptionLabel.text  = user?.city ?? ""
            cell.mainView.headerLabel.text = "City"
        case CellType.linkedin.rawValue:
            cell.mainView.descriptionLabel.text  = user?.linkedInAccountUrl ?? ""
            cell.mainView.headerLabel.text = "Linkedin"
        case CellType.facebook.rawValue:
            cell.mainView.descriptionLabel.text  = user?.facebookAccountUrl ?? ""
            cell.mainView.headerLabel.text = "Facebook"
        default:
            cell.mainView.descriptionLabel.text  = user?.facebookAccountUrl ?? ""
            cell.mainView.headerLabel.text = "Other"
        }
        
      

        return cell
        
    }
    
    
    
    func getHeaderView() -> UIView {
        
        let headerView = UIView()
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "contact")
        
        headerView.addSubview(imageView)
        
        imageView.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        return headerView
    }
    
    func getSectionForIndex(_ index: Int) -> UIView? {
        let header = HeaderContactCellView()
        header.snp.makeConstraints { (make) in
            make.width.equalTo(tableView.frame.width)
        }
        header.setupView()
        switch index {
        case 0:
            header.headerLabel.text = "General"
            return header
        case 1:
            header.headerLabel.text = "Online"
            return header
        default:
            return nil
        }
    }
}

