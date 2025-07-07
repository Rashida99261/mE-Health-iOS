//
//  VitalsListView.swift
//  mE Health
//
//  Created by Rashida on 27/06/25.
//
import SwiftUI

struct VitalDummyData: Identifiable, Equatable {
    let id: UUID = UUID()
    let name: String
    let date: String
    let mg: String
}



struct VitalsListView: View {

    let vital: VitalDummyData
    let onTap: () -> Void
        
        
        var body: some View {

                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(vital.name)
                            .font(.custom("Montserrat-Bold", size: 16))
                            .foregroundColor(.black)
                        Spacer()
                        
                        Text(vital.date)
                            .font(.custom("Montserrat-SemiBold", size: 12))
                            .foregroundColor(.black)
                    }
                    .padding(.top,12)
                    .padding(.horizontal,12)

                    Text(vital.mg)
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
        
        VStack(spacing: 24) {
            // Horizontal date cards
            ForEach(vitals) { vital in
                VitalsListView(vital: vital) {
                    onCardTap(vital)
                }
            }
        }
        .padding(.horizontal)

    }
}
