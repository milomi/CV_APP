//
//  AddEducationDetailDetailViewController.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 17.11.2017.
//

import Foundation
import UIKit

class AddEducationDetailViewController: UIViewController {
    
    fileprivate let mainView: AddEducationView
    fileprivate let cellManager: AddEducationDetailCellManager
    fileprivate var navigator: NavigationController?
    
    init(view: AddEducationView, cellManager: AddEducationDetailCellManager) {
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

extension AddEducationDetailViewController: NavigationControllerDelegate {
    
    fileprivate func setupNavigation() {
        navigator = NavigationController(navigationView: mainView.navigation, navigationController: navigationController)
        navigator?.delegate = self
    }
    
    func rightAction() {
    }
    
    func backAction() {
        self.navigationController?.popViewController(animated: false)
    }
}

extension AddEducationDetailViewController: UITableViewDataSource {
    
    fileprivate func setupDataSource() {
        mainView.tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AddEducationDetailCellType.detailedInfo.rawValue + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellManager.buildCell(indexPath: indexPath, viewController: self)
    }
    
}

extension AddEducationDetailViewController: UITableViewDelegate {
    
}

