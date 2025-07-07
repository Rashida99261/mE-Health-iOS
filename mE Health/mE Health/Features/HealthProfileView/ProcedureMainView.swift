//
//  ProcedureMainView.swift
//  mE Health
//
//  Created by Rashida on 24/06/25.
//

import SwiftUI

struct ProcedureJsonResponse: Codable {
    let procedures: [ProcedureDummyData]
}

struct CodeInfo: Codable , Equatable{
    let system: String
    let code: String
    let display: String
}


struct ProcedureDummyData: Codable,Identifiable, Equatable {
    let id: String
    let codeSystem: String
    let rawCode: String
    let codeDisplay: String
    let performedDate: String
    let rawReasonCode: String
    let patientId: String
    let encounterId: String
    let createdAt: String
    let updatedAt: String
    let status: ProcedureStatus?
    
    var code: CodeInfo? {
        try? JSONDecoder().decode(CodeInfo.self, from: Data(rawCode.utf8))
    }

    var reasonCode: CodeInfo? {
        try? JSONDecoder().decode(CodeInfo.self, from: Data(rawReasonCode.utf8))
    }

    enum CodingKeys: String, CodingKey {
        case id
        case codeSystem = "code_system"
        case rawCode = "code"
        case codeDisplay = "code_display"
        case status
        case performedDate
        case rawReasonCode = "reasonCode"
        case patientId
        case encounterId
        case createdAt
        case updatedAt
    }


}

enum ProcedureStatus: String, Codable {
    case completed = "Completed"
    case progress = "In Progress"
}



struct ProcedureMainView: View {

    let procedure: ProcedureDummyData
    let onTap: () -> Void
        
        var body: some View {

                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(procedure.codeDisplay ?? "Unknown Code")
                            .font(.custom("Montserrat-Bold", size: 18))
                            .foregroundColor(.black)
                        Spacer()
                        
                        if procedure.status ==  .completed {
                                Text("Completed")
                                .font(.custom("Montserrat-SemiBold", size: 9))
                                .padding(.horizontal, 12)
                                .padding(.vertical, 4)
                                .background(Color(hex: "06C270").opacity(0.2))
                                .foregroundColor(Color(hex: "06C270"))
                                .clipShape(Capsule())
                        }
                        else if procedure.status ==  .progress {
                                Text("In Progress")
                                .font(.custom("Montserrat-SemiBold", size: 9))
                                .padding(.horizontal, 12)
                                .padding(.vertical, 4)
                                .background(Color(hex: "F09C00").opacity(0.2))
                                .foregroundColor(Color(hex: "F09C00"))
                                .clipShape(Capsule())
                        }
                    }
                    .padding(.top,12)
                    .padding(.horizontal,12)

                    Text(procedure.performedDate)
                        .font(.custom("Montserrat-Regular", size: 14))
                        .foregroundColor(.black)
                        .padding(.horizontal,12)

                    Button(action: onTap) {
                        Text("View Details")
                            .font(.custom("Montserrat-SemiBold", size: 14))
                            .foregroundColor(.white)
                            .frame(width:135)
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

struct ProcedureSectionView: View {
    let procedure: [ProcedureDummyData]
    var onCardTap: (ProcedureDummyData) -> Void
    
    var body: some View {
        
        VStack(spacing: 24) {
            // Horizontal date cards
            
            if procedure.isEmpty {
                NoDataView()
            } else {
                ForEach(procedure) { procData in
                    ProcedureMainView(procedure: procData) {
                        onCardTap(procData)
                    }
                }
            }

        }
        .padding(.horizontal)

    }
}
