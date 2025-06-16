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

            Image(systemName: organization.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundColor(Color(hex: "FF6605"))
        }
        .padding()
        .background(Color.white)
        .cornerRadius(6)
        .shadow(radius: 4)
        .frame(width: 250,height:80)
    }
}

struct AppoitmentCardView: View {
    let organization: Organization

    var body: some View {
        HStack {
            
            Image(systemName: organization.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundColor(Color(hex: "FF6605"))
            
            Spacer()

            VStack(alignment: .leading, spacing: 4) {
                Text(organization.name)
                    .font(.custom("Montserrat-Bold", size: 16))
                    .foregroundColor(.black)

                Text(organization.type)
                    .font(.custom("Montserrat-Regular", size: 14))
                    .foregroundColor(Color(hex: "FF6605"))
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(6)
        .shadow(radius: 4)
        .frame(height:80)
    }
}
