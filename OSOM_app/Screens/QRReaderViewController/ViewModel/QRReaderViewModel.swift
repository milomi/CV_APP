//
//  QRReaderViewModel.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 02.12.2017.
//

import Foundation
import PKHUD

protocol QRReaderViewModelDelegate: class {
    func downloadSuccessed()
    func error()
}

protocol QRReaderViewModel: class {
    
    var delegate: QRReaderViewModelDelegate? { get set }
    
    func openProfile(with url: String?)
}

final class QRReaderViewModelImpl: QRReaderViewModel {
    
    weak var delegate: QRReaderViewModelDelegate?
   
    fileprivate let repository: QRCodeRepository
    
    init(repository: QRCodeRepository) {
        self.repository = repository
        repository.delegate = self
    }
    
    func openProfile(with url: String?) {
        if let url = url {
            HUD.show(.progress)
            repository.getCV(url: url)
        }
    }
    
}

extension QRReaderViewModelImpl: QRCodeRepositoryDelegate {
    func downloadSuccessed() {
        HUD.show(.success)
        delegate?.downloadSuccessed()
    }
    
    func errorOccured(_ error: String?) {
        HUD.show(.error)
        delegate?.error()
    }
    
    func noInternetConnection() {
        HUD.show(.error)
        delegate?.error()
    }
    
    func unknownErrorOccured() {
        HUD.show(.error)
        delegate?.error()
    }
    
    
}
