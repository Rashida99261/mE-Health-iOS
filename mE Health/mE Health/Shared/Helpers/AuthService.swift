//
//  AuthService.swift
//  mE Health
//
//  Created by Rashida on 14/05/25.
//

import Foundation
import AppAuth
import AuthenticationServices
import ComposableArchitecture
import Dependencies

protocol AuthClient {
    func authorize()
    func resume(_ url: URL) -> Bool
}


final class AuthService: NSObject, ObservableObject, AuthClient {
    @Published var authState: OIDAuthState?

    private var currentAuthorizationFlow: OIDExternalUserAgentSession?

    func authorize() {
        guard let issuer = URL(string: "https://fhir.epic.com/interconnect-fhir-oauth/oauth2") else { return }
        guard let redirectURI = URL(string: "http://localhost:3000/callback") else { return }
        
        

        // Discover endpoints
        OIDAuthorizationService.discoverConfiguration(forIssuer: issuer) { config, error in
            guard let config = config else {
                print("Discovery error: \(error?.localizedDescription ?? "Unknown")")
                return
            }

            let request = OIDAuthorizationRequest(
                configuration: config,
                clientId: "e3073934-68c1-4ca7-9b59-3d8b934187f1",
                clientSecret: nil,
                scopes: [OIDScopeOpenID, OIDScopeProfile, "email"],
                redirectURL: redirectURI,
                responseType: OIDResponseTypeCode,
                additionalParameters: nil
            )

            guard let rootVC = UIApplication.shared.windows.first?.rootViewController else {
                print("Root VC not found")
                return
            }

            self.currentAuthorizationFlow = OIDAuthState.authState(
                byPresenting: request,
                presenting: rootVC
            ) { authState, error in
                if let authState = authState {
                    self.authState = authState
                    print("Got authorization tokens: \(authState.lastTokenResponse?.accessToken ?? "None")")
                } else {
                    print("Authorization error: \(error?.localizedDescription ?? "Unknown")")
                }
            }
        }
    }

    // Handle incoming redirect
    func resume(_ url: URL) -> Bool {
        if let flow = currentAuthorizationFlow, flow.resumeExternalUserAgentFlow(with: url) {
            currentAuthorizationFlow = nil
            return true
        }
        return false
    }
}


enum AuthClientKey: DependencyKey {
    static let liveValue: AuthClient = AuthService()
}

extension DependencyValues {
    var authService: AuthClient {
        get { self[AuthClientKey.self] }
        set { self[AuthClientKey.self] = newValue }
    }
}
