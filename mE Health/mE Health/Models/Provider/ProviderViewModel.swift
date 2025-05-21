//
//  Untitled.swift
//  mE Health
//
//  Created by Rashida on 21/05/25.
//


class ProviderViewModel: ObservableObject {
    @Published var providers: [Provider] = []
    @Published var errorMessage: String?

    private var apiService: FHIRAPIService

    init(accessToken: String) {
        self.apiService = FHIRAPIService(accessToken: accessToken)
    }

    func loadProviders() {
        apiService.fetchProviders { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    // Decode `Provider` from data here
                    // self.providers = ...
                    break
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}

struct Provider: Codable, Identifiable {
    let id: String
    let name: String
    // Add other FHIR Practitioner fields you need
}
