//
//  AddEducationDetailDetailViewController.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 17.11.2017.
//

import Foundation
import UIKit

final class AddEducationDetailViewController: UIViewController {
    
    fileprivate let mainView: AddEducationView
    fileprivate let viewModel: AddEducationDetailViewModel
    fileprivate let cellManager: AddEducationDetailCellManager
    fileprivate var navigator: NavigationController?
    
    init(view: AddEducationView, viewModel: AddEducationDetailViewModel, cellManager: AddEducationDetailCellManager) {
        self.mainView = view
        self.cellManager = cellManager
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupView()
        setupNavigation()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.async {
            self.animateViewFadeIn(view: self.mainView.contentView)
        }
    }
    
    private func setupView() {
        view = mainView
        mainView.tableView.contentInset = UIEdgeInsetsMake(15.0, 0, 0, 0)
        mainView.setupView()
        setupDataSource()
        viewModel.delegate = self
    }
}

extension AddEducationDetailViewController: NavigationControllerDelegate {
    
    fileprivate func setupNavigation() {
        navigator = NavigationController(navigationView: mainView.navigation, navigationController: navigationController)
        mainView.navigation.title.text = "education.nav.title".localized()
        navigator?.delegate = self
    }
    
    func rightAction() {
        if cellManager.isValidate() {
            viewModel.saveSchool(school: cellManager.getSchool())
        }
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
        
        return cellManager.buildCell(indexPath: indexPath, school: viewModel.getSchool())
    }
    
}

extension AddEducationDetailViewController: UITableViewDelegate {
    
}

extension AddEducationDetailViewController: AddEducationDetailViewModelDelegate {
    func dataSaved() {
        self.navigationController?.popViewController(animated: false)
    }
    
    func errorOccured() {}
    
}

