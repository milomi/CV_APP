//
//  AddEducationViewController.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 05.11.2017.
//

import Foundation
import UIKit

class AddEducationViewController: UIViewController {
    
    fileprivate let mainView: AddEducationView
    fileprivate let cellManager: AddEducationCellManager
    fileprivate let viewModel: AddEducationViewModel
    fileprivate var navigator: NavigationController?
    
    init(view: AddEducationView, cellManager: AddEducationCellManager, viewModel: AddEducationViewModel) {
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
    
    private func setupView() {
        view = mainView
        mainView.setupView()
        setupDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainView.tableView.alpha = 0.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateCells(mainView.tableView)

    }
}

extension AddEducationViewController: NavigationControllerDelegate {
    
    fileprivate func setupNavigation() {
        navigator = NavigationController(navigationView: mainView.navigation, navigationController: navigationController)
        mainView.navigation.title.text = "education.nav.title".localized()
        navigator?.delegate = self
    }
    
    func rightAction() {
        animateCellsFadeOut(tableView: mainView.tableView) {
            let vc = ViewControllerContainer.shared.getAddWorkplace()
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    func backAction() {
        self.navigationController?.popViewController(animated: false)
    }
}

extension AddEducationViewController: UITableViewDataSource {
    
    fileprivate func setupDataSource() {
        mainView.tableView.dataSource = self 
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getSchools().count + 1 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellManager.buildCell(indexPath: indexPath, viewController: self)
    }
    
}

extension AddEducationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}

extension AddEducationViewController: AddEducationCellDelegate {
    func onButton(_ sender: UIButton) {
        animateCellsFadeOut(tableView: mainView.tableView) {
            let vc = ViewControllerContainer.shared.getAddEducationDetail()
            self.navigationController?.pushViewController(vc, animated: false)
            print(sender.tag)
        }

    }
}
