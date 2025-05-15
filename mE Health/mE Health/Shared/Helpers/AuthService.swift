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

        // Manual configuration — because Epic doesn't support OpenID Discovery
        let authorizationEndpoint = URL(string: "https://fhir.epic.com/interconnect-fhir-oauth/oauth2/authorize")!
        let tokenEndpoint = URL(string: "https://fhir.epic.com/interconnect-fhir-oauth/oauth2/token")!
        let configuration = OIDServiceConfiguration(
            authorizationEndpoint: authorizationEndpoint,
            tokenEndpoint: tokenEndpoint
        )
        let redirectURI = URL(string: "https://fhir.epic.com/test/smart")!
        let request = OIDAuthorizationRequest(
            configuration: configuration,
            clientId: "d45049c3-3441-40ef-ab4d-b9cd86a17225",
            scopes: ["openid"],
            redirectURL: redirectURI,
            responseType: OIDResponseTypeCode,
            additionalParameters: nil
        )

        guard let rootVC = UIApplication.shared.connectedScenes
            .compactMap({ ($0 as? UIWindowScene)?.keyWindow?.rootViewController }).first else {
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
