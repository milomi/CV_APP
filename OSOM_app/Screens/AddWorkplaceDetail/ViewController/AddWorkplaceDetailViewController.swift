//
//  AddWorkplaceDetailViewController.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 17.11.2017.
//

import Foundation
import UIKit

class AddWorkplaceDetailViewController: UIViewController {
    
    fileprivate let mainView: AddWorkplaceView
    fileprivate let cellManager: AddWorkplaceDetailCellManager
    fileprivate let viewModel: AddWorkDetailViewModel
    fileprivate var navigator: NavigationController?
    
    init(view: AddWorkplaceView, viewModel: AddWorkDetailViewModel, cellManager: AddWorkplaceDetailCellManager) {
        self.mainView = view
        self.cellManager = cellManager
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupView()
        setupNavigation()
        viewModel.delegate = self
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

extension AddWorkplaceDetailViewController: NavigationControllerDelegate {
    
    fileprivate func setupNavigation() {
        navigator = NavigationController(navigationView: mainView.navigation, navigationController: navigationController)
        mainView.navigation.title.text = "workplace.nav.title".localized()
        navigator?.delegate = self
    }
    
    func rightAction() {
        if cellManager.isValidate() {
            viewModel.saveWork(work: cellManager.getWork())
        }
    }
    
    func backAction() {
        self.navigationController?.popViewController(animated: false)
    }
}

extension AddWorkplaceDetailViewController: UITableViewDataSource {
    
    fileprivate func setupDataSource() {
        mainView.tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AddWorkplaceDetailCellType.detailedInfo.rawValue + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellManager.buildCell(indexPath: indexPath, work: viewModel.getWork())
    }
    
}

extension AddWorkplaceDetailViewController: AddWorkDetailViewModelDelegate {
    func dataSaved() {
        self.navigationController?.popViewController(animated: false)
    }
    
    func errorOccured() {
        
    }
    
    
}


