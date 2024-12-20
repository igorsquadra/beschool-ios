//
//  ProfessorData+.swift
//  beschool
//
//  Created by Igor Squadra on 17/12/24.
//

import Foundation

extension ProfessorData {
    var uiModel: Professor {
        Professor(
            id: self.id,
            name: self.name,
            email: self.email,
            subjects: self.subjects,
            avatar: self.avatar
        )
    }
}
