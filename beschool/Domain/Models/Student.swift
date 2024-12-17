//
//  Student.swift
//  beschool
//
//  Created by Igor Squadra on 17/12/24.
//


import Foundation

struct Student: Identifiable {
    let id: String
    let name: String
    let email: String
    let avatar: String?
    let notes: String?

    init(id: String, name: String, email: String, avatar: String?, notes: String?) {
        self.id = id
        self.name = name
        self.email = email
        self.avatar = avatar
        self.notes = notes
    }
}