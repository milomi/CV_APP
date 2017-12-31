//
//  SkillsViewController.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 31.12.2017.
//

import Foundation
import UIKit

fileprivate struct LocalizedStrings {
    static let title = "Skillsplace.nav.title"
}

class SkillsViewController: UIViewController {
    
    fileprivate let mainView: SkillsView
    fileprivate let cellManager: SkillsCellManager
    fileprivate let viewModel: SkillsViewModel
    fileprivate var navigator: NavigationController?
    
    init(view: SkillsView, cellManager: SkillsCellManager, viewModel: SkillsViewModel) {
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

extension SkillsViewController: NavigationControllerDelegate {
    
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

extension SkillsViewController: UITableViewDataSource, UITableViewDelegate {
    
    fileprivate func setupDataSource() {
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getSkillsSections().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let skillsSection = viewModel.getSkillsSections()[safe: indexPath.row] else {
            return UITableViewCell()
        }
        
        return cellManager.buildCell(indexPath: indexPath, skillsSection)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return cellManager.getHeaderView()
    }
    
}
