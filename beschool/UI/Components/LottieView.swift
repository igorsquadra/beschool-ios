//
//  LottieView.swift
//  beschool
//
//  Created by Igor Squadra on 16/12/24.
//

import SwiftUI
import Lottie

enum LottieAnimations: String {
  case splash = "animation-splash-screen"
}

struct LottieView: View {
    let animationName: LottieAnimations
    let loopMode: LottieLoopMode
    let completion: (() -> Void)?
    
    init(
        animationName: LottieAnimations,
        loopMode: LottieLoopMode,
        completion: (() -> Void)? = nil
    ) {
        self.animationName = animationName
        self.loopMode = loopMode
        self.completion = completion
    }
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            LottieViewRepresentable(
                animationName: animationName,
                loopMode: loopMode,
                completion: completion
            )
            Rectangle()
                .fill(.whisper)
                .frame(width: 100, height: 50)
        }
    }
}

struct LottieViewRepresentable: UIViewRepresentable {
    let animationName: LottieAnimations
    let loopMode: LottieLoopMode
    let completion: (() -> Void)?
    
    func updateUIView(_ uiView: UIViewType, context: Context) { }
    
    func makeUIView(context: Context) -> Lottie.LottieAnimationView {
        let animationView = LottieAnimationView(name: animationName.rawValue)
        animationView.loopMode = loopMode
        animationView.play()
        animationView.contentMode = .scaleAspectFit
        return animationView
    }
}
