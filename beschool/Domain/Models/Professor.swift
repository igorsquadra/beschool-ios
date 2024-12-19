//
//  Professor.swift
//  beschool
//
//  Created by Igor Squadra on 17/12/24.
//


import Foundation

struct Professor: Identifiable, Hashable, Profile {
    let id: String
    let name: String
    let email: String
    let subjects: [String]
    let avatar: String?

    init(id: String, name: String, email: String, subjects: [String], avatar: String?) {
        self.id = id
        self.name = name
        self.email = email
        self.subjects = subjects
        self.avatar = avatar
    }
}

extension Professor: Equatable {
    static func == (lhs: Professor, rhs: Professor) -> Bool {
        return lhs.id == rhs.id
    }
}
