//
//  AllergyMainView.swift
//  mE Health
//
//  Created by Rashida on 17/06/25.
//

import SwiftUI


struct AllergyResponse: Codable {
    let allergyIntolerances: [AllergyDummyData]
}


struct AllergyDummyData: Identifiable, Equatable, Codable {
    let id: String
    let codeSystem: String
    let codeDisplay: String
    let rawCode: String
    let clinicalStatus: String
    let patientId: String
    let encounterId: String
    let recordedDate: String
    let createdAt: String
    let updatedAt: String

    // Parsed code object
    var code: CodeInfo? {
        try? JSONDecoder().decode(CodeInfo.self, from: Data(rawCode.utf8))
    }
    
    var formattedRecordedDate: String {
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
        case codeDisplay = "code_display"
        case rawCode = "code"
        case clinicalStatus
        case patientId
        case encounterId
        case recordedDate
        case createdAt
        case updatedAt
    }
}

struct AllergyMainView: View {
    
    let allergy: AllergyDummyData
    let onTap: () -> Void
    
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(allergy.code?.display ?? "")
                    .font(.custom("Montserrat-Medium", size: 20))
                    .foregroundColor(.black)
                Spacer()
                Text("Active")
                    .font(.caption)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 4)
                    .background(Color.green.opacity(0.2))
                    .foregroundColor(.green)
                    .clipShape(Capsule())
            }
            .padding(.top,12)
            .padding(.horizontal,12)
            
            Text("Recorded Date: \(allergy.formattedRecordedDate)")
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

struct AllergySectionView: View {
    let allergies: [AllergyDummyData]
    let startDate: String
    let endDate: String
    var onCardTap: (AllergyDummyData) -> Void
    @State private var searchText = ""
    
    var body: some View {
        
        VStack(spacing: 24) {
            // Horizontal date cards
            ForEach(allergies) { allergy in
                AllergyMainView(allergy: allergy) {
                    onCardTap(allergy)
                }
            }
        }
        .padding(.horizontal)

    }
}
