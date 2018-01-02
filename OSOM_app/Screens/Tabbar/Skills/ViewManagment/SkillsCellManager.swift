//
//  SkillsCellManager.swift
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

protocol SkillsCellManagerDelegate: class {
    
}

protocol SkillsCellManager: class {
    func buildCell(indexPath: IndexPath, _ Skills: SkillsSection?) -> UITableViewCell
    func getHeaderView() -> UIView
}

final class SkillsCellManagerImpl: SkillsCellManager {
    let tableView: UITableView
    
    init(tableView: UITableView) {
        self.tableView = tableView
        registerCells()
    }
    
    fileprivate func registerCells() {
        tableView.registerCell(SkillSectionCell.self)
    }
    
    func buildCell(indexPath: IndexPath, _ skillsSection: SkillsSection? = nil) -> UITableViewCell {
        
        guard let cell = tableView.getCell(SkillSectionCell.self) else {
            return UITableViewCell()
        }
        
        cell.mainView.headerLabel.text = skillsSection?.name ?? ""
        
        if let skills = skillsSection?.skills {
            cell.mainView.elementsView.addSkills(skills: Array(skills))
        }
        
        return cell
        
    }
    
    func getHeaderView() -> UIView {
        
        let headerView = UIView()
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "skills")
        
        headerView.addSubview(imageView)
        
        imageView.snp.makeConstraints { (make) in
            make.height.equalTo(163)
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        return headerView
    }
}

