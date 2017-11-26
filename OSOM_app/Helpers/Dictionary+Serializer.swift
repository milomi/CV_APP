//
//  Dictionary+Serializer.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 26.11.2017.
//

import Foundation
import SwiftyBeaver

extension Dictionary where Key == String, Value == Any {
    
    mutating func serializeItem(_ key: String, value: Any?) {
        if let value = value {
            self[key] = value
        } else {
            let log = SwiftyBeaver.self
            log.debug("Error while serializing for key: " + key)
        }
    }
    
}
