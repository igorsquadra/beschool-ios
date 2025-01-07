//
//  ProfessorData.swift
//  beschool
//
//  Created by Igor Squadra on 17/12/24.
//

import Foundation
import RealmSwift

class ProfessorData: Object, Codable, Searchable {
    @Persisted(primaryKey: true) var id: String
    @Persisted var name: String
    @Persisted var email: String
    @Persisted var subjects: List<String>
    @Persisted var avatar: String?
    
    convenience init(
        id: String,
        name: String,
        email: String,
        subjects: [String] = [],
        avatar: String? = nil
    ) {
        self.init()
        self.id = id
        self.name = name
        self.email = email
        self.subjects = List<String>()
        self.subjects.append(objectsIn: subjects)
        self.avatar = avatar
    }
}
