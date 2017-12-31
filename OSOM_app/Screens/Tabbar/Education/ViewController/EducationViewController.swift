//
//  EducationViewController.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 30.12.2017.
//

import Foundation
import UIKit

fileprivate struct LocalizedStrings {
    static let title = "education.nav.title"
}

class EducationViewController: UIViewController {
    
    fileprivate let mainView: EducationView
    fileprivate let cellManager: EducationCellManager
    fileprivate let viewModel: EducationViewModel
    fileprivate var navigator: NavigationController?
    
    init(view: EducationView, cellManager: EducationCellManager, viewModel: EducationViewModel) {
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

extension EducationViewController: NavigationControllerDelegate {
    
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

extension EducationViewController: UITableViewDataSource, UITableViewDelegate {
    
    fileprivate func setupDataSource() {
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getSchools().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let school = viewModel.getSchools()[safe: indexPath.row] else {
            return UITableViewCell()
        }
        
       return cellManager.buildCell(indexPath: indexPath, school)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return cellManager.getHeaderView()
    }
    
}
