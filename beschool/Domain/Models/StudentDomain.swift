//
//  StudentDomain.swift
//  beschool
//
//  Created by Igor Squadra on 07/01/25.
//


import Foundation

struct StudentDomain: Identifiable, Codable {
    let id: String
    let name: String
    let email: String
    let avatar: String?
    let notes: String?
    
    init(
        id: String,
        name: String,
        email: String,
        avatar: String? = nil,
        notes: String? = nil
    ) {
        self.id = id
        self.name = name
        self.email = email
        self.avatar = avatar
        self.notes = notes
    }
    
    init(from data: StudentData) {
        self.id = data.id
        self.name = data.name
        self.email = data.email
        self.avatar = data.avatar
        self.notes = data.notes
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case email
        case avatar
        case notes
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.email = try container.decode(String.self, forKey: .email)
        self.avatar = try container.decodeIfPresent(String.self, forKey: .avatar)
        self.notes = try container.decodeIfPresent(String.self, forKey: .notes)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(email, forKey: .email)
        if let avatar = avatar {
            try container.encode(avatar, forKey: .avatar)
        }
        if let notes = notes {
            try container.encode(notes, forKey: .notes)
        }
    }
}
