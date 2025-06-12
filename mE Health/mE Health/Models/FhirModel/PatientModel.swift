//
//  PatientModel.swift
//  mE Health
//
//  # =============================================================================
//# mEinstein - CONFIDENTIAL
//#
//# Copyright ©️ 2025 mEinstein Inc. All Rights Reserved.
//#
//# NOTICE: All information contained herein is and remains the property of
//# mEinstein Inc. The intellectual and technical concepts contained herein are
//# proprietary to mEinstein Inc. and may be covered by U.S. and foreign patents,
//# patents in process, and are protected by trade secret or copyright law.
//#
//# Dissemination of this information, or reproduction of this material,
//# is strictly forbidden unless prior written permission is obtained from
//# mEinstein Inc.
//#
//# Author(s): Ishant 
//# ============================================================================= on 23/05/25.
//

struct Patient : Codable, Equatable {
    let resourceType : String?
    let id : String?
    let active : Bool?
    let name : [Name]?
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
    let resourceType : String?
    let id : String?
    let identifier : [Identifier]?
    let active : Bool?
    let name : [Name]?
    let gender : String?
    
    enum CodingKeys: String, CodingKey {
        
        case resourceType = "resourceType"
        case id = "id"
        case identifier = "identifier"
        case active = "active"
        case name = "name"
        case gender = "gender"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        resourceType = try values.decodeIfPresent(String.self, forKey: .resourceType)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        identifier = try values.decodeIfPresent([Identifier].self, forKey: .identifier)
        active = try values.decodeIfPresent(Bool.self, forKey: .active)
        name = try values.decodeIfPresent([Name].self, forKey: .name)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
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
