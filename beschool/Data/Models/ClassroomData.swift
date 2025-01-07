//
//  ClassroomData.swift
//  beschool
//
//  Created by Igor Squadra on 17/12/24.
//

import Foundation
import RealmSwift

class ClassroomData: Object, Codable, Identifiable, Updatable {
    @Persisted(primaryKey: true) var id: String
    @Persisted var roomName: String
    @Persisted var school: String
    @Persisted var professor: ProfessorData?
    @Persisted var students: List<StudentData>
    @Persisted var lastUpdate: Date
    @Persisted var lastSync: Date?
    @Persisted var isNew: Bool
    @Persisted var isDeleted: Bool
    
    convenience init(
        id: String,
        roomName: String,
        school: String,
        professor: ProfessorData? = nil,
        students: [StudentData]? = nil,
        lastUpdate: Date = Date(),
        lastSync: Date? = nil,
        isNew: Bool = false,
        isDeleted: Bool = false
    ) {
        self.init()
        self.id = id
        self.roomName = roomName
        self.school = school
        self.professor = professor
        if let students {
            self.students = List<StudentData>()
            self.students.append(objectsIn: students)
        }
        self.lastUpdate = lastUpdate
        self.lastSync = lastSync
        self.isNew = isNew
        self.isDeleted = isDeleted
    }
}
