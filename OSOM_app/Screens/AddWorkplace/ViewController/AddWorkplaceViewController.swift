//
//  AddWorkplace.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 17.11.2017.
//

import Foundation
import UIKit

class AddWorkplaceViewController: UIViewController {
    
    fileprivate let mainView: AddWorkplaceView
    fileprivate let cellManager: AddWorkplaceCellManager
    fileprivate var navigator: NavigationController?
    
    init(view: AddWorkplaceView, cellManager: AddWorkplaceCellManager) {
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
        mainView.setupView()
        setupDataSource()
    }
}

extension AddWorkplaceViewController: NavigationControllerDelegate {
    
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

extension AddWorkplaceViewController: UITableViewDataSource {
    
    fileprivate func setupDataSource() {
        mainView.tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellManager.buildCell(indexPath: indexPath, viewController: self)
    }
    
}

extension AddWorkplaceViewController: UITableViewDelegate {
    
}

extension AddWorkplaceViewController: AddEducationCellDelegate {
    func onButton(_ sender: UIButton) {
        print(sender.tag)
    }
}
