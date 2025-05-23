import ComposableArchitecture
import Foundation


// MARK: - Category Enum

public enum HealthCategory: String, CaseIterable, Identifiable, Equatable {
    case providers = "Providers"
    case conditions = "Conditions"
    case medications = "Medications"
    case labs = "Labs"
    case vitals = "Vitals"
    case uploads = "Uploads"
    case consents = "Consents"

    public var id: String { rawValue }
}


struct DashboardFeature: Reducer {
    struct State: Equatable {
        var selectedCategory: HealthCategory?
        var patient: Patient?
        var isLoading: Bool = false

    }

    enum Action: Equatable {
        case onAppear
        case patientResponse(Result<Patient, FHIRAPIError>)
        case categoryTapped(HealthCategory)
        case categoryDetailDismissed
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
                state.patient = patient
                if let ref = patient.generalPractitioner?.first?.reference {
                    UserDefaults.standard.set(ref, forKey: "practitionerId")
                }
                return .none

            case .patientResponse(.failure):
                state.isLoading = false
                // Handle error
                return .none

            case .categoryTapped(let category):
                print("Tapped: \(category)") // See if this prints!

                state.selectedCategory = category
                return .none

            case .categoryDetailDismissed:
                state.selectedCategory = nil
                return .none
            }
        }
    }
}


