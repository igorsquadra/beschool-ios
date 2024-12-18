//
//  SettingsView.swift
//  beschool
//
//  Created by Igor Squadra on 18/12/24.
//


import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var appManager: AppManager

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Image(systemName: "app.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .padding()

                Text("App Version \(Utils.currentEnvironment.appVersion)")
                    .font(.headline)
                    .foregroundColor(.gray)

                Button(action: deleteData) {
                    Text("Delete Data")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .cornerRadius(8)
                }
                .padding(.horizontal, 20)

                Spacer()
            }
            .padding()
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Settings")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.black)
                }
            }
        }
    }

    private func deleteData() {
        appManager.deleteAll()
    }
}
