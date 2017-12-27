//
//  AddSkillsViewController.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 18.11.2017.
//

import Foundation
import UIKit

final class AddSkillsViewController: UIViewController {
    
    fileprivate let mainView: AddSkillsView
    fileprivate let viewModel: AddSkillsViewModel
    fileprivate let cellManager: AddSkillsCellManager
    fileprivate var navigator: NavigationController?
    
    init(view: AddSkillsView, cellManager: AddSkillsCellManager, viewModel: AddSkillsViewModel) {
        self.mainView = view
        self.viewModel = viewModel
        self.cellManager = cellManager
        super.init(nibName: nil, bundle: nil)
        setupView()
        setupNavigation()
        viewModel.delegate = self
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainView.tableView.alpha = 0.0
        viewModel.fetchSections()
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

extension AddSkillsViewController: NavigationControllerDelegate {
    
    fileprivate func setupNavigation() {
        navigator = NavigationController(navigationView: mainView.navigation, navigationController: navigationController)
        mainView.navigation.title.text = "skills.nav.title".localized()
        navigator?.delegate = self
    }
    
    func rightAction() {
        animateCellsFadeOut(tableView: mainView.tableView) {
            let vc = ViewControllerContainer.shared.getAddContactsDetail()
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    func backAction() {
        animateCellsFadeOut(tableView: mainView.tableView) {
            self.navigationController?.popViewController(animated: false)
        }
    }
}

extension AddSkillsViewController: UITableViewDataSource {
    
    fileprivate func setupDataSource() {
        mainView.tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getSections().count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellManager.buildCell(indexPath: indexPath, delegate: self, skillsSection: viewModel.getSkillsSection(for: indexPath.row))
    }
    
}

extension AddSkillsViewController: UITableViewDelegate {
    
    
}

extension AddSkillsViewController: AddEducationCellDelegate {
    func onButton(_ sender: UIButton) {
        if cellManager.checkCellAtRow(row: sender.tag) {
            guard let section = viewModel.getSkillsSection(for: sender.tag)  else {
                if let name = cellManager.getSkillNameFor(row: sender.tag) {
                    viewModel.addSection(with: name)
                }
                return
            }
            
            animateToSkillsDetail(sectionId: section.id)
        
        }
    }
    
    func animateToSkillsDetail(sectionId: Int) {
        animateCellsFadeOut(tableView: mainView.tableView) {
            let vc = ViewControllerContainer.shared.getAddSkillsDetail(sectionId)
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    
}

extension AddSkillsViewController: AddSkillsViewModelDelegate {
    
    func reloadData() {
        mainView.tableView.reloadData()
    }
    
    func sectionUpdated(sectionId: Int) {
        animateToSkillsDetail(sectionId: sectionId)
    }
}
