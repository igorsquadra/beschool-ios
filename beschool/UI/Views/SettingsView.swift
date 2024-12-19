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
        VStack(spacing: 40) {
                Text("SETTINGS")
                    .font(.barlowCondensed(size: .largeTitle2Size, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 24)
                Image(.logo)
                    .resizable()
                    .frame(width: 100, height: 100)
                Text("App Version \(Utils.currentEnvironment.appVersion)")
                .font(.barlow(size: .bodySize, weight: .medium))
                .foregroundColor(.black.opacity(0.5))
                Button {
                    deleteData()
                } label: {
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .fill(.amethystSmoke)
                        .frame(height: 46)
                        .overlay {
                            Text("Delete data and relaunch app".uppercased())
                                .font(.barlow(size: .bodySize, weight: .bold))
                                .foregroundColor(.white)
                        }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 14)
                Spacer()
            }
            .background(.whisper)
    }

    private func deleteData() {
        appManager.deleteAll()
        appManager.restart()
    }
}

#Preview {
    SettingsView()
        .environmentObject(AppManager())
}
