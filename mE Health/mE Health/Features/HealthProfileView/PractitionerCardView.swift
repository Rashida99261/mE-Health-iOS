//
//  PractitionerCardView.swift
//  mE Health
//
//  Created by Ishant on 16/06/25.
//

struct PractitionerData: Identifiable, Equatable {
    let id: UUID = UUID()
    let name: String
    let specialty: String
    let phone: String
    let email: String
}


import SwiftUI
struct PractitionerCardView: View {
    let practitioner: PractitionerData
    let onTap: () -> Void

    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 12) {
                Text(practitioner.name)
                    .font(.custom("Montserrat-Bold", size: 16))

                Text(practitioner.specialty)
                    .font(.custom("Montserrat-Regular", size: 14))
                    .foregroundColor(.gray)

                HStack(spacing: 8) {
                    Image(systemName: "phone.fill")
                        .foregroundColor(Color(hex: "FF6605"))
                    Text(practitioner.phone)
                        .font(.custom("Montserrat-Regular", size: 14))
                }

                HStack(spacing: 8) {
                    Image(systemName: "envelope.fill")
                        .foregroundColor(Color(hex: "FF6605"))
                    Text(practitioner.email)
                        .font(.custom("Montserrat-Regular", size: 14))
                }
            }

            Spacer()

            // Right section: vertical action buttons
            PractitionerActionColumn()
            
        }
        .padding()
        .background(Color.white)
        .cornerRadius(6)
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
        VStack(spacing: 24) {
            // Horizontal date cards
            HStack(spacing: 16) {
                DateCardView(title: "Start Date", date: startDate)
                DateCardView(title: "End Date", date: endDate)
            }
            

            // Practitioner list
            ForEach(practitioners) { practitioner in
                PractitionerCardView(practitioner: practitioner) {
                                    onCardTap(practitioner)
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
                        .frame(width: 40, height: 40)
                }
            }
        }
        .background(
            RoundedCorners(color: Color(hex: "FF6605"), tl: 10, tr: 0, bl: 0, br: 10)
        )
    }
}
