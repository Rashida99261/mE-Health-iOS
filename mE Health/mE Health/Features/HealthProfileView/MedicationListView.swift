//
//  MedicationListView.swift
//  mE Health
//
//  Created by Rashida on 27/06/25.
//

import SwiftUI

struct MedicationDummyData: Identifiable, Equatable {
    let id: UUID = UUID()
    let name: String
    let recordDate: String
    let status: MedicationStatus?
}

enum MedicationStatus: String {
    case active = "Active"
}


struct MedicationListView: View {

    let medication: MedicationDummyData
    let onTap: () -> Void
        
        var body: some View {

                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(medication.name)
                            .font(.custom("Montserrat-Bold", size: 18))
                            .foregroundColor(.black)
                        Spacer()
                        
                        
                        if medication.status ==  .active {
                            
                            Text("Active")
                                .font(.custom("Montserrat-SemiBold", size: 9))
                                .padding(.horizontal, 12)
                                .padding(.vertical, 4)
                                .background(Color(hex: "06C270").opacity(0.2))
                                .foregroundColor(Color(hex: "06C270"))
                                .clipShape(Capsule())
                        }

                        
                    }
                    .padding(.top,12)
                    .padding(.horizontal,12)

                    Text(medication.recordDate)
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

struct MedicationSectionView: View {
    let medications: [MedicationDummyData]
    var onCardTap: (MedicationDummyData) -> Void
    
    var body: some View {
        
        VStack(spacing: 20) {
            // Horizontal date cards
            if medications.isEmpty {
                NoDataView()
            } else {
                ForEach(medications) { medicationData in
                    MedicationListView(medication: medicationData) {
                        onCardTap(medicationData)
                    }
                }
            }

        }
        .padding(.horizontal)

    }
}
