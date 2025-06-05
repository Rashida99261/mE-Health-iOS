//
//  ClinicFeature.swift
//  mE Health
//

import ComposableArchitecture
import Foundation

struct ClinicFeature: Reducer {
    struct State: Equatable {
        var stateData: [TopStates]?
        var isLoading: Bool = false
        var showErrorAlert = false
        var errorMessage = ""
       
    }

    enum Action: Equatable {
        case onAppear
        case getStateSuccessResponse(StateModel)
        case getStateFailureResponse(String)
        case fetchDataOnList
       

    }
    
    @Dependency(\.practicesClient) var practiceClient

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                
            case .onAppear:
                state.isLoading = true
                return .run { send in
                    do {
                        let states = try await practiceClient.getStateList()
                        await send(.getStateSuccessResponse(states))
                    } catch {
                        await send(.getStateFailureResponse(error.localizedDescription))
                    }
                }
                

                
            case .fetchDataOnList:
                state.isLoading = false
                return .none

            case .getStateFailureResponse(let message):
                state.isLoading = false
                state.errorMessage = message
                // Handle error
                return .none
                
            case let .getStateSuccessResponse(model):
                state.isLoading = false
                state.stateData = model.data?.top_states ?? []
                return .none



            }
        }
    }
}
