//
//  Encodable+.swift
//  beschool
//
//  Created by Igor Squadra on 17/12/24.
//

import Foundation

extension Encodable {
    var asDictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments))
            as? [String: Any]
    }
}
