//
//  LocalManager.swift
//  beschool
//
//  Created by Igor Squadra on 17/12/24.
//

import Foundation
import SwiftData

protocol Updatable {
    var lastUpdate: Date { get set }
    var lastSync: Date? { get set }
}

class LocalManager {
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func save<T: PersistentModel & Identifiable>(_ type: T.Type, _ items: [T]) {
        for item in items {
            if fetch(type, with: item.id) == nil {
                modelContext.insert(item)
            }
        }
    }
    
    func delete<T: PersistentModel & Identifiable>(_ type: T.Type, with id: T.ID) {
        if let item = fetch(type, with: id) {
            modelContext.delete(item)
        }
    }
    
    func fetch<T: PersistentModel & Identifiable>(_ type: T.Type, with id: T.ID) -> T? {
        let descriptor = FetchDescriptor<T>(predicate: #Predicate { $0.id == id })
        return try? modelContext.fetch(descriptor).first
    }
    
    func fetchAll<T: PersistentModel>(_ type: T.Type) -> [T] {
        let descriptor = FetchDescriptor<T>()
        return (try? modelContext.fetch(descriptor)) ?? []
    }
    
    func fetchPendingUpdates<T: PersistentModel & Updatable>(_ type: T.Type) -> [T] {
        let descriptor = FetchDescriptor<T>(predicate: #Predicate { $0.lastUpdate > ($0.lastSync ?? Date.distantPast) })
        return (try? modelContext.fetch(descriptor)) ?? []
    }
    
    func deleteAll<T: PersistentModel>(_ type: T.Type) {
        let descriptor = FetchDescriptor<T>()
        if let allItems = try? modelContext.fetch(descriptor) {
            for item in allItems {
                modelContext.delete(item)
            }
        }
    }
}
