//
//  ProfessorData+.swift
//  beschool
//
//  Created by Igor Squadra on 17/12/24.
//

import Foundation

extension ProfessorData {
    var domainModel: ProfessorDomain {
        ProfessorDomain(
            id: self.id,
            name: self.name,
            email: self.email,
            subjects: Array(self.subjects),
            avatar: self.avatar
        )
    }
}
