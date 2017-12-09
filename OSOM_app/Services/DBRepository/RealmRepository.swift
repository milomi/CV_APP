//
//  RealmRepository.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 09.12.2017.
//

import Foundation
import RealmSwift
import SwiftyBeaver

protocol RealmRepository: class {
    associatedtype RealmEntityType
    
    func addObject(object: RealmEntityType)
    func removeObject(with id: String)
}

class RealmRepositoryImpl<T>: RealmRepository where T:Object {
    
    typealias RealmEntityType = T
    
    private let log = SwiftyBeaver.self
    
    var realm: Realm {
        get {
            do {
                let realm = try Realm()
                return realm
            }
            catch {
                assertionFailure("Could not access database: \(error)")
                log.error("Could not access database: \(error)")
            }
            return self.realm
        }
    }
    
    func addObject(object: RealmEntityType) {
        do {
            try realm.write {
                realm.create(RealmEntityType.self, value: object)
            }
        } catch {
            log.error("Could not add or update object")
        }
    }
    
    func getObject(forPrimaryKey id: String) -> RealmEntityType? {
        let object = realm.object(ofType: RealmEntityType.self, forPrimaryKey: id)
        return object
    }
    
    func getObject() -> RealmEntityType? {
        let object = realm.objects(RealmEntityType).first
        return object
    }
    
    func getObjects(withPredicate predicate: String) -> Results<RealmEntityType> {
        let objects = realm.objects(RealmEntityType.self).filter(predicate)
        return objects
    }
    
    func getObjects() -> Results<RealmEntityType> {
        let objects = realm.objects(RealmEntityType.self)
        return objects
    }
    
    func removeObject(with id: String) {
        guard let object = realm.object(ofType: RealmEntityType.self, forPrimaryKey: id) else {
            return
        }
        
        realm.beginWrite()
        realm.delete(object)
        commitWrite()
    }
    
    func remove(list: Results<RealmEntityType>) {
        realm.beginWrite()
        realm.delete(list)
        commitWrite()
    }
    
    func commitWrite() {
        do {
            try realm.commitWrite()
        } catch {
            log.error("Could not add or update object")
        }
    }
}
