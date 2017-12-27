//
//  HelloViewController.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 18.11.2017.
//

import Foundation
import UIKit

final class HelloViewController: UIViewController {
    
    fileprivate let mainView: HelloView
    
    init(mainView: HelloView) {
        self.mainView = mainView
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
    
    override func viewDidAppear(_ animated: Bool) {
        let when = DispatchTime.now() + 2 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            let tabbar = TabBarController()
            self.changeRootVC(newViewController: tabbar)
        }
        
    }
    
    fileprivate func setupView() {
        self.view = mainView
        mainView.setupView()
    }
    
}
