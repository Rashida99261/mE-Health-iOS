//
//  ProcedureMainView.swift
//  mE Health
//
//  Created by Rashida on 24/06/25.
//

import SwiftUI

struct ProcedureDummyData: Identifiable, Equatable {
    let id: UUID = UUID()
    let name: String
    let recordDate: String
    let status: ProcedureStatus?
}

enum ProcedureStatus: String {
    case completed = "Completed"
    case progress = "In Progress"
}


struct ProcedureMainView: View {

    let procedure: ProcedureDummyData
    let onTap: () -> Void
        
        var body: some View {

                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(procedure.name)
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

                    Text(procedure.recordDate)
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
        
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 24) {
                // Horizontal date cards
                
                ForEach(procedure) { procData in
                    ProcedureMainView(procedure: procData) {
                        onCardTap(procData)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}
