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
                TabView {
                    HomeView()
                        .environmentObject(appManager)
                        .tabItem {
                            Label("", systemImage: "house")
                        }
                    SearchView()
                        .environmentObject(appManager)
                        .tabItem {
                            Label("", systemImage: "magnifyingglass")
                        }
                    SettingsView()
                        .environmentObject(appManager)
                        .tabItem {
                            Label("", systemImage: "gear")
                        }
                }
            }
        }
    }
}
