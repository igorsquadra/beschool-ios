//
//  ClassroomData+.swift
//  beschool
//
//  Created by Igor Squadra on 17/12/24.
//

import Foundation

extension ClassroomData {
    var uiModel: Classroom {
        Classroom(
            id: self.id,
            roomName: self.roomName,
            school: self.school,
            professor: self.professor?.uiModel,
            students: self.students?.map { $0.uiModel } ?? []
        )
    }
}
