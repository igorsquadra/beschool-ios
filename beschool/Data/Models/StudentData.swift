//
//  StudentData.swift
//  beschool
//
//  Created by Igor Squadra on 17/12/24.
//

import Foundation
import RealmSwift

class StudentData: Object, Codable, Searchable {
    @Persisted(primaryKey: true) var id: String
    @Persisted var name: String
    @Persisted var email: String
    @Persisted var avatar: String?
    @Persisted var notes: String?
    
    convenience init(
        id: String,
        name: String,
        email: String,
        avatar: String? = nil,
        notes: String? = nil
    ) {
        self.init()
        self.id = id
        self.name = name
        self.email = email
        self.avatar = avatar
        self.notes = notes
    }
}
