//
//  ConditionFeature.swift
//  mE Health
//
//  Created by Rashida on 23/05/25.
//

import ComposableArchitecture
import Foundation

struct ConditionFeature: Reducer {
    struct State: Equatable {
        var conditionModel: ConditionModel?
        var isLoading: Bool = false
        var errorMessage: String?
    }

    enum Action: Equatable {
        case loadCondition
        case getConditionResponse(Result<ConditionModel, FHIRAPIError>)

    }

    @Dependency(\.fhirClient) var fhirClient

    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {

        case .loadCondition:
            
            state.isLoading = true
            state.errorMessage = nil

            return .run { send in
                do {
                    let conditionModel = try await fhirClient.getConditions()
                    await send(.getConditionResponse(.success(conditionModel)))

                } catch {
                    await send(.getConditionResponse(.failure(error as? FHIRAPIError ?? .invalidResponse)))
                }
            }

        case let .getConditionResponse(.success(condition)):
            state.conditionModel = condition
            state.isLoading = false
            return .none

        case let .getConditionResponse(.failure(error)):
            state.isLoading = false
            state.errorMessage = "Failed to load providers: \(error.localizedDescription)"
            return .none

        }
    }
}
