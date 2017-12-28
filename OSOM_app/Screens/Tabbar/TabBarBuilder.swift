//
//  TabBarBuilder.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 27.12.2017.
//

import Foundation
import UIKit

final class TabBarBuilder {
    
    func getAbout() -> UINavigationController {
        let controller = ViewControllerContainer.shared.getAbout()
        let navigationController = UINavigationController(rootViewController: controller)
        let icon = UITabBarItem(title: nil,
                                image: getInactiveImage("profile"),
                                selectedImage: getActiveImage("profile"))
        navigationController.tabBarItem = icon
        icon.imageInsets = UIEdgeInsetsMake(13.5, 0.0, -13.5, 0.0)
        
        return navigationController
    }
    
    
    
    fileprivate func getActiveImage(_ iconName: String) -> UIImage? {
        let imageName = iconName + "Active"
        if let image = UIImage(named: imageName) {
            return image.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        }
        return nil
    }
    
    fileprivate func getInactiveImage(_ iconName: String) -> UIImage? {
        let imageName = iconName + "Inactive"
        if let image = UIImage(named: imageName) {
            return image.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        }
        return nil
    }
    
}

