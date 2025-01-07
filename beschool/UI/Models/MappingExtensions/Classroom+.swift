//
//  Classroom+.swift
//  beschool
//
//  Created by Igor Squadra on 17/12/24.
//

import Foundation

extension Classroom {
    var domainModel: ClassroomDomain {
        ClassroomDomain(
            id: self.id,
            roomName: self.roomName,
            school: self.school,
            professor: self.professor?.domainModel,
            students: self.students.map { $0.domainModel }
        )
    }
}
