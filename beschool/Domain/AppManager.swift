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
    }
    
    func splashAnimationEnded() {
        appState = .home
    }
    
    func restart() {
        appState = .splash
    }

    // MARK: - Classroom Operations
    
    func createClassroom(_ classroom: Classroom) {
        var classroomDomain = classroom.domainModel
        classroomDomain.lastUpdate = Date()
        classroomDomain.isNew = true
        localManager.save([classroomDomain.dataModel])
    }
    
    func getClassroom(with id: String) async throws -> [Classroom] {
        localManager.fetchAll(ClassroomData.self)
            .map { $0.domainModel }
            .filter({ $0.isDeleted == false })
            .map { $0.uiModel }
    }

    func getClassrooms() async throws -> [Classroom] {
        localManager.fetchAll(ClassroomData.self)
            .map { $0.domainModel }
            .filter({ $0.isDeleted == false })
            .map { $0.uiModel }
    }

    func editClassroom(_ classroom: Classroom, professor: Professor?, students: [Student]) {
        let existingClassroom = localManager.fetch(ClassroomData.self, with: classroom.id)
        var classroomToSave = classroom.domainModel
        
        if let professorDomain = professor?.domainModel {
            localManager.save([professorDomain.dataModel])
            classroomToSave.professor = professorDomain
        }
        let studentsDomain = students.map({ $0.domainModel })
        localManager.save(studentsDomain.map({ $0.dataModel }))
        
        classroomToSave.students = studentsDomain
        classroomToSave.lastUpdate = Date()
        if let existingClassroom {
            classroomToSave.isNew = existingClassroom.isNew
            classroomToSave.lastSync = existingClassroom.lastSync
        }
        localManager.save([classroomToSave.dataModel])
    }

    func deleteClassroom(_ classroom: Classroom) {
        var classroomDomain = classroom.domainModel
        if let lastSync = localManager.fetch(ClassroomData.self, with: classroomDomain.id)?.lastSync {
            classroomDomain.lastUpdate = Date()
            classroomDomain.lastSync = lastSync
            classroomDomain.isDeleted = true
            localManager.save([classroomDomain.dataModel])
        } else {
            // If classroom was never synced, just delete it locally
            localManager.delete(ClassroomData.self, with: classroomDomain.id)
        }
    }

    // MARK: - Professor Operations

    func getProfessor(with id: String) -> Professor? {
        let professorDomain = localManager.fetch(ProfessorData.self, with: id)?.domainModel
        return professorDomain?.uiModel
    }
    
    func getProfessors() -> [Professor]? {
        let professorsDomain = localManager.fetchAll(ProfessorData.self).map { $0.domainModel }
        return professorsDomain.map { $0.uiModel }
    }

    func editProfessor(in classroom: Classroom, updatedProfessor: Professor) {
        var updatedClassroom = classroom.domainModel
        updatedClassroom.professor = updatedProfessor.domainModel
        updatedClassroom.lastUpdate = Date()
        localManager.save([updatedClassroom.dataModel])
        classroomsUpdated.toggle()
    }

    // MARK: - Student Operations

    func getStudent(with id: String) -> Student? {
        let studentDomain = localManager.fetch(StudentData.self, with: id)?.domainModel
        return studentDomain?.uiModel
    }
    
    func getStudents() -> [Student]? {
        let studentsDomain = localManager.fetchAll(StudentData.self).map { $0.domainModel }
        return studentsDomain.map { $0.uiModel }
    }

    func editStudent(in classroom: Classroom, updatedStudent: Student) {
        var updatedClassroom = classroom.domainModel
        if let index = updatedClassroom.students.firstIndex(where: { $0.id == updatedStudent.id }) {
            updatedClassroom.students[index] = updatedStudent.domainModel
        } else {
            updatedClassroom.students.append(updatedStudent.domainModel)
        }
        updatedClassroom.lastUpdate = Date()
        localManager.save([updatedClassroom.dataModel])
        classroomsUpdated.toggle()
    }
    
    func searchProfiles(for query: String) -> [any Profile] {
        var results: [any Profile] = []
        let students = localManager.fetchByName(StudentData.self, nameQuery: query).compactMap( { $0.domainModel })
        let professors = localManager.fetchByName(ProfessorData.self, nameQuery: query).compactMap( { $0.domainModel })
        results.append(contentsOf: students.map({ $0.uiModel }) )
        results.append(contentsOf: professors.map({ $0.uiModel }) )
        return results
    }

    // MARK: - Sync Method

    /// Sync all modified classrooms to the backend
    func syncAll() async throws {
        let pendingUpdates = localManager.fetchPendingUpdates(ClassroomData.self).map({ $0.domainModel })
        for classroom in pendingUpdates {
            if classroom.isDeleted,
               try await networkManager.deleteClassroom(id: classroom.id) {
                localManager.delete(ClassroomData.self, with: classroom.id)
            } else {
                if classroom.lastSync == nil, !classroom.isDeleted {
                    var newClassroom = try await networkManager.createClassroom(classroom)
                    newClassroom.lastSync = Date()
                    localManager.save([newClassroom.dataModel])
                } else {
                    var updatedClassroom = try await networkManager.editClassroom(classroom)
                    updatedClassroom.lastSync = Date()
                    localManager.save([updatedClassroom.dataModel])
                }
            }
        }
        
        if let updatedClassrooms = try await networkManager.fetchClassrooms() {
            deleteAll()
            localManager.save(updatedClassrooms.compactMap({ $0.dataModel }))
        }
        print("Sync completed. Fetched updated classrooms.")
    }
    
    func deleteAll() {
        localManager.deleteAll(ClassroomData.self)
        localManager.deleteAll(ProfessorData.self)
        localManager.deleteAll(StudentData.self)
    }
}
