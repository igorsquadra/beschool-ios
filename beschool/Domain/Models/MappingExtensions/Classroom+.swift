//
//  Classroom+.swift
//  beschool
//
//  Created by Igor Squadra on 17/12/24.
//

import Foundation

extension Classroom {
    var dataModel: ClassroomData {
        ClassroomData(
            id: self.id,
            roomName: self.roomName,
            school: self.school,
            professor: self.professor?.dataModel,
            students: self.students.map { $0.dataModel },
            lastUpdate: Date(),
            lastSync: nil
        )
    }
}
