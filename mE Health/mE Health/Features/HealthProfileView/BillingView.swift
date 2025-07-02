//
//  BillingView.swift
//  mE Health
//
//  Created by Rashida on 23/06/25.
//

import SwiftUI
import Foundation

struct BillingItem: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let date: String
    let amount: String
    let status: BillingStatus?
}
enum BillingStatus: String {
    case planned = "Planned"
}

struct BillingCardView: View {
    let item: BillingItem
    let onTap: () -> Void

    var body: some View {
        HStack(spacing: 0) {
            // Gradient strip on the left
            LinearGradient(
                gradient: Gradient(colors: [Color(hex: Constants.API.PrimaryColorHex),Color(hex: Constants.API.PrimaryColorHex)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(width: 8)
            .cornerRadius(2, corners: [.topRight, .bottomRight]) // optional for smoother right edge

            // Main card content
            VStack(alignment: .leading, spacing: 8) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(item.title)
                            .font(.custom("Montserrat-Bold", size: 18))
                            .foregroundColor(.black)

                        Text(item.date)
                            .font(.custom("Montserrat-Regular", size: 16))
                            .foregroundColor(.gray)
                    }

                    Spacer()

                    VStack(alignment: .trailing, spacing: 4) {
                        // This VStack has trailing alignment for the pill
                        VStack(spacing: 4) {
                            Text("Planned")
                                .font(.custom("Montserrat-Semibold", size: 12))
                                .foregroundColor(Color(hex: "F09C00"))
                                .padding(.horizontal, 12)
                                .padding(.vertical, 4)
                                .background(Color(hex: "F09C00").opacity(0.1))
                                .cornerRadius(12)

                            // Center the amount inside the width of the pill above
                            Text(item.amount)
                                .font(.custom("Montserrat-Bold", size: 16))
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                        .fixedSize() // Ensures it only takes as much space as needed
                    }
                }
            }
            .padding()
            .background(Color.white)
        }
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 4)
        .onTapGesture {
            onTap()
        }

    }
}

struct BillingSectionView: View {
    let items: [BillingItem]
    var onCardTap: (BillingItem) -> Void
    
    var body: some View {
        VStack(spacing: 12) {
            ForEach(items) { item in
                BillingCardView(item: item) {
                    onCardTap(item)
                }
            }
        }
        .padding()
    }

}

