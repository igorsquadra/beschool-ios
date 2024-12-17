//
//  Professor.swift
//  beschool
//
//  Created by Igor Squadra on 17/12/24.
//


import Foundation

struct Professor: Identifiable {
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