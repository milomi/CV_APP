//
//  AddWorkeDetailViewModel.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 18.12.2017.
//

import Foundation
import PKHUD

protocol AddWorkDetailViewModelDelegate: class {
    func dataSaved()
    func errorOccured()
}

protocol AddWorkDetailViewModel: class {
    weak var delegate: AddWorkDetailViewModelDelegate? { get set }
    
    func saveWork(work: Work)
    func getWork() -> Work?
}

final class AddWorkDetailViewModelImpl: AddWorkDetailViewModel {
    
    weak var delegate: AddWorkDetailViewModelDelegate?
    private let repository: AddWorkRepository
    private var workId: Int = -1 {
        didSet {
            print("why")
        }
    }
    
    init(workId: Int?, repository: AddWorkRepository) {
        self.repository = repository
        self.workId = workId ?? -1
        repository.delegate = self
    }
    
    func saveWork(work: Work) {
        HUD.show(.progress)
        if workId == -1 {
            repository.addWork(work: work)
        } else {
            work.id = workId
            repository.updateWork(work: work)
        }
    }
    
    func getWork() -> Work? {
        guard let work = repository.getWork(with: workId) else {
            return nil
        }
        
        return work
    }
    
}

extension AddWorkDetailViewModelImpl: AddWorkRepositoryDelegate {
    func workUpdated() {
        HUD.flash(.success)
        delegate?.dataSaved()
    }
    
    func noInternetConnection() {
        HUD.flash(.error)
    }
    
    func unknownErrorOccured() {
        HUD.flash(.error)
    }
    
}
