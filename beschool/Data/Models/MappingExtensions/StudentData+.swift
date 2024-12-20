//
//  StudentData+.swift
//  beschool
//
//  Created by Igor Squadra on 17/12/24.
//

import Foundation

extension StudentData {
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
