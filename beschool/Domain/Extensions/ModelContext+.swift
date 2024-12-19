//
//  ModelContext+.swift
//  beschool
//
//  Created by Igor Squadra on 18/12/24.
//

import SwiftData

extension ModelContext {
    var dbPath: String {
        if let url = container.configurations.first?.url.path(percentEncoded: false) {
            "sqlite3 \"\(url)\""
        } else {
            "No SQLite database found."
        }
    }
}
