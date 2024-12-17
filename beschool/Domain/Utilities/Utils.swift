//
//  Utils.swift
//  beschool
//
//  Created by Igor Squadra on 17/12/24.
//

import Foundation
import UIKit
import SwiftData

class Utils {
  
    /// Get current environment
    static var currentEnvironment: AppEnvironment {
        #if DEBUG
        return .debug
        #else
        return .production
        #endif
    }
    
    static var isPreview: Bool {
        ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }
    
    static var isIpad: Bool { UIDevice.current.userInterfaceIdiom == .pad }
    
    static func printDatabasePath() {
        do {
            let container = try ModelContainer(for: ClassroomData.self)
            if let store = container.configurations.first?.url {
                print("SwiftData Database Path: \(store.path)")
            }
        } catch {
            print("Failed to locate SwiftData database: \(error)")
        }
    }
}
