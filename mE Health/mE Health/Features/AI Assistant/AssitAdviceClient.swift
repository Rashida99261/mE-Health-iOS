//
//  AssitAdviceClient.swift
//  mE Health
//
//  Created by Rashida on 4/07/25.
//


import Foundation
import ComposableArchitecture

struct AssistRequest: Encodable {
    let application: String
}

protocol AssitAdviceClient {
    func getAssistList(_ request: AssistRequest) async throws -> AssistResponse
}

struct ApiAssitAdviceClient: AssitAdviceClient {
    
    func getAssistList(_ request: AssistRequest) async throws -> AssistResponse {
        guard var components = URLComponents(string: Constants.API.assistGetApi) else {
            throw URLError(.badURL)
        }

        components.queryItems = [
            URLQueryItem(name: "application", value: request.application)
        ]

        guard let url = components.url else {
            throw URLError(.badURL)
        }

        var urlRequest = URLRequest(url: url)
        
        guard let token = MEUtility.getME_TOKEN() else {
            throw URLError(.userAuthenticationRequired)
        }

        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("Token \(token)", forHTTPHeaderField: "Authorization")


        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }

        return try JSONDecoder().decode(AssistResponse.self, from: data)
    }
}

struct AssitAdviceClientDependency {
    var getAssistList: (_ request: AssistRequest) async throws -> AssistResponse
}

enum AssitAdviceClientKey: DependencyKey {
    static let liveValue: AssitAdviceClientDependency = AssitAdviceClientDependency(
        getAssistList : { request in
            try await ApiAssitAdviceClient().getAssistList(request)
        }
    )
}

extension DependencyValues {
    var assitAdviceClient: AssitAdviceClientDependency {
        get { self[AssitAdviceClientKey.self] }
        set { self[AssitAdviceClientKey.self] = newValue }
    }
}
