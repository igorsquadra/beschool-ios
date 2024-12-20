//
//  ButtonView.swift
//  beschool
//
//  Created by Igor Squadra on 16/12/24.
//


import SwiftUI

struct ButtonView: View {
    enum Size {
        case big
        case small
        var height: CGFloat {
            switch self {
            case .big: 64
            case .small: 42
            }
        }
    }
    
    private let backgroundColor: Color
    private let foregroundColor: Color
    private let borderColor: Color
    private let cornerRadius: CGFloat
    private let size: Size
    private let horizontalPadding: CGFloat
    private let text: String
    private let font: Font
    private let action: () -> Void
    private let fullWidth: Bool
    private let rightIcon: Image?
    private let leftIcon: Image?
    init(
        backgroundColor: Color,
        foregroundColor: Color,
        borderColor: Color = .clear,
        text: String,
        font: Font = .barlow(size: .bodySize, weight: .bold),
        action: @escaping () -> Void,
        cornerRadius: CGFloat = 50,
        size: Size = .big,
        horizontalPadding: CGFloat = 12,
        fullWidth: Bool = true,
        rightIcon: Image? = nil,
        leftIcon: Image? = nil
    ) {
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.borderColor = borderColor
        self.text = text
        self.font = font
        self.action = action
        self.cornerRadius = cornerRadius
        self.size = size
        self.horizontalPadding = horizontalPadding
        self.fullWidth = fullWidth
        self.rightIcon = rightIcon
        self.leftIcon = leftIcon
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 20) {
                leftIcon
                Text(text)
                    .font(font)
                    .frame(maxWidth: .infinity)
                    .fixedSize()
                rightIcon
            }
            .frame(maxWidth: fullWidth ? .infinity : .none)
            .padding(.horizontal, horizontalPadding)
            .foregroundStyle(foregroundColor)
        }
        .frame(height: size.height)
        .background(backgroundColor)
        .cornerRadius(cornerRadius)
        .overlay(
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .stroke(borderColor, lineWidth: 2)
        )
    }
}

#Preview {
    VStack {
        Spacer()
        ButtonView(
            backgroundColor: Color(.white),
            foregroundColor: Color(.red),
            text: "Dettaglio professore",
            action: {},
            cornerRadius: 8,
            leftIcon: Image(systemName: "qrcode")
        )
        .padding(.horizontal, 20)
        ButtonView(
            backgroundColor: Color(.red),
            foregroundColor: Color(.white),
            text: "Dettaglio aula",
            action: {},
            cornerRadius: 4,
            size: .small
        )
        .padding(.horizontal, 40)
        ButtonView(
            backgroundColor: Color(.purple),
            foregroundColor: Color(.white),
            text: "Modifica alunno",
            action: {},
            cornerRadius: 4,
            size: .small
        )
        .padding(.horizontal, 40)
        ButtonView(
            backgroundColor: Color(.darkGray),
            foregroundColor: Color(.white),
            text: "Vicino a me",
            font: .system(size: 18, weight: .medium),
            action: {},
            cornerRadius: 14,
            size: .small,
            leftIcon: Image(systemName: "pin")
        )
        .padding(.horizontal, 80)
        Spacer()
    }
    .background(.gray)
}
