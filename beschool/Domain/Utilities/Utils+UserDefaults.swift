//
//  Utils+UserDefaults.swift
//  lacnews24
//
//  Created by Igor Squadra on 14/06/24.
//

import Foundation

extension Utils {
    enum UserDefaultsKeys: String {
        case appAlreadyLaunched
    }
    
    static var appAlreadyLaunched: Bool {
        get {
            UserDefaults.standard.bool(forKey: UserDefaultsKeys.appAlreadyLaunched.rawValue)
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: UserDefaultsKeys.appAlreadyLaunched.rawValue)
        }
    }
}
