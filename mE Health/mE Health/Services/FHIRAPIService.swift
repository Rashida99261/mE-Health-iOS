
import Foundation
import ComposableArchitecture

// MARK: - FHIR API Error Enum
enum FHIRAPIError: Error, LocalizedError, Equatable {
    case invalidURL
    case requestFailed
    case invalidResponse
    case decodingFailed
    case unknown

    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL."
        case .requestFailed: return "Request failed."
        case .invalidResponse: return "Invalid response from server."
        case .decodingFailed: return "Decoding failed."
        case .unknown: return "An unknown error occurred."
        }
    }
}

// MARK: - FHIR API Service

protocol FHIRAPIClient {
    func fetchPatient() async throws -> PatientModel
    func getPractitioner() async throws -> Practitioner
    func getPractitionerRoles(practitionerId: String) async throws -> PractitionerRole
    func getEncounters(participantId: String) async throws -> PractitionerRole
    func getConditions() async throws -> ConditionModel
    func getMedicationRequests() async throws -> MedicationModel
    func getLabObservations() async throws -> ObservationModel
    func getVitalObservations() async throws -> ObservationModel
    func getDocumentReferences() async throws -> DocumentReferenceModel
    func getConsents() async throws -> ConsentModel
    func getOrganisation() async throws -> OrganizationModel
    func getAppoitment() async throws -> AppoitmentModel
    func getAppoitmentDetail(appointmentId:String) async throws -> AppoitmentResource
    func getProcedure() async throws -> ProcedureModel
    func getAllergy() async throws -> AllergyModel
    func getAllergyDetail(id:String) async throws -> AllergyResource
    func getImmunization() async throws -> ImmunizationModel
    func getImmunizationDetail(id:String) async throws -> ImmunizationResource
}

struct FHIRAPIService : FHIRAPIClient{
    
    
    private func makeRequest(path: String, queryItems: [URLQueryItem] = []) throws -> URLRequest {
        guard var components = URLComponents(string: Constants.API.FHIRbaseURL + path) else {
            throw URLError(.badURL)
        }
        components.queryItems = queryItems
        guard let url = components.url else {
            throw URLError(.badURL)
        }
        let bearerToken = TokenManager.fetchAccessToken() ?? ""
        print("bearerToken",bearerToken)
        var request = URLRequest(url: url)
        request.setValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/fhir+json", forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"
        return request
        
    }
    
    private func fetch<T: Decodable>(_ type: T.Type, from path: String, queryItems: [URLQueryItem] = []) async throws -> T {
        let request = try makeRequest(path: path, queryItems: queryItems)
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    // MARK: - Providers
    
    func fetchPatient() async throws -> PatientModel {
        guard let patientId = UserDefaults.standard.string(forKey: "patientId") else {
            throw URLError(.badURL)
        }
        
        return try await fetch(PatientModel.self, from: "/Patient/\(patientId)")
    }
    
    func getPractitioner() async throws -> Practitioner {
        guard let practitionerId = UserDefaults.standard.string(forKey: "practitionerId") else {
            throw URLError(.badURL)
        }
        return try await fetch(Practitioner.self, from: "/\(practitionerId)")
    }
    
    func getPractitionerRoles(practitionerId: String) async throws -> PractitionerRole {
        return try await fetch(PractitionerRole.self, from: "/PractitionerRole?practitioner=\(practitionerId)")
    }
    
    func getEncounters(participantId: String) async throws -> PractitionerRole {
        return try await fetch(PractitionerRole.self, from: "/Encounter?participant=\(participantId)")
    }
    
    
    // MARK: - Conditions
    
    func getConditions() async throws -> ConditionModel {
        guard let patientId = UserDefaults.standard.string(forKey: "patientId") else {
            throw URLError(.badURL)
        }
        return try await fetch(ConditionModel.self, from: "/Condition?patient=\(patientId)")
    }
    
    // MARK: - Medications
    
    func getMedicationRequests() async throws -> MedicationModel {
        guard let patientId = UserDefaults.standard.string(forKey: "patientId") else {
            throw URLError(.badURL)
        }
        return try await fetch(MedicationModel.self, from: "/MedicationRequest?patient=\(patientId)")
    }
    //
    //    // MARK: - Labs
    
    func getLabObservations() async throws -> ObservationModel {
        guard let patientId = UserDefaults.standard.string(forKey: "patientId") else {
            throw URLError(.badURL)
        }
        return try await fetch(ObservationModel.self, from: "/Observation?patient=\(patientId)&category=laboratory")
    }
    
    // MARK: - Vitals
    
    func getVitalObservations() async throws -> ObservationModel {
        guard let patientId = UserDefaults.standard.string(forKey: "patientId") else {
            throw URLError(.badURL)
        }
        return try await fetch(ObservationModel.self, from: "/Observation?patient=\(patientId)&category=vital-signs")
    }
    
    // MARK: - Uploads
    
    func getDocumentReferences() async throws -> DocumentReferenceModel {
        guard let patientId = UserDefaults.standard.string(forKey: "patientId") else {
            throw URLError(.badURL)
        }
        return try await fetch(DocumentReferenceModel.self, from: "/DocumentReference?patient=\(patientId)")
    }
    
    // MARK: - Consents
    
    func getConsents() async throws -> ConsentModel {
        guard let patientId = UserDefaults.standard.string(forKey: "patientId") else {
            throw URLError(.badURL)
        }
        return try await fetch(ConsentModel.self, from: "/Consent?patient=\(patientId)")
    }
    
    func getOrganisation() async throws -> OrganizationModel {
        guard let patientId = UserDefaults.standard.string(forKey: "patientId") else {
            throw URLError(.badURL)
        }
        return try await fetch(OrganizationModel.self, from: "/Organization/\(patientId)")
    }
        
    func getAppoitment() async throws -> AppoitmentModel {
        guard let patientId = UserDefaults.standard.string(forKey: "patientId") else {
            throw URLError(.badURL)
        }
        return try await fetch(AppoitmentModel.self, from: "/Appointment?patient=\(patientId)")
    }
    
    func getAppoitmentDetail(appointmentId:String) async throws -> AppoitmentResource {
        return try await fetch(AppoitmentResource.self, from: "/Appointment/\(appointmentId)")
    }

    func getAllergy() async throws -> AllergyModel {
        guard let patientId = UserDefaults.standard.string(forKey: "patientId") else {
            throw URLError(.badURL)
        }
        return try await fetch(AllergyModel.self, from: "/AllergyIntolerance?patient=\(patientId)")
    }
    
    func getAllergyDetail(id:String) async throws -> AllergyResource {
        return try await fetch(AllergyResource.self, from: "/AllergyIntolerance/\(id)")
    }
    
    func getImmunization() async throws -> ImmunizationModel {
        guard let patientId = UserDefaults.standard.string(forKey: "patientId") else {
            throw URLError(.badURL)
        }
        return try await fetch(ImmunizationModel.self, from: "/Immunization?patient=\(patientId)")
    }
    
    func getImmunizationDetail(id:String) async throws -> ImmunizationResource {
        return try await fetch(ImmunizationResource.self, from: "/Immunization/\(id)")
    }
    
    func getProcedure() async throws -> ProcedureModel {
        guard let patientId = UserDefaults.standard.string(forKey: "patientId") else {
            throw URLError(.badURL)
        }
        return try await fetch(ProcedureModel.self, from: "/Procedure?patient=\(patientId)")
    }

    
}

// MARK: - Expected Bundle Types

struct FhirClientDependency {
    var fetchPatient: () async throws -> PatientModel
    var getPractitioner: () async throws -> Practitioner
    var getPractitionerRoles: (String) async throws -> PractitionerRole
    var getEncounters: (String) async throws -> PractitionerRole
    var getConditions: () async throws -> ConditionModel
    var getMedicationRequests: () async throws -> MedicationModel
    var getLabObservations: () async throws -> ObservationModel
    var getVitalObservations: () async throws -> ObservationModel
    var getDocumentReferences: () async throws -> DocumentReferenceModel
    var getConsents: () async throws -> ConsentModel
    var getOrganisation:() async throws -> OrganizationModel
    var getAppoitment: () async throws -> AppoitmentModel
    var getAppoitmentDetail: (String) async throws -> AppoitmentResource
    var getProcedure: () async throws -> ProcedureModel
    var getAllergy: () async throws -> AllergyModel
    var getAllergyDetail: (String) async throws -> AllergyResource
    var getImmunization: () async throws -> ImmunizationModel
    var getImmunizationDetail: (String) async throws -> ImmunizationResource

}

enum FhirClientKey: DependencyKey {
    static let liveValue = FhirClientDependency(
        fetchPatient: {
            try await FHIRAPIService().fetchPatient()
        },
        getPractitioner: {
            try await FHIRAPIService().getPractitioner()
        },
        getPractitionerRoles: { practitionerId in
            try await FHIRAPIService().getPractitionerRoles(practitionerId: practitionerId)
        },
        getEncounters: { participantId in
            try await FHIRAPIService().getEncounters(participantId: participantId)
        },
        getConditions: {
            try await FHIRAPIService().getConditions()
        },
        getMedicationRequests: {
            try await FHIRAPIService().getMedicationRequests()
        },
        getLabObservations: {
            try await FHIRAPIService().getLabObservations()
        },
        getVitalObservations: {
            try await FHIRAPIService().getVitalObservations()
        },
        getDocumentReferences: {
            try await FHIRAPIService().getDocumentReferences()
        },
        getConsents: {
            try await FHIRAPIService().getConsents()
        },
        getOrganisation: {
            try await FHIRAPIService().getOrganisation()
        },
        getAppoitment: {
            try await FHIRAPIService().getAppoitment()
        },
        getAppoitmentDetail: { appointmentId in
            try await FHIRAPIService().getAppoitmentDetail(appointmentId: appointmentId)
        },
        getProcedure: {
            try await FHIRAPIService().getProcedure()
        },
        getAllergy: {
            try await FHIRAPIService().getAllergy()
        },
        getAllergyDetail: { Allergyid in
            try await FHIRAPIService().getAllergyDetail(id: Allergyid)
        },
        getImmunization: {
            try await FHIRAPIService().getImmunization()
        },
        getImmunizationDetail: { immuneId in
            try await FHIRAPIService().getImmunizationDetail(id:immuneId)
        }

    )
}

extension DependencyValues {
    var fhirClient: FhirClientDependency {
        get { self[FhirClientKey.self] }
        set { self[FhirClientKey.self] = newValue }
    }
}





