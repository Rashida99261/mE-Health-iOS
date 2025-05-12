//
//  LoginClient.swift
//  mE Health
//
//  Created by Rashida on 12/05/25.
//

import Foundation
import ComposableArchitecture

struct LoginRequest: Encodable {
    let email: String
    let password: String
    let firebase_token: String
    let user_type: String
}

struct LoginResponse: Decodable , Equatable {
    let message: String
    let status: Bool
}

protocol LoginClient {
    func login(_ request: LoginRequest) async throws -> LoginResponse
}

struct ApiLoginClient: LoginClient {
    func login(_ request: LoginRequest) async throws -> LoginResponse {
        var urlRequest = URLRequest(url: URL(string: "https://dev-admin.meinstein.ai/user/login/")!)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = try JSONEncoder().encode(request)

        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }

        return try JSONDecoder().decode(LoginResponse.self, from: data)
    }
}

struct LoginClientDependency {
    var login: (_ request: LoginRequest) async throws -> LoginResponse
}

enum LoginClientKey: DependencyKey {
    static let liveValue: LoginClientDependency = LoginClientDependency(
        login: { request in
            try await ApiLoginClient().login(request)
        }
    )
}

extension DependencyValues {
    var loginClient: LoginClientDependency {
        get { self[LoginClientKey.self] }
        set { self[LoginClientKey.self] = newValue }
    }
}


struct AppEnvironment {
    var loginClient: LoginClient
}
