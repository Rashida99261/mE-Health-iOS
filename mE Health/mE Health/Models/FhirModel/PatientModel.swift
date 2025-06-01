//
//  PatientModel.swift
//  mE Health
//
//  Created by Rashida on 23/05/25.
//

struct Patient : Codable, Equatable {
    let resourceType : String?
    let id : String?
    let active : Bool?
    let name : [Name]?
    var birthDate : String?
    let generalPractitioner : [GeneralPractitioner]?

    enum CodingKeys: String, CodingKey {

        case resourceType = "resourceType"
        case id = "id"
        case active = "active"
        case name = "name"
        case generalPractitioner = "generalPractitioner"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        resourceType = try values.decodeIfPresent(String.self, forKey: .resourceType)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        active = try values.decodeIfPresent(Bool.self, forKey: .active)
        name = try values.decodeIfPresent([Name].self, forKey: .name)
        generalPractitioner = try values.decodeIfPresent([GeneralPractitioner].self, forKey: .generalPractitioner)
    }

}

struct Name : Codable, Equatable {
    let use : String?
    let text : String?
    let family : String?
    let given : [String]?

    enum CodingKeys: String, CodingKey {

        case use = "use"
        case text = "text"
        case family = "family"
        case given = "given"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        use = try values.decodeIfPresent(String.self, forKey: .use)
        text = try values.decodeIfPresent(String.self, forKey: .text)
        family = try values.decodeIfPresent(String.self, forKey: .family)
        given = try values.decodeIfPresent([String].self, forKey: .given)
    }

}


struct GeneralPractitioner : Codable,Equatable {
    let reference : String?
    let type : String?
    let display : String?

    enum CodingKeys: String, CodingKey {
        case reference = "reference"
        case type = "type"
        case display = "display"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        reference = try values.decodeIfPresent(String.self, forKey: .reference)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        display = try values.decodeIfPresent(String.self, forKey: .display)
    }

}

struct Practitioner: Codable,Equatable {
    let id: String?
    let reference : String?
    let display : String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case reference = "reference"
        case display = "display"

    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        reference = try values.decodeIfPresent(String.self, forKey: .reference)
        display = try values.decodeIfPresent(String.self, forKey: .display)

    }
}


struct PractitionerRole: Codable, Equatable  {
    let resourceType : String?
    let type : String?
    let total : Int?
    let entry : [Entry]?

    enum CodingKeys: String, CodingKey {

        case resourceType = "resourceType"
        case type = "type"
        case total = "total"
        case entry = "entry"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        resourceType = try values.decodeIfPresent(String.self, forKey: .resourceType)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        total = try values.decodeIfPresent(Int.self, forKey: .total)
        entry = try values.decodeIfPresent([Entry].self, forKey: .entry)
    }

}
