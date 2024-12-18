//
//  SplashView.swift
//  beschool
//
//  Created by Igor Squadra on 17/12/24.
//


import Foundation
import SwiftUI

struct SplashView: View {
    let completion: (() -> Void)?
    var body: some View {
        VStack(spacing: 13) {
            Spacer()
            LottieView(animationName: .splash, loopMode: .playOnce, completion: completion)
                .frame(width: 339, height: 155)
                .padding(.horizontal, 20)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                        completion?()
                    })
                }
            Spacer()
        }
    }
}
