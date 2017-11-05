//
//  UITableView+Register.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 05.11.2017.
//

import Foundation
import UIKit

extension UITableView {
    
    func registerCell<T: UITableViewCell>(_ ofType: T.Type) {
        self.register(T.self, forCellReuseIdentifier: String(describing: T.self))
    }
    
    func getCell<T: UITableViewCell>(_ ofType: T.Type) -> T? {
        if let cell = dequeueReusableCell(withIdentifier: String(describing: T.self)) as? T {
            return cell
        } else {
            fatalError("Could not dequeue cell for type " + String(describing: T.self))
        }
    }
    
}
