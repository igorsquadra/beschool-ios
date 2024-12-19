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

protocol Searchable: PersistentModel {
    var name: String { get }
}

@MainActor
class LocalManager {
    private let container: ModelContainer
    private let modelContext: ModelContext
    
    init() {
        do {
            self.container = try ModelContainer(for: ClassroomData.self, StudentData.self, ProfessorData.self)
            self.modelContext = container.mainContext
            print(modelContext.dbPath)
        } catch {
            fatalError("Failed to initialize ModelContainer: \(error.localizedDescription)")
        }
    }
    
    func save<T: PersistentModel & Identifiable>(_ type: T.Type, _ items: [T])  where T.ID: Codable & Equatable {
        for item in items {
            if fetch(type, with: item.id) == nil {
                modelContext.insert(item)
            }
        }
    }
    
    func delete<T: PersistentModel & Identifiable>(_ type: T.Type, with id: T.ID) where T.ID: Codable & Equatable  {
        if let item = fetch(type, with: id) {
            modelContext.delete(item)
        }
    }
    
    func fetch<T: PersistentModel & Identifiable>(_ type: T.Type, with id: T.ID) -> T? where T.ID: Codable & Equatable {
        let descriptor = FetchDescriptor<T>(predicate: #Predicate { item in
            item.id == id
        })
        do {
            return try modelContext.fetch(descriptor).first
        } catch {
            print("Fetch failed for type \(type): \(error.localizedDescription)")
            return nil
        }
    }
    
    func fetchByName<T: Searchable>(_ type: T.Type, nameQuery: String) -> [T] {
        let descriptor = FetchDescriptor<T>(
            predicate: #Predicate { $0.name.contains(nameQuery) }
        )
        
        do {
            return try modelContext.fetch(descriptor)
        } catch {
            print("Error fetching \(type): \(error.localizedDescription)")
            return []
        }
    }
    
    func fetchAll<T: PersistentModel>(_ type: T.Type) -> [T] {
        let descriptor = FetchDescriptor<T>()
        return (try? modelContext.fetch(descriptor)) ?? []
    }
    
    func fetchPendingUpdates<T: PersistentModel & Updatable>(_ type: T.Type) -> [T] {
        let descriptor = FetchDescriptor<T>(predicate: #Predicate { item in
            if let lastSync = item.lastSync {
                return item.lastUpdate > lastSync
            } else if item.lastSync == nil {
                return true
            } else {
                return false
            }
        })
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
    
    func printAllData<T: PersistentModel>(of type: T.Type) {
        let descriptor = FetchDescriptor<T>()
        do {
            let results = try modelContext.fetch(descriptor)
            for item in results {
                print("\(item.id) - \(item)")
            }
        } catch {
            print("Error fetching \(T.self): \(error.localizedDescription)")
        }
    }
}
