//
//  AssistCardView.swift
//  mE Health
//
//  Created by Rashida on 25/06/25.
//

import SwiftUI

struct AssistData: Identifiable, Equatable {
    let id: UUID = UUID()
    let name: String
}


struct AssistCardView: View {
    
    let assist: AssistData
    let onTap: () -> Void
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            
            HStack(alignment: .top, spacing: 12) {
                
                Text(assist.name)
                    .font(.custom("Montserrat-Bold", size: 16))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                    .lineSpacing(4)
                
                Spacer()
                
                Image("right_arrow")


            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.white)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(hex: "FF6605"), lineWidth: 1.5) // Orange border
        )
        .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 2)
        .contentShape(Rectangle()) // Ensures whole card is tappable if needed
        .onTapGesture {
            onTap()
        }

      


    }
}
