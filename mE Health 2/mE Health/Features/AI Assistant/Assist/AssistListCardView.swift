//
//  AssistListCardView.swift
//  mE Health
//
//  Created by Rashida on 26/06/25.
//
import SwiftUI

struct AssistListData: Identifiable, Equatable {
    let id: UUID = UUID()
    let dateRange: String
    let category: String
    let time: String
}



struct AssistListCardView: View {
    let assistData: AssistListData
    let onTap: () -> Void

    var body: some View {
        HStack(spacing: 4) {
            VStack(alignment: .leading, spacing: 12) {
                
                HStack(spacing: 0) {
                    Text("Date Range:")
                        .font(.custom("Montserrat-Bold", size: 14))
                    Text(assistData.dateRange)
                        .font(.custom("Montserrat-Bold", size: 16))
                }
                
                HStack(spacing: 0) {
                    Text("Category:")
                        .font(.custom("Montserrat-Bold", size: 14))
                    Text(assistData.category)
                        .font(.custom("Montserrat-Regular", size: 12))
                }

                Text(assistData.time)
                    .font(.custom("Montserrat-Regular", size: 12))

                                
            }

            Spacer()
            
            AssistColumn()
                .frame(height:100)
                .padding(.trailing, 0)
        }
        .padding(.leading, 12)
        .frame(height:100)
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 4)
        .onTapGesture {
            onTap()
        }
    }
}





struct AssistColumn: View {
    let icons = ["envelope.fill", "phone.fill"]

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

