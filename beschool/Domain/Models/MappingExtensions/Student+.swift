//
//  Student+.swift
//  beschool
//
//  Created by Igor Squadra on 17/12/24.
//

import Foundation

extension Student {
    var dataModel: StudentData {
        StudentData(
            id: self.id,
            name: self.name,
            email: self.email,
            avatar: self.avatar,
            notes: self.notes
        )
    }
}
