//
//  FhirAuthFeature.swift
//  mE Health
//
//  Created by Rashida on 29/05/25.
//

import ComposableArchitecture
import Foundation

struct FhirAuthFeature: Reducer {
    struct State: Equatable {
        var isLoading = false
        var error: String?
    }

    enum Action: Equatable {
        case onAppear
        case attemptSilentLogin
        case fhirLoginSucceeded
        case fhirLoginFailed(String)
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .send(.attemptSilentLogin)

            case .attemptSilentLogin:
                state.isLoading = true
                return .run { send in
                    let token = await TokenManager.getValidAccessToken()
                    if token != nil {
                        await send(.fhirLoginSucceeded)
                    } else {
                        await send(.fhirLoginFailed("Token refresh failed"))
                    }
                }

            case .fhirLoginSucceeded:
                state.isLoading = false
                return .none

            case .fhirLoginFailed(let error):
                state.error = error
                state.isLoading = false
                return .none
            }
        }
    }
}
