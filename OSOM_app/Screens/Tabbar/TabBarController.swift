//
//  TabBarController.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 27.12.2017.
//

import Foundation
import UIKit

final class TabBarController: UITabBarController {
    
    fileprivate let tabBarBuilder = TabBarBuilder()
    
    fileprivate lazy var defaultTabBarHeight = {
        tabBar.frame.size.height
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.backgroundColor = UIColor.white
        self.tabBar.isTranslucent = false
        self.tabBar.isOpaque = false
        setTabBarItems()
        selectedIndex = 1
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let newTabBarHeight = defaultTabBarHeight + 10.0
        
        var newFrame = tabBar.frame
        newFrame.size.height = newTabBarHeight
        newFrame.origin.y = view.frame.size.height - newTabBarHeight
        
        tabBar.frame = newFrame
    }
    
}

// MARK: Operations with root view controler
extension TabBarController {
    
    fileprivate func setTabBarItems() {
        let  about = tabBarBuilder.getAbout()
        let  education = tabBarBuilder.getAbout()
        let  work = tabBarBuilder.getAbout()
        let  skills = tabBarBuilder.getAbout()
        let  contact = tabBarBuilder.getAbout()
        
        self.viewControllers?.removeAll()
        
        self.viewControllers = [about]
        self.viewControllers?.append(education)
        self.viewControllers?.append(work)
        self.viewControllers?.append(skills)
        self.viewControllers?.append(contact)

        tabBar.barTintColor = UIColor.white
    }
    
}
