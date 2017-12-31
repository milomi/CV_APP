//
//  EducationCellManager.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 30.12.2017.
//

import Foundation
import UIKit

fileprivate struct Constants {
    struct LocalizedString {
        
    }
}

protocol EducationCellManagerDelegate: class {
    
}

protocol EducationCellManager: class {
    func buildCell(indexPath: IndexPath, _ school: School?) -> UITableViewCell
    func getHeaderView() -> UIView
}

final class EducationCellManagerImpl: EducationCellManager {
    let tableView: UITableView
    
    init(tableView: UITableView) {
        self.tableView = tableView
        registerCells()
    }
    
    fileprivate func registerCells() {
        tableView.registerCell(CVDataCell.self)
    }
    
    func buildCell(indexPath: IndexPath, _ school: School? = nil) -> UITableViewCell {
        
        guard let cell = tableView.getCell(CVDataCell.self) else {
            return UITableViewCell()
        }
        
        cell.mainView.headerLabel.text  = school?.name ?? ""
        cell.mainView.dateRangeLabel.text = "Oct. 2010 - Aug. 2012"
        cell.mainView.infoLabel.text = school?.courseTitle ?? ""
        cell.mainView.descriptionLabel.text = school?.description ?? ""
        return cell
        
    }
    
    func getHeaderView() -> UIView {
        
        let headerView = UIView()
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "education")
        
        headerView.addSubview(imageView)
      
        imageView.snp.makeConstraints { (make) in
            make.height.equalTo(162)
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        return headerView
    }
}

