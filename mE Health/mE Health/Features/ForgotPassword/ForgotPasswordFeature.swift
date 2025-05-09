//
//  ForgotFeature.swift
//  mE Health
//
//  Created by Rashida on 8/05/25.
//

import ComposableArchitecture
import Foundation

struct ForgotPasswordFeature: Reducer {
    struct State: Equatable {
        var email: String = ""
        var showValidationErrors: Bool = false
        var isLoading: Bool = false
        var alertMessage: String?
        var showAlert: Bool = false
        var navigateBackToLogin: Bool = false
    }
    

    enum Action: Equatable {
        case emailChanged(String)
        case sendTapped
        case showAlert(String)
        case dismissAlert
        case navigateBackToLoginTapped
    }

    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case let .emailChanged(email):
            state.email = email
            state.showValidationErrors = false
            return .none

        case .sendTapped:
            state.showValidationErrors = true
            guard isValidEmail(state.email) else {
                return .none
            }
            state.isLoading = true
            // Simulate API call delay
            return .run { send in
                try await Task.sleep(nanoseconds: 1_000_000_000)
                await send(.showAlert("Password reset link sent."))
            }

        case let .showAlert(message):
            state.isLoading = false
            state.alertMessage = message
            state.showAlert = true
            return .none

        case .dismissAlert:
            state.showAlert = false
            return .none

        case .navigateBackToLoginTapped:
            return .none
        }
    }

    private func isValidEmail(_ input: String) -> Bool {
        let trimmed = input.trimmingCharacters(in: .whitespacesAndNewlines)
        return NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}")
            .evaluate(with: trimmed)
    }
}
