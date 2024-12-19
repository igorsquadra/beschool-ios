//
//  IconButton.swift
//  beschool
//
//  Created by Igor Squadra on 18/12/24.
//


import SwiftUI

struct IconButton: View {
    let icon: Image
    let borderColor: Color
    let backgroundColor: Color
    let action: () -> Void
    let animateRotation: Bool
    
    @State private var isRotating: Bool = false
    
    var body: some View {
        Button(action: {
            if animateRotation {
                withAnimation(.easeInOut(duration: 0.6)) {
                    isRotating.toggle()
                }
            }
            action()
        }) {
          RoundedRectangle(cornerRadius: 12)
            .stroke(borderColor, lineWidth: borderColor == .clear ? 0 : 2)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .frame(width: 40, height: 40)
            .overlay {
              icon
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20)
                .foregroundColor(.black)
                .rotationEffect(.degrees(isRotating ? 360 : 0))
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
        .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
    }
}

#Preview {
  HStack {
    IconButton(
      icon: Image(.refresh),
      borderColor: .black,
      backgroundColor: .clear,
      action: {},
      animateRotation: true
    )
    IconButton(
        icon: Image(.plus),
      borderColor: .clear,
      backgroundColor: .whisper,
      action: {},
      animateRotation: false
    )
  }
}
