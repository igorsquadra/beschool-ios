//
//  LocalManager.swift
//  beschool
//
//  Created by Igor Squadra on 17/12/24.
//

import Foundation
import RealmSwift

protocol Updatable {
    var lastUpdate: Date { get set }
    var lastSync: Date? { get set }
}

protocol Searchable {
    var name: String { get }
}

@MainActor
class LocalManager {
    private let realm: Realm
    
    init() {
        do {
            let configuration = Realm.Configuration(
                schemaVersion: Utils.currentEnvironment.dbSchemaVersion,
                deleteRealmIfMigrationNeeded: true // Used for development purposes
            )
            self.realm = try Realm(configuration: configuration)
            print("Realm file path: \(realm.configuration.fileURL?.absoluteString ?? "No file URL")")
        } catch {
            fatalError("Failed to initialize Realm: \(error.localizedDescription)")
        }
    }
    
    func save<T: Object>(_ objects: [T]) {
        do {
            try realm.write {
                realm.add(objects, update: .all)
            }
        } catch {
            print("Failed to save \(T.self): \(error.localizedDescription)")
        }
    }
    
    func delete<T: Object & Identifiable>(_ type: T.Type, with id: String) {
        guard let object = realm.object(ofType: type, forPrimaryKey: id) else { return }
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            print("Failed to delete \(T.self): \(error.localizedDescription)")
        }
    }
    
    func fetch<T: Object>(_ type: T.Type, with id: String) -> T? {
        return realm.object(ofType: type, forPrimaryKey: id)
    }
    
    func fetchByName<T: Object & Searchable>(_ type: T.Type, nameQuery: String) -> [T] {
        return Array(realm.objects(type).filter("name CONTAINS[c] %@", nameQuery))
    }
    
    func fetchAll<T: Object>(_ type: T.Type) -> [T] {
        return Array(realm.objects(type))
    }
    
    func fetchPendingUpdates<T: Object & Updatable>(_ type: T.Type) -> [T] {
        let results = realm.objects(type).filter { item in
            if let lastSync = item.lastSync {
                return item.lastUpdate > lastSync
            } else {
                return true
            }
        }
        return Array(results)
    }
    
    func deleteAll<T: Object>(_ type: T.Type) {
        let objects = realm.objects(type)
        do {
            try realm.write {
                realm.delete(objects)
            }
        } catch {
            print("Failed to delete all \(T.self): \(error.localizedDescription)")
        }
    }
    
    func printAllData<T: Object>(_ type: T.Type) {
        let objects = realm.objects(type)
        for object in objects {
            print(object)
        }
    }
}
