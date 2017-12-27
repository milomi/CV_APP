//
//  AddWorkplaceViewModel.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 18.11.2017.
//

import Foundation
import RealmSwift

protocol AddWorkplaceViewModelDelegate: class {
    func reloadData()
}

protocol AddWorkplaceViewModel: class {
    
    weak var delegate: AddWorkplaceViewModelDelegate? { get set }
    
    func getWorks() -> Results<Work>
    func getWork(for index: Int) -> Work?
    func fetchWorks()
}

class AddWorkplaceViewModelImpl: AddWorkplaceViewModel {
    
    weak var delegate: AddWorkplaceViewModelDelegate?
    
    private let works: Results<Work>
    private let repository: AddWorkRepository
    private var notificationToken: NotificationToken?
    
    
    init(repository: AddWorkRepository) {
        self.repository = repository
        self.works = repository.getWorks()
        setupObserver()
    }
    
    func getWorks() -> Results<Work> {
        return works
    }
    
    func getWork(for index: Int) -> Work? {
        if works.count > index {
            return works[index]
        } else {
            return nil
        }
    }
    
    func addWork(work: Work) {
        repository.addWork(work: work)
    }
    
    func setupObserver() {
        notificationToken = works.observe { (changes: RealmCollectionChange) in
            self.delegate?.reloadData()
        }
    }
    
    func fetchWorks() {
        repository.fetchWorks()
    }
    
}
