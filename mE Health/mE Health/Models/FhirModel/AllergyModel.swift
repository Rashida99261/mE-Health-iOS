//
//  AllergyModel.swift
//  mE Health
//
//  Created by Rashida on 12/06/25.
//

struct AllergyModel : Codable , Equatable{
    let resourceType : String?
    let type : String?
    let total : Int?
    let link : [CommonLinkModel]?
    let entry : [CommonEntry]?

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
        entry = try values.decodeIfPresent([CommonEntry].self, forKey: .entry)
    }

}


struct CommonEntry : Codable,Equatable {
    let link : [CommonLinkModel]?
    let fullUrl : String?
    let resource : CommonResource?

    enum CodingKeys: String, CodingKey {

        case link = "link"
        case fullUrl = "fullUrl"
        case resource = "resource"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        link = try values.decodeIfPresent([CommonLinkModel].self, forKey: .link)
        fullUrl = try values.decodeIfPresent(String.self, forKey: .fullUrl)
        resource = try values.decodeIfPresent(CommonResource.self, forKey: .resource)
    }

}
