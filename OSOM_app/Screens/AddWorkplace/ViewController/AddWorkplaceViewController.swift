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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.async {
            self.animateCells(self.mainView.tableView)
        }
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
        mainView.navigation.title.text = "workplace.nav.title".localized()
        navigator?.delegate = self
    }
    
    func rightAction() {
    }
    
    func backAction() {
        animateCellsFadeOut(tableView: mainView.tableView) {
            self.navigationController?.popViewController(animated: false)
        }
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
        animateCellsFadeOut(tableView: mainView.tableView) {
            let vc = ViewControllerContainer.shared.getAddWorkplaceDetail()
            self.navigationController?.pushViewController(vc, animated: false)
            print(sender.tag)
        }
    }
}
