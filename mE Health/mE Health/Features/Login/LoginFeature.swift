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
        var authError: String?
        var isLoggedIn = false
        var dashboardState: DashboardFeature.State? = nil

    }
    
    @Dependency(\.loginClient) var loginClient
    @Dependency(\.authService) var authService
    
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
        case oauthResponse(Result<URL, AuthError>)
        case tokenExchangeResponse(Result<TokenExchangeResult, AuthError>)
        case dismissDashboardView
        case dashboardState(DashboardFeature.Action)
        case onAppear


    }

    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
            
        case .onAppear:
            print("on appear")
            return .none
            

        case .emailChanged(let email):
            print("Email changed to:", email)
            state.email = email
            state.showValidationErrors = false
            return .none

        case .passwordChanged(let password):
            print("password changed to:", password)
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
           
            return .run { send in
                            do {
                                let callbackURL = try await authService.startOAuthFlow()
                                await send(.oauthResponse(.success(callbackURL)))
                            } catch {
                                let authError = error as? AuthError ?? .unknown
                                await send(.oauthResponse(.failure(authError)))
                            }
                        }
            
        case let .oauthResponse(result):
            state.isLoading = false
            switch result {
            case let .success(url):
                print("✅ Callback URL: \(url)")
                guard let code = extractCode(from: url) else {
                    return .send(.tokenExchangeResponse(.failure(.authFailed)))
                }
                return .run { send in
                    do {
                        let (token, patientID,expiresIn) = try await authService.exchangeCodeForToken(code)
                        await send(.tokenExchangeResponse(.success(TokenExchangeResult(accessToken: token, patientID: patientID, expiresIn: expiresIn))))
                    } catch {
                        await send(.tokenExchangeResponse(.failure(error as? AuthError ?? .unknown)))
                    }
                }
            case let .failure(error):
                state.authError = error.localizedDescription
            }
            return .none

            
        case let .loginResponse(.failure(error)):
            state.isLoading = false
            SessionManager.shared.saveLoginSession()
//            state.showErrorAlert = false
//            state.errorMessage = "Login failed: \(error.localizedDescription)"
            return .run { send in
                            do {
                                let callbackURL = try await authService.startOAuthFlow()
                                await send(.oauthResponse(.success(callbackURL)))
                            } catch {
                                let authError = error as? AuthError ?? .unknown
                                await send(.oauthResponse(.failure(authError)))
                            }
                        }

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
            
        case .tokenExchangeResponse(.success(let tokenResult)):
            state.isLoading = false
            UserDefaults.standard.set(tokenResult.patientID, forKey: "patientId")
            state.isLoggedIn = true
            
            let expiresIn = tokenResult.expiresIn
            let expiryDate = Date().addingTimeInterval(TimeInterval(expiresIn - 60))
            UserDefaults.standard.set(expiryDate, forKey: "tokenExpiryDate")
            _ = TokenManager.saveAccessToken(tokenResult.accessToken)
            
            let loginTimestamp = Date()
            UserDefaults.standard.set(loginTimestamp, forKey: "loginTimestamp")
           
            state.dashboardState = DashboardFeature.State()
            state.navigateToDashboard = true
            return .none
            

        case .tokenExchangeResponse(.failure(let error)):
            state.isLoading = false
            state.errorMessage = error.localizedDescription
            return .none

           
        case .dismissDashboardView:
            state.navigateToDashboard = false
            state.dashboardState = nil
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
        case .dashboardState(let dashboardAction):
            // Forward dashboard actions to the dashboard reducer
            guard var dashboardState = state.dashboardState else { return .none }
            let effect = DashboardFeature().reduce(into: &dashboardState, action: dashboardAction)
            state.dashboardState = dashboardState
            return effect.map(Action.dashboardState)

        }
    }
    
    private func extractCode(from url: URL) -> String? {
            URLComponents(url: url, resolvingAgainstBaseURL: false)?
                .queryItems?
                .first(where: { $0.name == "code" })?
                .value
    }
    
    var body: some ReducerOf<Self> {
        Reduce(self.reduce)
            .ifLet(\.forgotPasswordState, action: /Action.forgotPassword) {
                ForgotPasswordFeature()
            }
        
            .ifLet(\.alreadyUserState, action: /Action.alreadyUserState) {
                AlreadyMeUserFeature()
            }
            .ifLet(\.dashboardState, action: /Action.dashboardState) {
                DashboardFeature()
            }
    }

}

