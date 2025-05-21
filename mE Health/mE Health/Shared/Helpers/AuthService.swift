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
import CryptoKit
import Combine

enum AuthError: Error, LocalizedError, Equatable {
    case authFailed
    case tokenExchangeFailed
    case unknown

    var errorDescription: String? {
        switch self {
        case .authFailed: return "Authentication failed"
        case .tokenExchangeFailed: return "Token exchange failed"
        case .unknown: return "Unknown error"
        }
    }
}

final class AuthService: NSObject, ASWebAuthenticationPresentationContextProviding {
    static let shared = AuthService()
    let clientID = "58e04c49-b139-485c-8832-2b057c594329"
    let redirectURI = "smartFhirAuthApp://callback"
    let tokenEndpoint = "https://fhir.epic.com/interconnect-fhir-oauth/oauth2/token"
    let aud = "https://fhir.epic.com/interconnect-fhir-oauth/api/FHIR/R4"
    private var codeVerifier = ""

    func startOAuthFlow() async throws -> URL {
        let (verifier, challenge) = self.generateCodeVerifierAndChallenge()
        self.codeVerifier = verifier
        let authURL = URL(string: "https://fhir.epic.com/interconnect-fhir-oauth/oauth2/authorize?client_id=\(clientID)&response_type=code&redirect_uri=\(redirectURI)&scope=openid&code_challenge=\(challenge)&code_challenge_method=S256")!
        let callbackScheme = "smartFhirAuthApp" // Your registered scheme

        return try await withCheckedThrowingContinuation { continuation in
            let session = ASWebAuthenticationSession(url: authURL, callbackURLScheme: callbackScheme) { callbackURL, error in
                if let url = callbackURL {
                    continuation.resume(returning: url)
                } else {
                    continuation.resume(throwing: error ?? URLError(.badServerResponse))
                }
            }
            session.presentationContextProvider = self
            session.prefersEphemeralWebBrowserSession = true
            session.start()
        }

    }

    func extractCode(from url: URL) -> String? {
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        return components?.queryItems?.first(where: { $0.name == "code" })?.value
    }

    func exchangeCodeForToken(code: String) async throws -> (String, String) {

        var request = URLRequest(url: URL(string: tokenEndpoint)!)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        let bodyParams = [
            "grant_type": "authorization_code",
            "code": code,
            "redirect_uri": redirectURI,
            "client_id": clientID,
            "code_verifier": self.codeVerifier
        ]

       // request.httpBody = bodyParams.percentEncoded()

        request.httpBody = bodyParams
            .map { key, value in "\(key)=\(value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")" }
            .joined(separator: "&")
            .data(using: .utf8)


        let (data, _) = try await URLSession.shared.data(for: request)

        guard
            let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
            let accessToken = json["access_token"] as? String,
            let patientID = json["patient"] as? String
        else {
            throw AuthError.tokenExchangeFailed
        }

        return (accessToken, patientID)
    }

    private var cancellables = Set<AnyCancellable>()

    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return UIApplication.shared.windows.first ?? UIWindow()
    }

    private func generateCodeVerifierAndChallenge() -> (String, String) {
        let verifier = randomString(length: 64)
        let data = verifier.data(using: .utf8)!
        let hash = SHA256.hash(data: data)
        let challenge = base64URLEncode(data: Data(hash))
        return (verifier, challenge)
    }

    private func randomString(length: Int) -> String {
        let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-._~"
        return String((0..<length).compactMap { _ in characters.randomElement() })
    }

    private func base64URLEncode(data: Data) -> String {
        return data.base64EncodedString()
            .replacingOccurrences(of: "+", with: "-")
            .replacingOccurrences(of: "/", with: "_")
            .replacingOccurrences(of: "=", with: "")
    }
}




extension Dictionary where Key == String, Value == String {
    func percentEncoded() -> Data? {
        let parameterArray = self.map { key, value in
            let escapedKey = key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            let escapedValue = value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            return "\(escapedKey)=\(escapedValue)"
        }
        let joinedParams = parameterArray.joined(separator: "&")
        return joinedParams.data(using: .utf8)
    }
}

struct AuthServiceClient {
    var startOAuthFlow: @Sendable () async throws -> URL
    var exchangeCodeForToken: @Sendable (_ code: String) async throws -> (String, String)
}

private enum AuthServiceKey: DependencyKey {
    static let liveValue: AuthServiceClient = AuthServiceClient(
        startOAuthFlow: {
            try await AuthService.shared.startOAuthFlow()
        },
        exchangeCodeForToken: { code in try await AuthService.shared.exchangeCodeForToken(code: code) }
    )
}

extension DependencyValues {
    var authService: AuthServiceClient {
        get { self[AuthServiceKey.self] }
        set { self[AuthServiceKey.self] = newValue }
    }
}


struct TokenExchangeResult: Equatable {
    let accessToken: String
    let patientID: String
}
