//
//  SeriesGridView.swift
//  mE Health
//
//  Created by Rashida on 7/07/25.
//

import SwiftUI

struct SeriesItem: Identifiable {
    let id = UUID()
    let title: String
    let imageName: String
    let reportType: String // "jpg" or "pdf"
    let iconType: String
}

struct SeriesGridView: View {
    let items: [SeriesItem]

    let columns = [
        GridItem(.flexible(), spacing: 24),
        GridItem(.flexible(), spacing: 24)
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("Series Preview")
                .font(.custom("Montserrat-Bold", size: 18))
                .padding(.horizontal, 12)
                .padding(.top)

            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(items) { item in
                    SeriesCardView(item: item)
                }
            }
            .padding(.horizontal, 12)
            .padding(.bottom)
        }
        .background(.clear)
        .cornerRadius(12)
        .padding(.horizontal)
    }
}


struct SeriesCardView: View {
    let item: SeriesItem

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(item.imageName)
                .resizable()
                .scaledToFill()
                .frame(width:145) // ✅ Forces full width of card
                .frame(height: 56)
                .clipped()
                .cornerRadius(10)


            Text(item.title)
                .font(.custom("Montserrat-Regular", size: 14))

            HStack(spacing: 4) {
                Image(item.iconType)
                Text("6 Image")
                    .font(.custom("Montserrat-Regular", size: 10))

                Text("Report.\(item.reportType)")
                    .font(.custom("Montserrat-Bold", size: 10))
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        .frame(maxWidth: .infinity) // 🔥 makes both grid columns equal width
    }
}


