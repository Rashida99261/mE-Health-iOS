import ComposableArchitecture
import Foundation

struct AllergyFeature: Reducer {
    struct State: Equatable {
        var allergyModel: AllergyModel?
        var isLoading: Bool = false
        var errorMessage: String?
    }

    enum Action: Equatable {
        case loadAllergy
        case getAllergyData(Result<AllergyModel, FHIRAPIError>)
        
    }

    @Dependency(\.fhirClient) var fhirClient
    @Dependency(\.coreDataClient) var coreDataClient

    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {

        case .loadAllergy:
            
            state.isLoading = true
            state.errorMessage = nil

            return .run { send in
                do {
                    let conditionModel = try await fhirClient.getAllergy()
                    await send(.getAllergyData(.success(conditionModel)))
                } catch {
                    await send(.getAllergyData(.failure(error as? FHIRAPIError ?? .invalidResponse)))
                }
            }

        case let .getAllergyData(.success(condition)):
            state.allergyModel = condition
            state.isLoading = false
//            do {
//                try coreDataClient.saveResourceTree(condition)
//            } catch {
//                print("❌ Failed to save MEdication to Core Data: \(error)")
//            }
            return .none

        case let .getAllergyData(.failure(error)):
            state.isLoading = false
            state.errorMessage = "Failed to load providers: \(error.localizedDescription)"
            return .none


        }
    }
}
