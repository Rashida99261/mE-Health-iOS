//
//  PractitionerCardView.swift
//  mE Health
//
//  Created by Ishant on 16/06/25.
//
import SwiftUI

struct PractitionerResponse: Codable {
    let practitioners: [PractitionerData]
}

struct PractitionerData: Codable, Equatable , Identifiable{
    let id: String
    let name: String
    let specialty: String
    let telecom: String
    let qualification: String
    var phone: String? {
        telecom
            .components(separatedBy: ";")
            .first(where: { $0.hasPrefix("phone:") })?
            .replacingOccurrences(of: "phone:", with: "")
    }

    var email: String? {
        telecom
            .components(separatedBy: ";")
            .first(where: { $0.hasPrefix("email:") })?
            .replacingOccurrences(of: "email:", with: "")
    }
}

struct PractitionerCardView: View {
    let practitioner: PractitionerData
    let onTap: () -> Void

    var body: some View {
        HStack(spacing: 4) {
            VStack(alignment: .leading, spacing: 12) {
                Text(practitioner.name)
                    .font(.custom("Montserrat-Bold", size: 16))

                Text(practitioner.specialty)
                    .font(.custom("Montserrat-Regular", size: 14))
                    .foregroundColor(.gray)

                HStack(spacing: 8) {
                    Image(systemName: "phone.fill")
                        .foregroundColor(Color(hex: "FF6605"))
                    Text(practitioner.phone ?? "")
                        .font(.custom("Montserrat-Regular", size: 14))
                }

                HStack(spacing: 8) {
                    Image(systemName: "envelope.fill")
                        .foregroundColor(Color(hex: "FF6605"))
                    Text(practitioner.email ?? "")
                        .font(.custom("Montserrat-Regular", size: 14))
                }
                
                
            }

            Spacer()
            
            PractitionerActionColumn()
                .frame(height:150)
                .padding(.trailing, 0)
            
                
        }
        .padding(.leading, 12)
        .frame(height:150)
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 4)
        .onTapGesture {
            onTap()
        }
    }
}


struct PractitionerSectionView: View {
    let practitioners: [PractitionerData]
    let startDate: String
    let endDate: String
    var onCardTap: (PractitionerData) -> Void
    
    var body: some View {
        
        VStack(spacing: 20) {
            // Horizontal date cards
            
            if practitioners.isEmpty {
                NoDataView()
            } else {
                ForEach(practitioners) { practitioner in
                    PractitionerCardView(practitioner: practitioner) {
                        onCardTap(practitioner)
                    }
                }
            }
        }
        .padding(.horizontal)
    }

}


struct PractitionerActionColumn: View {
    let icons = ["envelope.fill", "phone.fill", "eye.fill"]

    var body: some View {
        VStack(spacing: 1) {
            ForEach(icons, id: \.self) { icon in
                Button(action: {
                    // Handle tap
                }) {
                    Image(systemName: icon)
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.white)
                        .frame(width: 20, height: 20)
                        .padding()
                        .frame(width: 50, height: 50)
                        .background(Color(hex: "FF6605"))
                }
            }
        }
        .padding(.trailing,0)
        .frame(width: 50) // Fixed width for the action column
        .background(
            RoundedCorners(color: Color.white, tl: 0, tr: 12, bl: 12, br: 0)
        )
    }
}

