//
//  ConsentFeature.swift
//  mE Health
//
//  Created by Rashida on 23/05/25.
//

import ComposableArchitecture
import Foundation

struct ConsentFeature: Reducer {
    
    struct State: Equatable {
        var consentModel: ConsentModel?
        var isLoading: Bool = false
        var errorMessage: String?
    }

    enum Action: Equatable {
        case loadConsent
        case getLabObservationResponse(Result<ConsentModel, FHIRAPIError>)

    }

    @Dependency(\.fhirClient) var fhirClient
    @Dependency(\.coreDataClient) var coreDataClient
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {

        case .loadConsent:
            
            state.isLoading = true
            state.errorMessage = nil

            return .run { send in
                do {
                    let conditionModel = try await fhirClient.getConsents()
                    await send(.getLabObservationResponse(.success(conditionModel)))

                } catch {
                    await send(.getLabObservationResponse(.failure(error as? FHIRAPIError ?? .invalidResponse)))
                }
            }

        case let .getLabObservationResponse(.success(consent)):
            state.consentModel = consent
            state.isLoading = false
            do {
                try coreDataClient.saveConsentModel(consent)
            } catch {
                print("❌ Failed to save Consent to Core Data: \(error)")
            }
            return .none

        case let .getLabObservationResponse(.failure(error)):
            state.isLoading = false
            state.errorMessage = "Failed to load providers: \(error.localizedDescription)"
            return .none

        }
    }
}
