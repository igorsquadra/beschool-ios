//
//  beschoolApp.swift
//  beschool
//
//  Created by Igor Squadra on 16/12/24.
//

import SwiftUI
import SwiftData

@main
struct beschoolApp: App {
    @StateObject private var appManager: AppManager
    
    init() {
        _appManager = StateObject(wrappedValue: AppManager())
    }
    
    var body: some Scene {
        WindowGroup {
            switch appManager.appState {
            case .splash:
                SplashView {
                    appManager.splashAnimationEnded()
                }
                .task {
                    try? await appManager.syncAll()
                }
            case .home:
                ContentView()
                    .onAppear {
                    }
            }
        }
    }
}
