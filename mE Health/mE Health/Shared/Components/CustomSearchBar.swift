//
//  CustomSearchBar.swift
//  mE Health
//

import SwiftUI

struct CustomSearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color(hex: "FF6605"))
                .padding(.leading, 8)

            TextField("Search by Name, City or Country", text: $text)
                .font(.custom("Montserrat-Regular", size: 14))
                .padding(.vertical, 10)
                .padding(.horizontal, 4)
        }
        .frame(height: 50) // 👈 Fixed height
        .background(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(hex: "FF6605"), lineWidth: 1.5)
        )
        .cornerRadius(10)
        .padding(.horizontal)
    }
}
