//
//  AlertView.swift
//  beschool
//
//  Created by Igor Squadra on 16/12/24.
//


import SwiftUI

struct AlertView: View {
  private let title: String
  private let message: String
  private let actions: [AlertActionItem]
  private let arrangeButtonsVertically: Bool

  init(
    title: String,
    message: String,
    actions: [AlertActionItem],
    arrangeButtonsVertically: Bool = false
  ) {
    self.title = title
    self.message = message
    self.actions = actions
    self.arrangeButtonsVertically = arrangeButtonsVertically
  }

  var body: some View {
    VStack(alignment: .leading, spacing: 24) {
      VStack(alignment: .leading, spacing: 8) {
        Text(title)
          .font(.system(size: 16, weight: .semibold))
          .foregroundStyle(.black)
        Text(message)
          .font(.system(size: 14, weight: .regular))
          .foregroundStyle(.black)
      }
      if arrangeButtonsVertically {
        VStack(spacing: 16) {
          ForEach(actions, id: \.id) { alertAction in
            alertAction.button
          }
        }
      } else {
        HStack(spacing: 16) {
          ForEach(actions, id: \.id) { alertAction in
            alertAction.button
          }
        }
      }

    }
    .padding(.all, 24)
    .background(
      RoundedRectangle(cornerRadius: 16, style: .circular)
        .foregroundStyle(Color(.white))
        .shadow(radius: 4)
    )
    .frame(width: 330)
  }
}

#Preview {
  VStack(spacing: 20) {
    AlertView(
      title: "Error",
      message: "Unknown error",
      actions: [AlertActionItem(alertAction: .ok, dismiss: {})]
    )
  }
}
