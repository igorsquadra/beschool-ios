//
//  ClassroomDomain+.swift
//  beschool
//
//  Created by Igor Squadra on 07/01/25.
//

import Foundation

extension ClassroomDomain {
    var dataModel: ClassroomData {
        return ClassroomData(
            id: self.id,
            roomName: self.roomName,
            school: self.school,
            professor: self.professor?.dataModel,
            students: self.students.map { $0.dataModel },
            lastUpdate: self.lastUpdate,
            lastSync: self.lastSync,
            isNew: self.isNew,
            isDeleted: self.isDeleted
        )
    }
    
    var uiModel: Classroom {
        Classroom(
            id: self.id,
            roomName: self.roomName,
            school: self.school,
            professor: self.professor?.uiModel,
            students: self.students.map { $0.uiModel }
        )
    }
}
