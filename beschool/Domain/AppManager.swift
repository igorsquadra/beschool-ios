//
//  AppManager.swift
//  beschool
//
//  Created by Igor Squadra on 17/12/24.
//


import Foundation
import SwiftData

protocol Profile: Hashable, Equatable {
    var id: String { get }
    var name: String { get }
    var email: String { get }
    var avatar: String? { get }
}

@MainActor
class AppManager: ObservableObject {
    private let networkManager = NetworkManager.shared
    private let localManager: LocalManager
    
    @Published var appState: AppState = .splash
    @Published var classroomsUpdated = false

    init() {
        localManager = LocalManager()
        localManager.printAllData(of: StudentData.self)
        localManager.printAllData(of: ProfessorData.self)
        localManager.printAllData(of: ClassroomData.self)
    }
    
    func splashAnimationEnded() {
        appState = .home
    }
    
    func restart() {
        appState = .splash
    }

    // MARK: - Classroom Operations
    
    func createClassroom(_ classroom: Classroom) {
        let classroomData = classroom.dataModel
        classroomData.lastUpdate = Date()
        classroomData.isNew = true
        localManager.save(ClassroomData.self, [classroomData])
        classroomsUpdated.toggle()
    }

    func getClassrooms() async throws -> [Classroom] {
        localManager.fetchAll(ClassroomData.self)
            .filter({ $0.isDeleted == false })
            .map { $0.uiModel }
    }

    func editClassroom(_ classroom: Classroom) {
        guard let existingClassroom = localManager.fetch(ClassroomData.self, with: classroom.id) else {
            print("Classroom with ID \(classroom.id) not found.")
            return
        }
        
        existingClassroom.roomName = classroom.roomName
        existingClassroom.professor = classroom.professor?.dataModel
        existingClassroom.students = classroom.students.map { $0.dataModel }
        existingClassroom.lastUpdate = Date()
        classroomsUpdated.toggle()
    }

    func deleteClassroom(id: String) {
        if let classroom = localManager.fetch(ClassroomData.self, with: id) {
            if classroom.lastSync != nil {   
                classroom.lastUpdate = Date()
                classroom.isDeleted = true
            } else {
                localManager.delete(ClassroomData.self, with: id)
            }
        }
    }

    // MARK: - Professor Operations

    func getProfessor(with id: String) -> Professor? {
        localManager.fetch(ProfessorData.self, with: id)?.uiModel
    }
    
    func getProfessors() -> [Professor]? {
        let professorsData = localManager.fetchAll(ProfessorData.self)
        return professorsData.map { $0.uiModel }
    }

    func editProfessor(in classroom: Classroom, updatedProfessor: Professor) {
        let updatedClassroom = classroom.dataModel
        updatedClassroom.professor = updatedProfessor.dataModel
        updatedClassroom.lastUpdate = Date()
    }

    // MARK: - Student Operations

    func getStudent(with id: String) -> Student? {
        localManager.fetch(StudentData.self, with: id)?.uiModel
    }
    
    func getStudents() -> [Student]? {
        localManager.fetchAll(StudentData.self).map { $0.uiModel }
    }

    func editStudent(in classroom: Classroom, updatedStudent: Student) {
        let updatedClassroom = classroom.dataModel
        if let index = updatedClassroom.students?.firstIndex(where: { $0.id == updatedStudent.id }) {
            updatedClassroom.students?[index] = updatedStudent.dataModel
        } else {
            updatedClassroom.students?.append(updatedStudent.dataModel)
        }
        updatedClassroom.lastUpdate = Date()
    }
    
    func removeStudent(with id: String, from classroomId: String) {
        guard let classroom = localManager.fetch(ClassroomData.self, with: id) else {
            return
        }
        
        if let index = classroom.students?.firstIndex(where: { $0.id == id }) {
            classroom.students?.remove(at: index)
            classroom.lastUpdate = Date()
        } else {
            print("Student with ID \(id) not found in classroom \(classroomId).")
        }
    }
    
    func searchProfiles(for query: String) -> [any Profile] {
        var results: [any Profile] = []
        let students = localManager.fetchByName(StudentData.self, nameQuery: query).compactMap( { $0.uiModel })
        let professors = localManager.fetchByName(ProfessorData.self, nameQuery: query).compactMap( { $0.uiModel })
        results.append(contentsOf: students)
        results.append(contentsOf: professors)
        return results
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
                if classroom.isNew, !classroom.isDeleted {
                    let newClassroom = try await networkManager.createClassroom(classroom)
                    classroom.lastSync = Date()
                    localManager.save(ClassroomData.self, [newClassroom])
                } else {
                    let updatedClassroom = try await networkManager.editClassroom(classroom)
                    guard let existingClassroom = localManager.fetch(ClassroomData.self, with: updatedClassroom.id) else {
                        print("Classroom with ID \(classroom.id) not found.")
                        return
                    }
                    existingClassroom.roomName = updatedClassroom.roomName
                    existingClassroom.professor = updatedClassroom.professor
                    existingClassroom.students = updatedClassroom.students
                    existingClassroom.lastUpdate = Date()
                    existingClassroom.lastSync = Date()
                }
            }
        }
        
        guard let updatedClassrooms = try await networkManager.fetchClassrooms() else { return }
        deleteAll()
        localManager.save(ClassroomData.self, updatedClassrooms)
        classroomsUpdated.toggle()
        print("Sync completed. Fetched updated classrooms.")
    }
    
    func deleteAll() {
        localManager.deleteAll(ClassroomData.self)
        localManager.deleteAll(ProfessorData.self)
        localManager.deleteAll(StudentData.self)
    }
}
