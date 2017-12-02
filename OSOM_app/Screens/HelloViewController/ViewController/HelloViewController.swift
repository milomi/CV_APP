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
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    fileprivate func setupView() {
        self.view = mainView
        mainView.setupView()
    }
    
}
