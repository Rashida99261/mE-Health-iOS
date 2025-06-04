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
        var selectedTab: DashboardTab = .menu
    }

    enum Action: Equatable {
        case onAppear
        case patientResponse(Result<Patient, FHIRAPIError>)
        case categoryTapped(HealthCategory)
        case categoryDetailDismissed
        case logoutTapped
        case tokenValidated(String)
        case tokenValidationFailed
        case fetchDashboardData
        case reauthCompleted(Result<String, AuthError>)
        case authFailed(String)
        case tabSelected(DashboardTab)
      



    }
    
    @Dependency(\.fhirClient) var fhirClient
    @Dependency(\.coreDataClient) var coreDataClient


    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                
            case .onAppear:
                state.isLoading = true
                return .send(.fetchDashboardData)
//                return .run { send in
//                    do {
//                            let token = try await AuthService.shared.getValidAccessToken()
//                            _ = TokenManager.saveAccessToken(token)
//                            await send(.tokenValidated(token))
//                        } catch {
//                            await send(.tokenValidationFailed)
//                        }
//                }
                
            case let .tokenValidated(token):
                print("🔐 Token ready: \(token)")
                return .send(.fetchDashboardData)

            case .tokenValidationFailed:
                print("❌ Token refresh failed")
                return .run { send in
                      do {
                          let callbackURL = try await AuthService.shared.startOAuthFlow()
                          guard let code = await AuthService.shared.extractCode(from: callbackURL) else {
                              await send(.authFailed("Failed to extract code"))
                              return
                          }
                          let (accessToken, patientID, expiresIn) = try await AuthService.shared.exchangeCodeForToken(code: code)
                          UserDefaults.standard.set(patientID, forKey: "patientId")
                          await AuthService.saveExpiryTimestamp(expiresIn)
                          await send(.tokenValidated(accessToken))
                      } catch {
                          await send(.authFailed(error.localizedDescription))
                      }
                  }
                
            case .authFailed(let error):
                state.showErrorAlert = true
                state.errorMessage = error
                return .none
                
            case .reauthCompleted(let result):
                switch result {
                case .success(let token):
                    _ = TokenManager.saveAccessToken(token)
                    return .send(.tokenValidated(token))
                case .failure(let error):
                    state.showErrorAlert = true
                    state.errorMessage = error.localizedDescription
                    return .none
                }

            case .fetchDashboardData:
                state.isLoading = false
                return .none
//                return .run { send in
//                    do {
//                        let result = try await fhirClient.fetchPatient()
//                        await send(.patientResponse(.success(result)))
//                    } catch {
//                        await send(.patientResponse(.failure(error as? FHIRAPIError ?? .invalidResponse)))
//                    }
//                }


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
                
            case .logoutTapped:
                return .none
                
            case .tabSelected(let tab):
                            state.selectedTab = tab
                            return .none
                        

            }
        }
    }
}


