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
        var showErrorAlert = false
        var errorMessage = ""
    }

    enum Action: Equatable {
        case onAppear
        case patientResponse(Result<Patient, FHIRAPIError>)
        case categoryTapped(HealthCategory)
        case categoryDetailDismissed
        case alertDismissed
        case logoutTapped
        case tokenValidated(String) // token
        case tokenValidationFailed
        case fetchDashboardData



    }
    
    @Dependency(\.fhirClient) var fhirClient
    @Dependency(\.coreDataClient) var coreDataClient


    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                
            case .onAppear:
                state.isLoading = true
                return .run { send in
                    if let token = TokenManager.getValidAccessToken() {
                         await send(.tokenValidated(token))
                    } else {
                        await send(.tokenValidationFailed)
                    }
                }
                
            case let .tokenValidated(token):
                print("🔐 Token ready: \(token)")
                TokenManager.deleteAccessToken()
                _ = TokenManager.saveAccessToken(token)
                return .send(.fetchDashboardData)

            case .tokenValidationFailed:
                print("❌ Token refresh failed")
                
                return .none

            case .fetchDashboardData:
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
                    print(ref)
                    UserDefaults.standard.set(ref, forKey: "practitionerId")
                }
                do {
                    try coreDataClient.savePatient(patient)
                    let name = (patient.name?.first?.given?.joined(separator: " ") ?? "") + " " + (patient.name?.first?.family ?? "")
                    let id = patient.id ?? "NA"
                    state.showErrorAlert = true
                    state.errorMessage = "Name: \(name)\nID: \(id)"
                } catch {
                    print("❌ Failed to save patient to Core Data: \(error)")
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
                

            case .alertDismissed:
                state.showErrorAlert = false
              return .none

            case .logoutTapped:
                return .none

            }
        }
    }
}


