//
//  AddContactsDetailViewController.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 18.11.2017.
//

import Foundation
import UIKit

class AddContactsDetailViewController: UIViewController {
    
    fileprivate let mainView: AddContactsView
    fileprivate let cellManager: AddContactsDetailCellManager
    fileprivate var navigator: NavigationController?
    
    init(view: AddContactsView, cellManager: AddContactsDetailCellManager) {
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

extension AddContactsDetailViewController: NavigationControllerDelegate {
    
    fileprivate func setupNavigation() {
        navigator = NavigationController(navigationView: mainView.navigation, navigationController: navigationController)
        mainView.navigation.title.text = "contacts.nav.title".localized()
        navigator?.delegate = self
    }
    
    func rightAction() {
        animateCellsFadeOut(tableView: mainView.tableView) {
            let vc = ViewControllerContainer.shared.getHelloViewController()
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    func backAction() {
        self.navigationController?.popViewController(animated: false)
    }
}

extension AddContactsDetailViewController: UITableViewDataSource {
    
    fileprivate func setupDataSource() {
        mainView.tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AddContactsDetailCellType.detailedInfo.rawValue + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellManager.buildCell(indexPath: indexPath, viewController: self)
    }
    
}

extension AddContactsDetailViewController: UITableViewDelegate {
    
}

