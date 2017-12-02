//
//  UIViewController+ChengeRoot.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 02.12.2017.
//

import Foundation
import UIKit

extension UIViewController {
    func changeRootVC(newViewController: UIViewController) {
        let appDelegateTemp = UIApplication.shared.delegate as? AppDelegate
        appDelegateTemp?.window?.set(rootViewController: newViewController)
    }
}

extension UIWindow {
    
    func set(rootViewController newRootViewController: UIViewController, withTransition transition: CATransition? = nil) {
        
        if let rootVCSet = self.rootViewController {
            rootVCSet.presentedViewController?.dismiss(animated: false, completion: nil)
            rootVCSet.dismiss(animated: false, completion: nil)
        }
        
        if let controller = newRootViewController as? UITabBarController {
            rootViewController = controller
        } else {
            rootViewController = UINavigationController(rootViewController: newRootViewController)
        }
        
        makeKeyAndVisible()
    }
}
