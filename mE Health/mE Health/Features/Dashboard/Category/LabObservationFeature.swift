//
//  LabObservationFeature.swift
//  mE Health
//
//  Created by Rashida on 23/05/25.
//


import ComposableArchitecture
import Foundation

struct LabObservationFeature: Reducer {
    
    struct State: Equatable {
        var labModel: ObservationModel?
        var isLoading: Bool = false
        var errorMessage: String?
    }

    enum Action: Equatable {
        case loadLabObservation
        case getLabObservationResponse(Result<ObservationModel, FHIRAPIError>)

    }

    @Dependency(\.fhirClient) var fhirClient

    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {

        case .loadLabObservation:
            
            state.isLoading = true
            state.errorMessage = nil

            return .run { send in
                do {
                    let conditionModel = try await fhirClient.getLabObservations()
                    await send(.getLabObservationResponse(.success(conditionModel)))

                } catch {
                    await send(.getLabObservationResponse(.failure(error as? FHIRAPIError ?? .invalidResponse)))
                }
            }

        case let .getLabObservationResponse(.success(condition)):
            state.labModel = condition
            state.isLoading = false
            return .none

        case let .getLabObservationResponse(.failure(error)):
            state.isLoading = false
            state.errorMessage = "Failed to load providers: \(error.localizedDescription)"
            return .none

        }
    }
}


struct VitalsObservationFeature: Reducer {
    struct State: Equatable {
        var vitalModel: ObservationModel?
        var isLoading: Bool = false
        var errorMessage: String?
    }

    enum Action: Equatable {
        case loadVitalbservation
        case getVitalObservationResponse(Result<ObservationModel, FHIRAPIError>)

    }

    @Dependency(\.fhirClient) var fhirClient

    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {

        case .loadVitalbservation:
            
            state.isLoading = true
            state.errorMessage = nil

            return .run { send in
                do {
                    let conditionModel = try await fhirClient.getVitalObservations()
                    await send(.getVitalObservationResponse(.success(conditionModel)))

                } catch {
                    await send(.getVitalObservationResponse(.failure(error as? FHIRAPIError ?? .invalidResponse)))
                }
            }

        case let .getVitalObservationResponse(.success(condition)):
            state.vitalModel = condition
            state.isLoading = false
            return .none

        case let .getVitalObservationResponse(.failure(error)):
            state.isLoading = false
            state.errorMessage = "Failed to load providers: \(error.localizedDescription)"
            return .none

        }
    }
}
