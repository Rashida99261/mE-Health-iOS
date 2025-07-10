//
//  BillingView.swift
//  mE Health
//
//  Created by Rashida on 23/06/25.
//

import SwiftUI
import Foundation

struct ClaimResponse: Codable {
    let claims: [BillingItem]
}


struct BillingItem: Identifiable, Equatable, Codable {
    var id: String { claimId }
    let claimId: String
    let totalAmount: Double
    let totalCurrency: String
    let status: String
    let createdDate: String
    let insuranceRaw: String
    let patientId: String
    let organizationId: String
    let createdAt: String
    let updatedAt: String
    
    var formattedCreatedDate: String {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime]

        if let date = isoFormatter.date(from: createdDate) {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            return formatter.string(from: date)
        }
        return createdDate
    }

    enum CodingKeys: String, CodingKey {
        case claimId, totalAmount, totalCurrency, status, createdDate
        case insuranceRaw = "insurance"
        case patientId, organizationId, createdAt, updatedAt
    }

    // Computed property to decode `insurance` JSON string
    var insurance: InsuranceInfo? {
        guard let data = insuranceRaw.data(using: .utf8) else { return nil }
        return try? JSONDecoder().decode(InsuranceInfo.self, from: data)
    }
}

struct InsuranceInfo: Codable {
    let sequence: Int
    let focal: Bool
    let coverage: CoverageReference
}

struct CoverageReference: Codable {
    let reference: String
    let display: String
}


struct BillingCardView: View {
    let claim: BillingItem
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
                        Text(claim.insurance?.coverage.display ?? "Unknown")
                            .font(.custom("Montserrat-Bold", size: 18))
                            .foregroundColor(.black)

                        Text(claim.formattedCreatedDate)
                            .font(.custom("Montserrat-Regular", size: 16))
                            .foregroundColor(.gray)
                    }

                    Spacer()

                    VStack(alignment: .trailing, spacing: 4) {
                        // This VStack has trailing alignment for the pill
                        VStack(spacing: 4) {
                            Text(claim.status.uppercased())
                                .font(.custom("Montserrat-Semibold", size: 12))
                                .foregroundColor(Color(hex: "F09C00"))
                                .padding(.horizontal, 12)
                                .padding(.vertical, 4)
                                .background(Color(hex: "F09C00").opacity(0.1))
                                .cornerRadius(12)

                            // Center the amount inside the width of the pill above
                            Text("$\(formatAmount(claim.totalAmount))")
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
    
    func formatAmount(_ amount: Double) -> String {
        String(format: "%.2f", amount)
    }


}

struct BillingSectionView: View {
    let items: [BillingItem]
    var onCardTap: (BillingItem) -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            
            if items.isEmpty {
                        NoDataView()
            } else {
                ForEach(items) { item in
                    BillingCardView(claim: item) {
                        onCardTap(item)
                    }
                }
            }

        }
        .padding(.horizontal)
    }

}

