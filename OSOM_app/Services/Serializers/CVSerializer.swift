//
//  CVSerializer.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 30.12.2017.
//

import Foundation
import SwiftyJSON


protocol CVSerializer: class {
    func unserializeCV(json: JSON)
}

class CVSerializerImpl: CVSerializer {
    
    func unserializeCV(json: JSON) {
        
        
    }
}
