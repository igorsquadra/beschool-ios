//
//  AlertAction.swift
//  beschool
//
//  Created by Igor Squadra on 16/12/24.
//


import SwiftUI

struct AlertActionItem {
    var id: UUID
    var title: String
    var button: ButtonView
    
    init(alertAction: AlertAction, dismiss: @escaping () -> Void) {
        self.id = alertAction.id
        self.title = alertAction.title
        self.button = alertAction.button(defaultAction: {
            alertAction.action()
            dismiss()
        })
    }
}

enum AlertAction {
    case ok
    case cancel
    case custom(title: String, action: () -> Void)
    
    var id: UUID { UUID() }
    var title: String {
        switch self {
        case .ok:
            return "OK"
        case .cancel:
            return "Cancel"
        case .custom(let title, _):
            return title
        }
    }
    var action: () -> Void {
        switch self {
        case .ok:
            return {}
        case .cancel:
            return {}
        case .custom(_, let action):
            return action
        }
    }
    func button(defaultAction: @escaping () -> Void) -> ButtonView {
        switch self {
        case .ok:
            return ButtonView(
                backgroundColor: .white,
                foregroundColor: .black,
                text: title,
                action: {
                    defaultAction()
                },
                cornerRadius: 8,
                size: .small
            )
        case .cancel:
            return ButtonView(
                backgroundColor: .white,
                foregroundColor: .black,
                text: title,
                action: {
                    defaultAction()
                },
                cornerRadius: 8,
                size: .small
            )
        case .custom(let title, let action):
            return ButtonView(
                backgroundColor: .white,
                foregroundColor: .black,
                text: title,
                action: {
                    action()
                    defaultAction()
                },
                cornerRadius: 8,
                size: .small
            )
        }
    }
}
