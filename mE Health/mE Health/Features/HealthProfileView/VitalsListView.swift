//
//  VitalsListView.swift
//  mE Health
//
//  Created by Rashida on 27/06/25.
//
import SwiftUI


struct ObservationResponse: Codable, Equatable {
    let observations: [VitalDummyData]
}

struct VitalDummyData: Codable, Identifiable, Equatable {
    let id: String
    let codeSystem: String
    let code: String
    let codeDisplay: String
    let codeDetailRaw: String
    let categoryRaw: String
    let valueRaw: String
    let description: String
    let status: String
    let effectiveDate: String
    let valueQuantityValue: Double?
    let valueQuantityUnit: String?
    let valueString: String?
    let referenceRangeLow: Double?
    let referenceRangeHigh: Double?
    let patientId: String
    let encounterId: String
    let createdAt: String
    let updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case codeSystem = "code_system"
        case code
        case codeDisplay = "code_display"
        case codeDetailRaw = "code_detail"
        case categoryRaw = "category"
        case valueRaw = "value"
        case description
        case status
        case effectiveDate
        case valueQuantityValue = "valueQuantity_value"
        case valueQuantityUnit = "valueQuantity_unit"
        case valueString
        case referenceRangeLow = "referenceRange_low"
        case referenceRangeHigh = "referenceRange_high"
        case patientId
        case encounterId
        case createdAt
        case updatedAt
    }
    
    var formattedDate: String {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime]

        if let date = isoFormatter.date(from: effectiveDate) {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            return formatter.string(from: date)
        }
        return effectiveDate
    }

    var codeDetail: CodeInfo? {
        try? JSONDecoder().decode(CodeInfo.self, from: Data(codeDetailRaw.utf8))
    }

    var category: CodeInfo? {
        try? JSONDecoder().decode(CodeInfo.self, from: Data(categoryRaw.utf8))
    }

    var value: ValueInfo? {
        try? JSONDecoder().decode(ValueInfo.self, from: Data(valueRaw.utf8))
    }
}

struct ValueInfo: Codable, Equatable {
    let value: String
    let unit: String
}

struct VitalsListView: View {

    let vital: VitalDummyData
    let onTap: () -> Void
        
        
        var body: some View {

                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(vital.codeDisplay)
                            .font(.custom("Montserrat-Bold", size: 16))
                            .foregroundColor(.black)
                        Spacer()
                        Text(vital.formattedDate)
                            .font(.custom("Montserrat-SemiBold", size: 12))
                            .foregroundColor(.black)
                    }
                    .padding(.top,12)
                    .padding(.horizontal,12)

                    Text("\(vital.valueQuantityValue ?? 0)" + " " + (vital.valueQuantityUnit ?? ""))
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

struct  VitalsSectionView: View {
    let vitals: [VitalDummyData]
    var onCardTap: (VitalDummyData) -> Void
    
    var body: some View {
        
        VStack(spacing: 20) {
            // Horizontal date cards
            if vitals.isEmpty {
                NoDataView()
            } else {
                ForEach(vitals) { vital in
                    VitalsListView(vital: vital) {
                        onCardTap(vital)
                    }
                }
            }

        }
        .padding(.horizontal)

    }
}
