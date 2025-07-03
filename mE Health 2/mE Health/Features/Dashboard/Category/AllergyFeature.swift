import ComposableArchitecture
import Foundation

struct AllergyFeature: Reducer {
    struct State: Equatable {
        var allergyModel: AllergyResource?
        var isLoading: Bool = false
        var errorMessage: String?
    }

    enum Action: Equatable {
        case loadAllergy
        case getAllergyData(Result<AllergyModel, FHIRAPIError>)
        case getAllergyDetail(Result<AllergyResource, FHIRAPIError>)
        
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

        case let .getAllergyData(.success(model)):
            let resource = model.entry?.first?.resource
            let id = resource?.id ?? ""
            return .run { send in
                do {
                    let allergyModel = try await fhirClient.getAllergyDetail(id)
                    await send(.getAllergyDetail(.success(allergyModel)))
                } catch {
                    await send(.getAllergyDetail(.failure(error as? FHIRAPIError ?? .invalidResponse)))
                }
            }

        case let .getAllergyData(.failure(error)):
            state.isLoading = false
            state.errorMessage = "Failed to load providers: \(error.localizedDescription)"
            return .none
            
        case let .getAllergyDetail(.success(model)):
            state.isLoading = false
            state.errorMessage = nil
            state.allergyModel = model
            return .none

        case let .getAllergyDetail(.failure(error)):
            state.isLoading = false
            state.errorMessage = "Failed to load providers: \(error.localizedDescription)"
            return .none


        }
    }
}
