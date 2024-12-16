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
        case appAlreadyRegisteredToPushNotifications
        case cmpAlreadyShown
        case savedArticles
        case notifications
        case readNotificationIds
    }
    
    static var appAlreadyLaunched: Bool {
        get {
            UserDefaults.standard.bool(forKey: UserDefaultsKeys.appAlreadyLaunched.rawValue)
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: UserDefaultsKeys.appAlreadyLaunched.rawValue)
        }
    }
    
    static var appAlreadyRegisteredToPushNotifications: Bool {
        get {
            UserDefaults.standard.bool(forKey: UserDefaultsKeys.appAlreadyRegisteredToPushNotifications.rawValue)
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: UserDefaultsKeys.appAlreadyRegisteredToPushNotifications.rawValue)
        }
    }
    
    static var cmpAlreadyShown: Bool {
        get {
            UserDefaults.standard.bool(forKey: UserDefaultsKeys.cmpAlreadyShown.rawValue)
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: UserDefaultsKeys.cmpAlreadyShown.rawValue)
        }
    }
    
    static var readNotificationIds: [Int] {
        get {
            return UserDefaults.standard.array(forKey: UserDefaultsKeys.readNotificationIds.rawValue) as? [Int] ?? []
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: UserDefaultsKeys.readNotificationIds.rawValue)
        }
    }
    
    static var notifications: [Notification] {
        get {
            if let data = UserDefaults.standard.data(forKey: UserDefaultsKeys.notifications.rawValue),
               let notifications = try? JSONDecoder().decode([Notification].self, from: data) {
                return notifications
            }
            return []
        }
        set {
            if let encodedData = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.setValue(encodedData, forKey: UserDefaultsKeys.notifications.rawValue)
            }
        }
    }
}
