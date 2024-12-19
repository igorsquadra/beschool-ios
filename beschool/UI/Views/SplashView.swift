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
        ZStack {
            Color.whisper
            LottieView(animationName: .splash, loopMode: .playOnce, completion: completion)
                .frame(width: 339, height: 155)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                        completion?()
                    })
                }
        }
        .ignoresSafeArea()
    }
}
