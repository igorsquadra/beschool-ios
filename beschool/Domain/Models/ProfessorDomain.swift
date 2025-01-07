//
//  ProfessorDomain.swift
//  beschool
//
//  Created by Igor Squadra on 07/01/25.
//


import Foundation

struct ProfessorDomain: Identifiable, Codable {
    let id: String
    let name: String
    let email: String
    let subjects: [String]
    let avatar: String?
    
    init(
        id: String,
        name: String,
        email: String,
        subjects: [String] = [],
        avatar: String? = nil
    ) {
        self.id = id
        self.name = name
        self.email = email
        self.subjects = subjects
        self.avatar = avatar
    }
    
    init(from data: ProfessorData) {
        self.id = data.id
        self.name = data.name
        self.email = data.email
        self.subjects = Array(data.subjects)
        self.avatar = data.avatar
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case email
        case subjects
        case avatar
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.email = try container.decode(String.self, forKey: .email)
        self.subjects = try container.decodeIfPresent([String].self, forKey: .subjects) ?? []
        self.avatar = try container.decodeIfPresent(String.self, forKey: .avatar)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(email, forKey: .email)
        try container.encode(subjects, forKey: .subjects)
        if let avatar = avatar {
            try container.encode(avatar, forKey: .avatar)
        }
    }
}
