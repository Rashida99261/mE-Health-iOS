
import ComposableArchitecture
import Foundation

struct PatientFeature: Reducer {
    
    struct State: Equatable {
        var patientData: Patient?
        var isLoading: Bool = false
        var errorMessage = ""

    }

    enum Action: Equatable {
        case onAppear
        case patientResponse(Result<Patient, FHIRAPIError>)
    }
    
    @Dependency(\.fhirClient) var fhirClient

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                
            case .onAppear:
                state.isLoading = true
                return .run { send in
                    do {
                        let result = try await fhirClient.fetchPatient()
                        await send(.patientResponse(.success(result)))
                    } catch {
                        await send(.patientResponse(.failure(error as? FHIRAPIError ?? .invalidResponse)))
                    }
                }

            case let .patientResponse(.success(patient)):
                state.isLoading = false
                state.patientData = patient
                if let ref = patient.generalPractitioner?.first?.reference {
                    UserDefaults.standard.set(ref, forKey: "practitionerId")
                }
                return .none

            case .patientResponse(.failure):
                state.isLoading = false
                state.errorMessage = "No Data found"
                return .none

            }
        }
    }
}

