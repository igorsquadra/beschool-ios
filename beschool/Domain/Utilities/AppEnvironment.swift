//
//  AppEnvironment.swift
//  beschool
//
//  Created by Igor Squadra on 17/12/24.
//

import Foundation
import SwiftUI

/// Represents the different environments in which the application can operate: Debug and Production.
/// The `AppEnvironment` enum is responsible for exposing and managing the current environment configuration of the app.
/// It allows developers to access environment-specific settings and behaviors based on the selected scheme during
/// development.
enum AppEnvironment {
    case debug
    case production
    
    private enum InfoKey: String {
        case baseUrl = "BaseUrl"
        case apiKey = "ApiKey"
        case appVersion = "CFBundleShortVersionString"
        case buildVersion = "BuildVersion"
    }
    
    var name: String {
        switch self {
        case .debug: "Debug"
        case .production: "Production"
        }
    }
    
    var baseURL: String {
        info(for: .baseUrl) ?? ""
    }
    
    var avatarBaseURL: String {
        return "https://api.dicebear.com/7.x/avataaars/jpg?seed="
    }
    
    var apiKey: String {
        info(for: .apiKey) ?? ""
    }
    
    var appVersion: String {
        let release = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String? ?? ""
        let build = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String? ?? "x"
        return "\(release) (\(build))"
    }
}

// MARK: - Utility

extension AppEnvironment {
  /// Retrieve value from project info plist.
  /// - Parameter key: the needed key.
  /// - Returns: Value related to passed key if present.
  private func info(for key: InfoKey) -> String? {
    return (Bundle.main.infoDictionary?[key.rawValue] as? String)?
      .replacingOccurrences(of: "\\", with: "")
  }
}
