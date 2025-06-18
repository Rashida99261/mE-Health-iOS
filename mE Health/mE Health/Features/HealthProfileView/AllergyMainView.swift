//
//  AllergyMainView.swift
//  mE Health
//
//  Created by Rashida on 17/06/25.
//

import SwiftUI

struct AllergyDummyData: Identifiable, Equatable {
    let id: UUID = UUID()
    let name: String
    let recordDate: String
}


struct AllergyMainView: View {
    
    let allergy: AllergyDummyData
    let onTap: () -> Void
    
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(allergy.name)
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
            
            Text(allergy.recordDate)
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
                        
                        TextField("Search allergies....", text: $searchText)
                            .font(.custom("Montserrat-Regular", size: 14))
                            .padding(.vertical, 10)
                            .padding(.horizontal, 4)
                    }
                    .frame(height: 50) // 👈 Fixed height
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(hex: Constants.API.PrimaryColorHex), lineWidth: 1.5)
                    )
                    .cornerRadius(10)
                    
                    
                    ForEach(allergies) { allergy in
                        AllergyMainView(allergy: allergy) {
                            onCardTap(allergy)
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}
