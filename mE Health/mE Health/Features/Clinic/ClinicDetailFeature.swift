//
//  ClinicDetailFeature.swift
//  mE Health
//

import ComposableArchitecture
import Foundation



struct ClinicDetailFeature: Reducer {
    struct State: Equatable {
        var isLoading: Bool = false
        var showErrorAlert = false
        var errorMessage = ""
        var isConnected: Bool = false
        var practicesData : [PracticesModelData]?
    }

    enum Action: Equatable {
        case onDetailAppear
        case onTapConnect
        case tokenValidated(String)
        case tokenValidationFailed
        case reauthCompleted(Result<String, AuthError>)
        case authFailed(String)
        case fetchDashboardData
        case getPracticesSuccessResponse(PracticesModel)
        case getPracticesFailureResponse(String)

    }
    
    @Dependency(\.fhirClient) var fhirClient
    @Dependency(\.practicesClient) var practiceClient


    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                
            case .onDetailAppear:
                state.isLoading = true
                return .run { send in
                    do {
                        let practices = try await practiceClient.getPracticeList()
                        await send(.getPracticesSuccessResponse(practices))
                    } catch {
                        await send(.getPracticesFailureResponse(error.localizedDescription))
                    }
                }
                
            case .getPracticesFailureResponse(let message):
                state.isLoading = false
                state.errorMessage = message
                // Handle error
                return .none
                
            case let .getPracticesSuccessResponse(model):
                state.isLoading = false
                state.practicesData = model.data ?? []
                return .none

                
            case .onTapConnect:
                state.isLoading = true
                return .run { send in
                    do {
                            let token = try await AuthService.shared.getValidAccessToken()
                            _ = TokenManager.saveAccessToken(token)
                            await send(.tokenValidated(token))
                        } catch {
                            await send(.tokenValidationFailed)
                        }
                }
                
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
                state.isConnected = false
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
                state.isConnected = true
                return .none
                
                        
            }
        }
    }
}


