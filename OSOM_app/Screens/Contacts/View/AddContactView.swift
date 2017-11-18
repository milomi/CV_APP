//
//  AddContactView.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 18.11.2017.
//

import Foundation
import UIKit

fileprivate struct Constants {
    struct ContentView {
        static let backgroundColor = UIColor.mainGrey
        struct Constraints {
            static let padding = 4
        }
    }
    
}

final class AddContactsView: BaseCreateView {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = nil
        tableView.backgroundView = nil
        tableView.estimatedRowHeight = 80
        tableView.showsVerticalScrollIndicator = false
        tableView.sectionHeaderHeight = 10
        return tableView
    }()
    
    let content: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.ContentView.backgroundColor
        return view
    }()
    
    override func setupView() {
        super.setupView()
        contentView.removeFromSuperview()
        setupContentView()
        stageHeader.setupView(activeElement: 5)
        setupTableView()
    }
    
    private func setupContentView() {
        contentFrame.addSubview(content)
        
        content.snp.makeConstraints {
            make in
            make.leading.equalTo(Constants.ContentView.Constraints.padding)
            make.trailing.equalTo(-Constants.ContentView.Constraints.padding)
            make.top.equalTo(stageHeader.snp.bottom)
            make.bottom.equalTo(-Constants.ContentView.Constraints.padding)
        }
    }
    
    fileprivate func setupTableView() {
        content.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalTo(0)
        }
    }
    
}
