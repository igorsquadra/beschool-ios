//
//  ShowPopoverModifier.swift
//  beschool
//
//  Created by Igor Squadra on 18/12/24.
//

import SwiftUI

struct PopoverModifier<PopoverContent: View>: ViewModifier {
    @Binding var isPresented: Bool
    let popoverContent: () -> PopoverContent

    func body(content: Content) -> some View {
        ZStack {
            content
                .disabled(isPresented)
            if isPresented {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .blur(radius: 10)
                    .onTapGesture {
                        withAnimation { isPresented = false }
                    }
                popoverContent()
                .transition(.scale.combined(with: .opacity))
                .animation(.easeInOut, value: isPresented)
            }
        }
    }
}

extension View {
    func showPopover<PopoverContent: View>(
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> PopoverContent
    ) -> some View {
        self.modifier(PopoverModifier(isPresented: isPresented, popoverContent: content))
    }
}
