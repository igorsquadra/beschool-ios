//
//  Classroom.swift
//  beschool
//
//  Created by Igor Squadra on 17/12/24.
//


import Foundation

struct Classroom: Identifiable {
    let id: String
    let roomName: String
    let school: String
    let professor: Professor?
    let students: [Student]

    init(
        id: String,
        roomName: String,
        school: String,
        professor: Professor?,
        students: [Student]
    ) {
        self.id = id
        self.roomName = roomName
        self.school = school
        self.professor = professor
        self.students = students
    }
}

extension Classroom: Equatable {
    static func == (lhs: Classroom, rhs: Classroom) -> Bool {
        return lhs.id == rhs.id
    }
}
