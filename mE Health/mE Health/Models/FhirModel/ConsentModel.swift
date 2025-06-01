//
//  ConsentModel.swift
//  mE Health
//
//  Created by Rashida on 23/05/25.
//

struct ConsentModel : Codable , Equatable {
    let resourceType : String?
    let type : String?
    let total : Int?
    let link : [CommonLinkModel]?
    let entry : [ConsentEntry]?

    enum CodingKeys: String, CodingKey {

        case resourceType = "resourceType"
        case type = "type"
        case total = "total"
        case link = "link"
        case entry = "entry"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        resourceType = try values.decodeIfPresent(String.self, forKey: .resourceType)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        total = try values.decodeIfPresent(Int.self, forKey: .total)
        link = try values.decodeIfPresent([CommonLinkModel].self, forKey: .link)
        entry = try values.decodeIfPresent([ConsentEntry].self, forKey: .entry)
    }

}


struct ConsentEntry : Codable,Equatable {
    let fullUrl : String?
    let resource : ConsentResource?

    enum CodingKeys: String, CodingKey {

        case fullUrl = "fullUrl"
        case resource = "resource"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        fullUrl = try values.decodeIfPresent(String.self, forKey: .fullUrl)
        resource = try values.decodeIfPresent(ConsentResource.self, forKey: .resource)
    }

}

struct ConsentResource : Codable,Equatable {
    let resourceType : String?
    let issue : [ConsentIssue]?
    
    enum CodingKeys: String, CodingKey {
        
        case resourceType = "resourceType"
        case issue = "issue"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        resourceType = try values.decodeIfPresent(String.self, forKey: .resourceType)
        issue = try values.decodeIfPresent([ConsentIssue].self, forKey: .issue)
    }
    
}

struct ConsentIssue : Codable,Equatable {
    let severity : String?
    let code : String?
    let details : Details?
    let diagnostics : String?

    enum CodingKeys: String, CodingKey {

        case severity = "severity"
        case code = "code"
        case details = "details"
        case diagnostics = "diagnostics"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        severity = try values.decodeIfPresent(String.self, forKey: .severity)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        details = try values.decodeIfPresent(Details.self, forKey: .details)
        diagnostics = try values.decodeIfPresent(String.self, forKey: .diagnostics)
    }

}

