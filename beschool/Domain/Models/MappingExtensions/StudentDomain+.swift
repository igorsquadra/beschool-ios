//
//  StudentDomain+.swift
//  beschool
//
//  Created by Igor Squadra on 07/01/25.
//

import Foundation

extension StudentDomain {
    var dataModel: StudentData {
        StudentData(
            id: self.id,
            name: self.name,
            email: self.email,
            avatar: self.avatar,
            notes: self.notes
        )
    }
    
    var uiModel: Student {
        Student(
            id: self.id,
            name: self.name,
            email: self.email,
            avatar: self.avatar,
            notes: self.notes
        )
    }
}
