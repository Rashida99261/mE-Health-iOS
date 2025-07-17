//
//  ConditionListView.swift
//  mE Health
//
//  Created by Rashida on 27/06/25.
//

import SwiftUI


struct ConditionResponse: Codable , Equatable{
    let conditions: [ConditionDummyData]
}

struct ConditionDummyData: Codable,Identifiable, Equatable {
    let id: String
    let codeSystem: String
    let codeValue: String
    let codeDisplay: String
    let codeRaw: String
    let categoryRaw: String
    let description: String
    let clinicalStatus: String
    let onsetDate: String
    let recordedDate: String
    let patientId: String
    let encounterId: String
    let createdAt: String
    let updatedAt: String
    
    var formattedOnSetDate: String {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime]

        if let date = isoFormatter.date(from: onsetDate) {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            return formatter.string(from: date)
        }
        return onsetDate
    }

    
    var formattedOnRecordDate: String {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime]

        if let date = isoFormatter.date(from: recordedDate) {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            return formatter.string(from: date)
        }
        return recordedDate
    }


    enum CodingKeys: String, CodingKey {
        case id
        case codeSystem = "code_system"
        case codeValue = "code"
        case codeDisplay = "code_display"
        case codeRaw = "code_detail"
        case categoryRaw = "category"
        case description
        case clinicalStatus
        case onsetDate
        case recordedDate
        case patientId
        case encounterId
        case createdAt
        case updatedAt
    }

    // Computed properties to decode embedded JSON strings
    var code: CodeInfo? {
        decodeJSONString(from: codeRaw)
    }

    var category: CodeInfo? {
        decodeJSONString(from: categoryRaw)
    }

    private func decodeJSONString<T: Decodable>(from jsonString: String) -> T? {
        guard let data = jsonString.data(using: .utf8) else { return nil }
        return try? JSONDecoder().decode(T.self, from: data)
    }
}

enum ConditionStatus: String {
    case active = "Active"
    case resolved = "Resolved"
}



struct ConditionListView: View {

    let condition: ConditionDummyData
    let onTap: () -> Void
        
        
        var body: some View {

                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(condition.codeDisplay)
                            .font(.custom("Montserrat-Bold", size: 18))
                            .foregroundColor(.black)
                        Spacer()
                        
                        if condition.clinicalStatus ==  "active" {
                            Text("Active")
                                .font(.custom("Montserrat-SemiBold", size: 9))
                                .padding(.horizontal, 12)
                                .padding(.vertical, 4)
                                .background(Color(hex: "06C270").opacity(0.2))
                                .foregroundColor(Color(hex: "06C270"))
                                .clipShape(Capsule())

                        }
                        else  {
                            Text("Resolved")
                                .font(.custom("Montserrat-SemiBold", size: 9))
                                .padding(.horizontal, 12)
                                .padding(.vertical, 4)
                                .background(Color(hex: "A811C7").opacity(0.2))
                                .foregroundColor(Color(hex: "A811C7"))
                                .clipShape(Capsule())
                        }
                    }
                    .padding(.top,12)
                    .padding(.horizontal,12)

                    Text(condition.formattedOnSetDate)
                        .font(.custom("Montserrat-Regular", size: 16))
                        .foregroundColor(.black)
                        .padding(.horizontal,12)

                    
                    Button(action: onTap) {
                        Text("View Details")
                            .font(.custom("Montserrat-Bold", size: 14))
                            .foregroundColor(.white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color(hex: "FF6605"))
                            .cornerRadius(20)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.bottom, 12)
                    .padding(.horizontal,12)

                }
                .padding(.leading, 12)
                .background(Color.white)
                .cornerRadius(8)
                .shadow(radius: 4)

            
        }

}

struct ConditionSectionView: View {
    let conditions: [ConditionDummyData]
    let searchText: String
    var onCardTap: (ConditionDummyData) -> Void
    
    var filteredAppointments: [ConditionDummyData] {
           if searchText.isEmpty {
               return conditions
           } else {
               return conditions.filter { condition in
                   condition.codeDisplay.localizedCaseInsensitiveContains(searchText)
               }
           }
       }

    
    var body: some View {
        
        VStack(spacing: 20) {
            if filteredAppointments.isEmpty {
                        NoDataView()
            } else {
                ForEach(filteredAppointments) { condition in
                    ConditionListView(condition: condition) {
                        onCardTap(condition)
                    }
                }
            }
        }
        .padding(.horizontal)

    }
}
