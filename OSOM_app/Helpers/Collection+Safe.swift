//
//  Collection+Safe.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 31.12.2017.
//

import Foundation

extension Collection {
    
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
}
