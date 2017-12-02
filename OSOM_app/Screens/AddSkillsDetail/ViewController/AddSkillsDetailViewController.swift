//
//  AddSkillsDetailViewController.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 18.11.2017.
//

import Foundation
import UIKit

class AddSkillsDetailViewController: UIViewController {
    
    fileprivate let mainView: AddSkillsView
    fileprivate let cellManager: AddSkillsDetailCellManager
    fileprivate var navigator: NavigationController?
    
    init(view: AddSkillsView, cellManager: AddSkillsDetailCellManager) {
        self.mainView = view
        self.cellManager = cellManager
        super.init(nibName: nil, bundle: nil)
        setupView()
        setupNavigation()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        view = mainView
        mainView.tableView.contentInset = UIEdgeInsetsMake(15.0, 0, 0, 0)
        mainView.setupView()
        setupDataSource()
    }
    
}

extension AddSkillsDetailViewController: NavigationControllerDelegate {
    
    fileprivate func setupNavigation() {
        navigator = NavigationController(navigationView: mainView.navigation, navigationController: navigationController)
        mainView.navigation.title.text = "skills.nav.title".localized()
        navigator?.delegate = self
    }
    
    func rightAction() {
    }
    
    func backAction() {
        self.navigationController?.popViewController(animated: false)
    }
}

extension AddSkillsDetailViewController: UITableViewDataSource {
    
    fileprivate func setupDataSource() {
        mainView.tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellManager.buildCell(indexPath: indexPath, viewController: self)
    }
    
}

extension AddSkillsDetailViewController: UITableViewDelegate {
    
}

