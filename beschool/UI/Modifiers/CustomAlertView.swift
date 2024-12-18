//
//  CustomAlertView.swift
//  beschool
//
//  Created by Igor Squadra on 16/12/24.
//


import SwiftUI

struct CustomAlertView: ViewModifier {
  @Binding var isPresented: Bool
  private let title: String
  private let message: String
  private let actions: [AlertAction]
  private let arrangeButtonsVertically: Bool
  init(
    isPresented: Binding<Bool>,
    title: String,
    message: String,
    actions: [AlertAction],
    arrangeButtonsVertically: Bool = false
  ) {
    _isPresented = isPresented
    self.title = title
    self.message = message
    self.actions = actions
    self.arrangeButtonsVertically = arrangeButtonsVertically
  }

  func body(content: Content) -> some View {
    ZStack {
      content
        .blur(radius: isPresented ? 4.0 : 0)
      if isPresented {
        Color.gray
          .opacity(0.6)
      }
    }
    .ignoresSafeArea()
    .overlay(isPresented ? alertContent : nil)
  }

    @ViewBuilder
    private var alertContent: some View {
        AlertView(
            title: title,
            message: message,
            actions: actions.map { action in
                AlertActionItem(
                    alertAction: action) {
                        isPresented = false
                    }
            },
            arrangeButtonsVertically: arrangeButtonsVertically
        )
    }
}

extension View {
  func showAlert(
    _ isPresented: Binding<Bool>,
    title: String,
    message: String,
    actions: [AlertAction],
    arrangeButtonsVertically: Bool = false
  ) -> some View {
    modifier(
      CustomAlertView(
        isPresented: isPresented,
        title: title,
        message: message,
        actions: actions,
        arrangeButtonsVertically: arrangeButtonsVertically
      )
      .animation(.linear(duration: 0.2))
    )
  }

  func errorAlert(
    _ error: Binding<AppError?>
  ) -> some View {
    modifier(
      CustomAlertView(
        isPresented: error.mappedToBool(),
        title: error.wrappedValue?.userTitle ?? "Error",
        message: error.wrappedValue?.userMessage ?? "Unknown error",
        actions: error.wrappedValue?.actions ?? [.ok]
      )
      .animation(.linear(duration: 0.2))
    )
  }
}

#Preview {
    VStack(spacing: 20) {
        Text("Hello mate")
    }
    .errorAlert(.constant(.networkError(
        message: "",
        actions: [
                .cancel,
                .custom(title: "Riprova", action: {}),
                .ok
            ]
        ))
    )
    .showAlert(
        .constant(true),
        title: "My custom alert",
        message: "This is a custom alert",
        actions: [.cancel, .ok],
        arrangeButtonsVertically: true
    )
}
