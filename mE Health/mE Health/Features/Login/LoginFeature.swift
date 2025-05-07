//
//  LoginFeature.swift
//  mE Health
//
//  Created by Rashida on 7/05/25.
//

import ComposableArchitecture
import Foundation

struct LoginFeature: Reducer {
    struct State: Equatable {
        var email = ""
        var password = ""
        var isPasswordVisible = false
        var showValidationErrors = false
        var showErrorAlert = false
        var errorMessage = ""
        var navigateToRegister = false
        var navigateToAlreadyAUser = false
        var isLoading = false
        var showForgotPassword = false

    }

    enum Action: Equatable {
        case emailChanged(String)
        case passwordChanged(String)
        case togglePasswordVisibility
        case loginTapped
        case forgotPasswordTapped
        case navigateToRegisterTapped
        case navigateToAlreadyAUserTapped
        case dismissErrorAlert
        case setValidationErrorsVisible(Bool)
    }

    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .emailChanged(let email):
            state.email = email
            state.showValidationErrors = false
            return .none

        case .passwordChanged(let password):
            state.password = password
            state.showValidationErrors = false
            return .none

        case .togglePasswordVisibility:
            state.isPasswordVisible.toggle()
            return .none

        case .loginTapped:
            state.showValidationErrors = true
            let isValidEmail = NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}")
                .evaluate(with: state.email)
            if state.email.isEmpty || state.password.isEmpty || !isValidEmail || state.password.count < 8 {
                state.errorMessage = "Invalid credentials"
                state.showErrorAlert = true
            } else {
                state.isLoading = true
                // Simulate API call or use Effect here
            }
            return .none

        case .forgotPasswordTapped:
            state.showForgotPassword = true
            return .none

        case .navigateToRegisterTapped:
            state.navigateToRegister = true
            return .none

        case .navigateToAlreadyAUserTapped:
            state.navigateToAlreadyAUser = true
            return .none

        case .dismissErrorAlert:
            state.showErrorAlert = false
            return .none
            
        case .setValidationErrorsVisible(let isVisible):
            state.showValidationErrors = isVisible
            return .none

        }
    }
}
