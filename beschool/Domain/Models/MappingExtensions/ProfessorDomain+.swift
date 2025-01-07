//
//  ProfessorDomain+.swift
//  beschool
//
//  Created by Igor Squadra on 07/01/25.
//

import Foundation

extension ProfessorDomain {
    var dataModel: ProfessorData {
        ProfessorData(
            id: self.id,
            name: self.name,
            email: self.email,
            subjects: self.subjects,
            avatar: self.avatar
        )
    }
    
    var uiModel: Professor {
        Professor(
            id: self.id,
            name: self.name,
            email: self.email,
            subjects: Array(self.subjects),
            avatar: self.avatar
        )
    }
}
