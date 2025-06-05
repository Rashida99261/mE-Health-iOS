//
//  PracticesClient.swift
//  mE Health
//

import Foundation
import ComposableArchitecture



protocol PracticesClient {
    func getStateList() async throws -> StateModel
    func getPracticeList() async throws -> PracticesModel
}
struct ApiPracticeClient: PracticesClient {
    func getStateList() async throws -> StateModel {
        let url = Constants.API.appBaseUrl + "/api/health/practices/stats/"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.setValue("Token ab312ddf93afc76fc5f6f45d351c4d2ae1d84cea", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }
        return try JSONDecoder().decode(StateModel.self, from: data)
    }
    
    func getPracticeList() async throws -> PracticesModel {
        let url = Constants.API.appBaseUrl + "/api/health/practices/"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.setValue("Token ab312ddf93afc76fc5f6f45d351c4d2ae1d84cea", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }
        return try JSONDecoder().decode(PracticesModel.self, from: data)

    }
}

struct PracticesClientDependency {
    var getStateList:() async throws -> StateModel
    var getPracticeList:() async throws -> PracticesModel
}

enum PracticesClientKey: DependencyKey {
    static let liveValue: PracticesClientDependency = PracticesClientDependency(
        getStateList: {
            try await ApiPracticeClient().getStateList()
        }, getPracticeList: {
            try await ApiPracticeClient().getPracticeList()
        }
    )
}

extension DependencyValues {
    var practicesClient: PracticesClientDependency {
        get { self[PracticesClientKey.self] }
        set { self[PracticesClientKey.self] = newValue }
    }
}
