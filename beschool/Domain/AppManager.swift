//
//  AppManager.swift
//  beschool
//
//  Created by Igor Squadra on 17/12/24.
//


import Foundation
import SwiftData

@MainActor
class AppManager: ObservableObject {
    private let networkManager = NetworkManager.shared
    private let localManager: LocalManager
    
    @Published var appState: AppState = .splash

    init() {
        localManager = LocalManager()
    }
    
    func splashAnimationEnded() {
        appState = .home
    }
    
    func restart() {
        appState = .splash
    }

    // MARK: - Classroom Operations

    func getClassrooms() async throws -> [Classroom] {
        localManager.fetchAll(ClassroomData.self).map { $0.uiModel }
    }

    func editClassroom(_ classroom: Classroom) {
        let classroomData = classroom.dataModel
        classroomData.lastUpdate = Date()
    }

    func deleteClassroom(id: String) {
        if let classroom = localManager.fetch(ClassroomData.self, with: id) {
            classroom.lastUpdate = Date()
            classroom.isDeleted = true
        }
    }

    // MARK: - Professor Operations

    func getProfessor(with id: String) -> Professor? {
        localManager.fetch(ProfessorData.self, with: id)?.uiModel
    }

    func editProfessor(in classroom: Classroom, updatedProfessor: Professor) {
        var updatedClassroom = classroom.dataModel
        updatedClassroom.professor = updatedProfessor.dataModel
        updatedClassroom.lastUpdate = Date()
    }

    // MARK: - Student Operations

    func getStudent(with id: String) -> Student? {
        localManager.fetch(StudentData.self, with: id)?.uiModel
    }

    func editStudent(in classroom: Classroom, updatedStudent: Student) {
        var updatedClassroom = classroom.dataModel
        if let index = updatedClassroom.students?.firstIndex(where: { $0.id == updatedStudent.id }) {
            updatedClassroom.students?[index] = updatedStudent.dataModel
        } else {
            updatedClassroom.students?.append(updatedStudent.dataModel)
        }
        updatedClassroom.lastUpdate = Date()
    }
    
    func removeStudent(with id: String, from classroomId: String) {
        guard let classroom = localManager.fetch(ClassroomData.self, with: id) else {
            print("Classroom with ID \(classroomId) not found.")
            return
        }
        
        if let index = classroom.students?.firstIndex(where: { $0.id == id }) {
            classroom.students?.remove(at: index)
            classroom.lastUpdate = Date()
            print("Student with ID \(id) removed from classroom \(classroomId).")
        } else {
            print("Student with ID \(id) not found in classroom \(classroomId).")
        }
    }

    // MARK: - Sync Method

    /// Sync all modified classrooms to the backend
    func syncAll() async throws {
        let pendingUpdates = localManager.fetchPendingUpdates(ClassroomData.self)
        
        for classroom in pendingUpdates {
            if classroom.isDeleted,
               try await networkManager.deleteClassroom(id: classroom.id) {
                localManager.delete(ClassroomData.self, with: classroom.id)
            } else {
                try await networkManager.editClassroom(classroom)
                classroom.lastSync = Date()
                localManager.save(ClassroomData.self, [classroom])
            }
        }
        
        guard let updatedClassrooms = try await networkManager.fetchClassrooms() else { return }
        localManager.save(ClassroomData.self, updatedClassrooms)
        print("Sync completed. Fetched updated classrooms.")
    }
    
    func deleteAll() {
        localManager.deleteAll(ClassroomData.self)
        localManager.deleteAll(ProfessorData.self)
        localManager.deleteAll(StudentData.self)
    }
}
