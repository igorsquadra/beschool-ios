//
//  ClassroomDomain.swift
//  beschool
//
//  Created by Igor Squadra on 07/01/25.
//


import Foundation

struct ClassroomDomain: Identifiable, Codable {
    let id: String
    let roomName: String
    let school: String
    var professor: ProfessorDomain?
    var students: [StudentDomain]
    var lastUpdate: Date
    var lastSync: Date?
    var isNew: Bool
    var isDeleted: Bool
    
    init(
        id: String,
        roomName: String,
        school: String,
        professor: ProfessorDomain? = nil,
        students: [StudentDomain] = [],
        lastUpdate: Date = Date(),
        lastSync: Date? = nil,
        isNew: Bool = false,
        isDeleted: Bool = false
    ) {
        self.id = id
        self.roomName = roomName
        self.school = school
        self.professor = professor
        self.students = students
        self.lastUpdate = lastUpdate
        self.lastSync = lastSync
        self.isNew = isNew
        self.isDeleted = isDeleted
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case roomName
        case school
        case professor
        case students
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.roomName = try container.decode(String.self, forKey: .roomName)
        self.school = try container.decode(String.self, forKey: .school)
        self.professor = try container.decodeIfPresent(ProfessorDomain.self, forKey: .professor)
        if let classroomStudents = try container.decodeIfPresent([StudentDomain].self, forKey: .students) {
            self.students = classroomStudents
        } else {
            self.students = [StudentDomain]()
        }
        self.lastUpdate = Date()
        self.lastSync = Date()
        self.isNew = false
        self.isDeleted = false
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(roomName, forKey: .roomName)
        try container.encode(school, forKey: .school)
        if let professor = professor {
            try container.encode(professor, forKey: .professor)
        }
        try container.encode(students, forKey: .students)
    }
}
