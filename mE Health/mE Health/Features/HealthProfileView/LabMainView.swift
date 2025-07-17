//
//  LabMainView.swift
//  mE Health
//
//  Created by Rashida on 18/06/25.
//


import SwiftUI


struct DiagnosticReportResponse: Codable {
    let diagnosticReports: [LabDummyData]
}



struct LabDummyData: Codable,Identifiable, Equatable {
    let id: String
    let codeSystem: String
    let codeValue: String
    let codeDisplay: String
    let codeRaw: String
    let status: String
    let effectiveDate: String
    let issued: String
    let patientId: String
    let encounterId: String
    let performerId: String
    let organizationId: String
    let result: [ResultReference]
    let createdAt: String
    let updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case codeSystem = "code_system"
        case codeValue = "code"
        case codeDisplay = "code_display"
        case codeRaw = "code_detail"
        case status
        case effectiveDate
        case issued
        case patientId
        case encounterId
        case performerId
        case organizationId
        case result
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
    // Computed property to decode embedded code JSON string
    var code: CodeInfo? {
        guard let data = codeRaw.data(using: .utf8) else { return nil }
        return try? JSONDecoder().decode(CodeInfo.self, from: data)
    }

}

struct ResultReference: Codable , Equatable{
    let reference: String
    let display: String
}


struct LabMainView: View {

    let lab: LabDummyData
    let onTap: () -> Void
        
        var body: some View {

                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(lab.codeDisplay)
                            .font(.custom("Montserrat-Bold", size: 18))
                            .foregroundColor(.black)
                        Spacer()
                        
                        if lab.status == "final" {
                            Text("Active")
                                .font(.caption)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 4)
                                .background(Color.green.opacity(0.2))
                                .foregroundColor(.green)
                                .clipShape(Capsule())

                        }
                        else if lab.status == "preliminary"{
                            Text("Preliminary")
                                .font(.caption)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 4)
                                .background(Color(hex: "F09C00").opacity(0.2))
                                .foregroundColor(Color(hex: "F09C00"))
                                .clipShape(Capsule())
                        }
                        
                    }
                    .padding(.top,12)
                    .padding(.horizontal,12)

                    Text("Recorded Date: \(lab.formattedDate)")
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

struct LabSectionView: View {
    let labs: [LabDummyData]
    let searchText: String
    var onCardTap: (LabDummyData) -> Void
    
    var filteredAppointments: [LabDummyData] {
           if searchText.isEmpty {
               return labs
           } else {
               return labs.filter { lab in
                   lab.codeDisplay.localizedCaseInsensitiveContains(searchText)
               }
           }
       }

    
    var body: some View {
        
        VStack(spacing: 20) {
            // Horizontal date cards
            
            if filteredAppointments.isEmpty {
                NoDataView()
            } else {
                ForEach(filteredAppointments) { labdata in
                    LabMainView(lab: labdata) {
                        onCardTap(labdata)
                    }
                }
            }
        }
        .padding(.horizontal)

    }
}
