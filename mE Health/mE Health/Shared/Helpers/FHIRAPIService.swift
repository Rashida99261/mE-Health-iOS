//
//  Untitled.swift
//  mE Health
//
//  Created by Rashida on 21/05/25.
//

import Foundation

class FHIRAPIService {
    
    private let baseURL = "https://fhir.epic.com/interconnect-fhir-oauth/api/FHIR/R4"
    private let accessToken: String
    
    init(accessToken: String) {
        self.accessToken = accessToken
    }

    // MARK: - Providers
    func fetchProviders(completion: @escaping (Result<Data, Error>) -> Void) {
        let endpoint = "\(baseURL)/Practitioner"
        performGETRequest(urlString: endpoint, completion: completion)
    }

    // MARK: - Conditions
    func fetchConditions(patientId: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let endpoint = "\(baseURL)/Condition?patient=\(patientId)"
        performGETRequest(urlString: endpoint, completion: completion)
    }

    // MARK: - Medications
    func fetchMedications(patientId: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let endpoint = "\(baseURL)/MedicationRequest?patient=\(patientId)"
        performGETRequest(urlString: endpoint, completion: completion)
    }

    // MARK: - Labs (Observations)
    func fetchLabs(patientId: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let endpoint = "\(baseURL)/Observation?patient=\(patientId)&category=laboratory"
        performGETRequest(urlString: endpoint, completion: completion)
    }

    // MARK: - Vitals
    func fetchVitals(patientId: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let endpoint = "\(baseURL)/Observation?patient=\(patientId)&category=vital-signs"
        performGETRequest(urlString: endpoint, completion: completion)
    }

    // MARK: - Generic GET Request
    private func performGETRequest(urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            return completion(.failure(APIError.invalidURL))
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                return completion(.failure(error))
            }

            guard let data = data else {
                return completion(.failure(APIError.emptyData))
            }

            completion(.success(data))
        }.resume()
    }

    enum APIError: Error {
        case invalidURL
        case emptyData
    }
}
