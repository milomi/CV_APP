//
//  AddWorksRepository.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 17.12.2017.
//

import Foundation
import RealmSwift
import SwiftyJSON

protocol AddWorkRepositoryDelegate: class {
    func workUpdated()
    func worksDataDownloaded()
    func noInternetConnection()
    func unknownErrorOccured()
}

extension AddWorkRepositoryDelegate {
    func workUpdated() {}
    func worksDataDownloaded() {}
}

protocol AddWorkRepository: class {
    
    weak var delegate: AddWorkRepositoryDelegate? { get set }
    
    func getWorks() -> Results<Work>
    func addWork(work: Work)
    func getWork(with: Int) -> Work?
    func fetchWorks()
    func updateWork(work: Work)
}

class AddWorkRepositoryImpl: AddWorkRepository {
    
    weak var delegate: AddWorkRepositoryDelegate?
    
    private let workDBRepository: WorkDBRepository
    private let networking: AddWorkNetworking
    private let worksNetworking: WorksNetworking
    private let serializer: WorkSerializer
    
    
    init(workDBRepository: WorkDBRepository, networking: AddWorkNetworking, worksNetworking: WorksNetworking, serializer: WorkSerializer) {
        self.workDBRepository = workDBRepository
        self.networking = networking
        self.worksNetworking = worksNetworking
        self.serializer = serializer
        worksNetworking.delegate = self
        networking.delegate = self
    }
    
    func getWorks() -> Results<Work> {
        return workDBRepository.getWorks()
    }
    
    func addWork(work: Work) {
        networking.setAddWorkData(parameters: serializer.serialize(work: work))
    }
    
    func updateWork(work: Work) {
        networking.updateWorkData(parameters: serializer.serialize(work: work))
    }
    
    func getWork(with id: Int) -> Work? {
        return workDBRepository.getWork(with: id)
    }
    
    func fetchWorks() {
        worksNetworking.getWorks()
    }
}

extension AddWorkRepositoryImpl: AddWorkNetworkingDelegate {
    func unknownErrorOccured() {
        delegate?.unknownErrorOccured()
    }
    
    func noInternetConnection() {
        delegate?.noInternetConnection()
    }
    
    func success(_ json: JSON) {
        delegate?.workUpdated()
    }
    
}

extension AddWorkRepositoryImpl: WorksNetworkingDelegate {
    func worksDownloaded(_ json: JSON) {
        guard let works = serializer.unserialize(json: json) else {
            return
        }
        workDBRepository.addWorks(works: works)
    }
    
    
}
