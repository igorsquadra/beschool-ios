//
//  Utils+UserDefaults.swift
//  beschool
//
//  Created by Igor Squadra on 17/12/24.
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
