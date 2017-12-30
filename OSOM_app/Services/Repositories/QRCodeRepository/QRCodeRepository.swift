//
//  QRCodeRepository.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 30.12.2017.
//

import SwiftyJSON
import Foundation

protocol QRCodeRepositoryDelegate: class {
    func downloadSuccessed()
    func errorOccured(_ error: String?)
    func noInternetConnection()
    func unknownErrorOccured()
}

protocol QRCodeRepository: class {
    weak var delegate: QRCodeRepositoryDelegate? { get set }
    
    func getCV(url: String)
}

class QRCodeRepositoryImpl: QRCodeRepository {
    
    weak var delegate: QRCodeRepositoryDelegate?
    
    fileprivate let networking: CVNetworking

    init(networking: CVNetworking) {
        self.networking = networking
        setupDelegates()
    }
    
    func getCV(url: String) {
        networking.getCVData(url: url)
    }
    
    fileprivate func setupDelegates() {
        networking.delegate = self
    }
    
}

extension QRCodeRepositoryImpl: CVNetworkingDelegate {
    func success(_ json: JSON) {
        delegate?.downloadSuccessed()
    }
    
    func errorOccured(_ json: JSON) {
        delegate?.unknownErrorOccured()
    }
    
    func noInternetConnection() {
        delegate?.noInternetConnection()
    }
    
    func unknownErrorOccured() {
        delegate?.unknownErrorOccured()
        
    }
}


