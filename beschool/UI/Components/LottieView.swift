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

struct LottieView: UIViewRepresentable {
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
