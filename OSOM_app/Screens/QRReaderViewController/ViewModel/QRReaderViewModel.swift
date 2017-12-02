//
//  QRReaderViewModel.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 02.12.2017.
//

import Foundation

protocol QRReaderViewModel: class {
    func openProfile(with url: String)
}

final class QRReaderViewModelImpl: QRReaderViewModel {
   
    func openProfile(with url: String) {
        print(url)
    }
    
}
