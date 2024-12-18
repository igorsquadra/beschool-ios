//
//  ProfessorData.swift
//  beschool
//
//  Created by Igor Squadra on 17/12/24.
//

import SwiftData
import Foundation

@Model
class ProfessorData: Codable, Updatable {
    @Attribute(.unique) var id: String
    var name: String
    var email: String
    var subjects: [String]
    var avatar: String?
    var lastUpdate: Date
    var lastSync: Date?
    
    init(
        id: String,
        name: String,
        email: String,
        subjects: [String] = [],
        avatar: String? = nil,
        lastUpdate: Date = Date(),
        lastSync: Date? = nil
    ) {
        self.id = id
        self.name = name
        self.email = email
        self.subjects = subjects
        self.avatar = avatar
        self.lastUpdate = lastUpdate
        self.lastSync = lastSync
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case email
        case subjects
        case avatar
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.email = try container.decode(String.self, forKey: .email)
        self.subjects = try container.decodeIfPresent([String].self, forKey: .subjects) ?? []
        self.avatar = try container.decodeIfPresent(String.self, forKey: .avatar)
        self.lastUpdate = Date()
        self.lastSync = Date()
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
