//
//  OrganizationCardView.swift
//  mE Health
//
//  Created by Ishant on 16/06/25.
//

import SwiftUI

struct Organization: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let type: String
    let imageName: String // e.g. "building.2.crop.circle"
}


struct OrganizationCardView: View {
    let organization: Organization

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(organization.name)
                    .font(.custom("Montserrat-Bold", size: 16))
                    .foregroundColor(.black)

                Text(organization.type)
                    .font(.custom("Montserrat-Regular", size: 14))
                    .foregroundColor(Color(hex: "FF6605"))
            }

            Spacer()

            Image(organization.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(6)
        .shadow(radius: 4)
        .frame(width: 250,height:90)
    }
}

struct AppoitmentCardView: View {
    let organization: Organization
    var showStatus : Bool
    
    var body: some View {
        HStack(spacing: 12) {
            Image("date_placeholder")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .foregroundColor(Color(hex: "FF6605"))
            
            VStack(alignment: .leading, spacing: 4) {
                
                HStack(spacing: 8) {
                    
                    Text("Jan 1, 2023") // You can pull from organization.type if dynamic
                        .font(.custom("Montserrat-Medium", size: 16))
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    if showStatus {
                        Text("Completed")
                            .font(.caption)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 4)
                            .background(Color.green.opacity(0.2))
                            .foregroundColor(.green)
                            .clipShape(Capsule())

                    }
                    
                }
                
                Text(organization.name)
                    .font(.custom("Montserrat-Regular", size: 12))
                    .foregroundColor(Color(hex: "FF6605"))
            }
            
            if !showStatus {
                Spacer() // Optional: pushes content to left, consistent spacing
            }
        }
        .padding(.horizontal, 12) // Internal horizontal padding
        .frame(height: 80)
        .background(Color.white)
    }
}

