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
        var forgotPasswordState: ForgotPasswordFeature.State? = nil
        var alreadyUserState: AlreadyMeUserFeature.State? = nil
        var navigateToDashboard = false

    }
    
    @Dependency(\.loginClient) var loginClient
    
    enum Action: Equatable {
        case emailChanged(String)
        case passwordChanged(String)
        case togglePasswordVisibility
        case loginTapped
        case navigateToRegisterTapped
        case navigateToAlreadyAUserTapped
        case dismissErrorAlert
        case setValidationErrorsVisible(Bool)
        case loginResponse(TaskResult<LoginResponse>)
        case forgotPasswordTapped
        case dismissForgotPassword
        case forgotPassword(ForgotPasswordFeature.Action)
        case alreadyUserState(AlreadyMeUserFeature.Action)

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
            let request = LoginRequest(email: state.email, password: state.password, firebase_token: "", user_type: "seller")
            return .run { send in
                do {
                        let response = try await loginClient.login(request)
                        await send(.loginResponse(.success(response)))
                    } catch {
                        await send(.loginResponse(.failure(error)))
                    }
            }

        case let .loginResponse(.success(response)):
            state.isLoading = false
            if response.status {
                state.navigateToDashboard = true
            } else {
                state.showErrorAlert = true
                state.errorMessage = response.message
            }
            return .none
            
        case let .loginResponse(.failure(error)):
            state.isLoading = false
            state.showErrorAlert = true
            state.errorMessage = "Login failed: \(error.localizedDescription)"
            return .none

        case .forgotPasswordTapped:
            state.showForgotPassword = true
            state.forgotPasswordState = ForgotPasswordFeature.State()
            return .none

        case .dismissForgotPassword:
            state.showForgotPassword = false
            return .none

        case .navigateToRegisterTapped:
            state.navigateToRegister = true
            return .none

        case .navigateToAlreadyAUserTapped:
            state.navigateToAlreadyAUser = true
            state.alreadyUserState = AlreadyMeUserFeature.State()
            return .none

        case .dismissErrorAlert:
            state.showErrorAlert = false
            return .none
            
        case .setValidationErrorsVisible(let isVisible):
            state.showValidationErrors = isVisible
            return .none
            
        case .forgotPassword(.navigateBackToLoginTapped):
            state.showForgotPassword = false
            state.forgotPasswordState = nil
            return .none
            
        case .alreadyUserState(.navigateBackToLoginTapped):
            state.navigateToAlreadyAUser = false
            state.alreadyUserState = nil
            return .none
            
        case .forgotPassword(.emailChanged(_)):
            return .none
        case .forgotPassword(.sendTapped):
            return .none
        case .forgotPassword(.showAlert(_)):
            return .none
        case .forgotPassword(.dismissAlert):
            return .none
        case .alreadyUserState(.emailChanged(_)):
            return .none
        case .alreadyUserState(.sendTapped):
            return .none
        case .alreadyUserState(.showAlert(_)):
            return .none
        case .alreadyUserState(.dismissAlert):
            return .none
        }
    }
    
    var body: some ReducerOf<Self> {
        Reduce(self.reduce)
            .ifLet(\.forgotPasswordState, action: /Action.forgotPassword) {
                ForgotPasswordFeature()
            }
        
            .ifLet(\.alreadyUserState, action: /Action.alreadyUserState) {
                AlreadyMeUserFeature()
            }
    }

}
