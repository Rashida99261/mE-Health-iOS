//
//  DateCardView.swift
//  mE Health
//
//  Created by Ishant on 16/06/25.
//

import SwiftUI
struct DateCardView: View {
    let title: String
    let date: String

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.custom("Montserrat-Bold", size: 16))

            HStack(spacing: 8) {
                Image("anniversary")
                    .foregroundColor(Color(hex: "FF6605"))
                
                VStack(alignment: .leading, spacing: 6) {
                    
                    Text(date)
                        .font(.custom("Montserrat-Medium", size: 14))
                    
                    Rectangle()
                        .fill(Color(hex: "FF6605"))
                        .frame(height: 2)
                }
            }

            
        }
        .padding()
        .background(Color.white)
        .cornerRadius(6)
        .shadow(radius: 6)
        .frame(height:80)
    }
}

