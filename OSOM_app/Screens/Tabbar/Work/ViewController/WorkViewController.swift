//
//  WorkViewController.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 31.12.2017.
//

import Foundation
import UIKit

fileprivate struct LocalizedStrings {
    static let title = "work.nav.title"
}

class WorkViewController: UIViewController {
    
    fileprivate let mainView: WorkView
    fileprivate let cellManager: WorkCellManager
    fileprivate let viewModel: WorkViewModel
    fileprivate var navigator: NavigationController?
    
    init(view: WorkView, cellManager: WorkCellManager, viewModel: WorkViewModel) {
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

extension WorkViewController: NavigationControllerDelegate {
    
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

extension WorkViewController: UITableViewDataSource, UITableViewDelegate {
    
    fileprivate func setupDataSource() {
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getWorks().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let work = viewModel.getWorks()[safe: indexPath.row] else {
            return UITableViewCell()
        }
        
        return cellManager.buildCell(indexPath: indexPath, work)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return cellManager.getHeaderView()
    }
    
}