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
    
    
    func getEducation() -> UINavigationController {
        let controller = ViewControllerContainer.shared.getEducation()
        let navigationController = UINavigationController(rootViewController: controller)
        let icon = UITabBarItem(title: nil,
                                image: getInactiveImage("education"),
                                selectedImage: getActiveImage("education"))
        navigationController.tabBarItem = icon
        icon.imageInsets = UIEdgeInsetsMake(13.5, 0.0, -13.5, 0.0)
        
        return navigationController
    }
    
    func getWork() -> UINavigationController {
        let controller = ViewControllerContainer.shared.getEducation()
        let navigationController = UINavigationController(rootViewController: controller)
        let icon = UITabBarItem(title: nil,
                                image: getInactiveImage("work"),
                                selectedImage: getActiveImage("work"))
        navigationController.tabBarItem = icon
        icon.imageInsets = UIEdgeInsetsMake(13.5, 0.0, -13.5, 0.0)
        
        return navigationController
    }
    
    func getSkills() -> UINavigationController {
        let controller = ViewControllerContainer.shared.getEducation()
        let navigationController = UINavigationController(rootViewController: controller)
        let icon = UITabBarItem(title: nil,
                                image: getInactiveImage("skills"),
                                selectedImage: getActiveImage("skills"))
        navigationController.tabBarItem = icon
        icon.imageInsets = UIEdgeInsetsMake(13.5, 0.0, -13.5, 0.0)
        
        return navigationController
    }
    
    func getContact() -> UINavigationController {
        let controller = ViewControllerContainer.shared.getEducation()
        let navigationController = UINavigationController(rootViewController: controller)
        let icon = UITabBarItem(title: nil,
                                image: getInactiveImage("contact"),
                                selectedImage: getActiveImage("contact"))
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

