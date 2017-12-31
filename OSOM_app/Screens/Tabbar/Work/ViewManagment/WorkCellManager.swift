//
//  WorkCellManager.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 31.12.2017.
//

import Foundation
import UIKit

fileprivate struct Constants {
    struct LocalizedString {
        
    }
}

protocol WorkCellManagerDelegate: class {
    
}

protocol WorkCellManager: class {
    func buildCell(indexPath: IndexPath, _ work: Work?) -> UITableViewCell
    func getHeaderView() -> UIView
}

final class WorkCellManagerImpl: WorkCellManager {
    let tableView: UITableView
    
    init(tableView: UITableView) {
        self.tableView = tableView
        registerCells()
    }
    
    fileprivate func registerCells() {
        tableView.registerCell(CVDataCell.self)
    }
    
    func buildCell(indexPath: IndexPath, _ work: Work? = nil) -> UITableViewCell {
        
        guard let cell = tableView.getCell(CVDataCell.self) else {
            return UITableViewCell()
        }
        
        cell.mainView.headerLabel.text  = work?.name ?? ""
        cell.mainView.dateRangeLabel.text = "Oct. 2010 - Aug. 2012"
        cell.mainView.infoLabel.text = work?.jobTitle ?? ""
        cell.mainView.descriptionLabel.text = work?.description ?? ""
        return cell
        
    }
    
    func getHeaderView() -> UIView {
        
        let headerView = UIView()
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "work")
        
        headerView.addSubview(imageView)
        
        imageView.snp.makeConstraints { (make) in
            make.height.equalTo(163)
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        return headerView
    }
}

