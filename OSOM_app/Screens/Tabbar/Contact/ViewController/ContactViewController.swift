//
//  ContactViewController.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 31.12.2017.
//

import Foundation
import UIKit

fileprivate struct LocalizedStrings {
    static let title = "contacts.nav.title"
}

class ContactViewController: UIViewController {
    
    fileprivate let mainView: ContactView
    fileprivate let cellManager: ContactCellManager
    fileprivate let viewModel: ContactViewModel
    fileprivate var navigator: NavigationController?
    
    init(view: ContactView, cellManager: ContactCellManager, viewModel: ContactViewModel) {
        self.mainView = view
        self.cellManager = cellManager
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        view = mainView
        mainView.setupView()
        setupDataSource()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigation()
        navigationController?.isNavigationBarHidden = true
    }
}

extension ContactViewController: NavigationControllerDelegate {
    
    fileprivate func setupNavigation() {
        navigator = NavigationController(navigationView: mainView.navigation, navigationController: navigationController)
        mainView.navigation.title.text = LocalizedStrings.title.localized()
        navigator?.delegate = self
    }
    
    func rightAction() {
        AuthorizationHelperImpl().logOut()
    }
    
    func backAction() {}
}

extension ContactViewController: UITableViewDataSource, UITableViewDelegate {
    
    fileprivate func setupDataSource() {
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = viewModel.getUser()
        return cellManager.buildCell(indexPath: indexPath, user)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return cellManager.getHeaderView()
    }
    
}
