//
//  WorkView.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 31.12.2017.
//

import Foundation
import UIKit

fileprivate struct Constants {
    struct ContentView {
        static let backgroundColor = UIColor.mainGrey
        struct Constraints {
            static let padding = 5
        }
    }
    
}

class WorkView: BasePresentationView {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = nil
        tableView.backgroundView = nil
        tableView.estimatedRowHeight = 80
        tableView.showsVerticalScrollIndicator = false
        tableView.sectionHeaderHeight = 163
        return tableView
    }()
    
    override func setupView() {
        super.setupView()
        setupTableView()
    }
    
    fileprivate func setupTableView() {
        contentFrame.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.leading.equalTo(Constants.ContentView.Constraints.padding)
            make.trailing.bottom.equalTo(-Constants.ContentView.Constraints.padding)
            make.top.equalTo(navigation.snp.bottom).offset(Constants.ContentView.Constraints.padding)
        }
    }
    
}
