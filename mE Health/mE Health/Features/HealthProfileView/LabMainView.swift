//
//  LabMainView.swift
//  mE Health
//
//  Created by Rashida on 18/06/25.
//


import SwiftUI

struct LabDummyData: Identifiable, Equatable {
    let id: UUID = UUID()
    let name: String
    let recordDate: String
    var isActive: Bool = true
}


struct LabMainView: View {

    let lab: LabDummyData
    let onTap: () -> Void
        
        
        var body: some View {

                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text(lab.name)
                            .font(.custom("Montserrat-Medium", size: 20))
                            .foregroundColor(.black)
                        Spacer()
                        
                        if lab.isActive {
                            
                            Text("Active")
                                .font(.caption)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 4)
                                .background(Color.green.opacity(0.2))
                                .foregroundColor(.green)
                                .clipShape(Capsule())

                        }
                        else {
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

                    Text(lab.recordDate)
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
    let startDate: String
    let endDate: String
    var onCardTap: (LabDummyData) -> Void
    @State private var searchText = ""
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 24) {
                // Horizontal date cards
                
                Spacer()
                
                HStack(spacing: 16) {
                    DateCardView(title: "Start Date", date: startDate)
                    DateCardView(title: "End Date", date: endDate)
                }
                
                    VStack(spacing: 24) {
                        
                        
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(Color(hex: Constants.API.PrimaryColorHex))
                                .padding(.leading, 8)

                            TextField("Search labs....", text: $searchText)
                                .font(.custom("Montserrat-Regular", size: 14))
                                .padding(.vertical, 10)
                                .padding(.horizontal, 4)
                        }
                        .frame(height: 50)
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(hex: Constants.API.PrimaryColorHex), lineWidth: 1.5)
                        )
                        .cornerRadius(10)

                        
                        ForEach(labs) { labdata in
                            LabMainView(lab: labdata) {
                                onCardTap(labdata)
                            }
                        }
                    }
            }
            .padding(.horizontal)
        }
    }
}
