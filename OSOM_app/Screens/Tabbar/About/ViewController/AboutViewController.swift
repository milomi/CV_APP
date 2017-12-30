//
//  AboutViewController.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 27.12.2017.
//

import Foundation
import UIKit
import SwiftValidator

fileprivate struct Constants {
    struct ActionSheet {
        static let title = "settings.actionSheet.title"
        static let message = "settings.actionSheet.message"
        static let cancel = "settings.actionSheet.cancel"
        static let library = "settings.actionSheet.library"
        static let camera = "settings.actionSheet.camera"
        static let delete = "settings.actionSheet.delete"
    }
    
    struct Alert {
        static let logoutMessage = "settings.alert.logoutMessage"
        static let deleteAccMessage = "settings.alert.deleteAccMessage"
        static let accountDeletedMessage = "settings.alert.accountDeleted"
    }
    
    static let maxImageSize = CGSize(width: 200, height: 320)
    
}

final class AboutViewController: UIViewController {
    
    fileprivate let mainView: AboutView
    fileprivate let viewModel: AboutViewModel
    fileprivate var navigator: NavigationController?
    
    
    init(view: AboutView, viewModel: AboutViewModel) {
        mainView = view
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        navigationController?.isNavigationBarHidden = true
    }

    
    fileprivate func setupView() {
        view = mainView
        mainView.setupView()
        mainView.fillView(user: viewModel.getUser())
        
    }
}



