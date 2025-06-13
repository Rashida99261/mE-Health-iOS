//
//  AllergyModel.swift
//  mE Health
//
//  Created by //# Author(s): Ishant  on 12/06/25.
//

struct AllergyModel : Codable , Equatable{
    let entry : [AllergyEntry]?

    enum CodingKeys: String, CodingKey {

        case entry = "entry"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        entry = try values.decodeIfPresent([AllergyEntry].self, forKey: .entry)
    }

}


struct AllergyEntry : Codable,Equatable {
    let resource : AllergyResource?

    enum CodingKeys: String, CodingKey {

        case resource = "resource"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        resource = try values.decodeIfPresent(AllergyResource.self, forKey: .resource)
    }

}

struct AllergyResource : Codable,Equatable {
    let resourceType : String?
    let id : String?
    let clinicalStatus : ClinicalStatus?
    let verificationStatus : VerificationStatus?
    let code : Code?
    let patient : PatientReference?

    enum CodingKeys: String, CodingKey {

        case resourceType = "resourceType"
        case id = "id"
        case clinicalStatus = "clinicalStatus"
        case verificationStatus = "verificationStatus"
        case code = "code"
        case patient = "patient"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        resourceType = try values.decodeIfPresent(String.self, forKey: .resourceType)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        clinicalStatus = try values.decodeIfPresent(ClinicalStatus.self, forKey: .clinicalStatus)
        verificationStatus = try values.decodeIfPresent(VerificationStatus.self, forKey: .verificationStatus)
        code = try values.decodeIfPresent(Code.self, forKey: .code)
        patient = try values.decodeIfPresent(PatientReference.self, forKey: .patient)
    }

}

struct PatientReference : Codable,Equatable {
    let reference : String?
    let display : String?

    enum CodingKeys: String, CodingKey {

        case reference = "reference"
        case display = "display"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        reference = try values.decodeIfPresent(String.self, forKey: .reference)
        display = try values.decodeIfPresent(String.self, forKey: .display)
    }

}
