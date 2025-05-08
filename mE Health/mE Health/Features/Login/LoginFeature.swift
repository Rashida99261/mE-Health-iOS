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
        case loginResponse(Result<Bool, Never>)
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
            let isValidEmail = NSPredicate(
                format: "SELF MATCHES %@",
                "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            ).evaluate(with: state.email)

            guard isValidEmail, state.password.count >= 8 else {
                return .none // don't show alert
            }

            state.isLoading = true

            return .run { send in
                try await Task.sleep(nanoseconds: 1_000_000_000)
                await send(.loginResponse(.success(true)))
            }

        case .loginResponse:
            state.isLoading = false
            state.showErrorAlert = true
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
