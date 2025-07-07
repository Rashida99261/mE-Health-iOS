//
//  AdviceCardView.swift
//  mE Health
//
//  Created by Rashida on 23/06/25.
//


import Foundation
import SwiftUI

struct AdviceData: Identifiable, Equatable {
    let id: UUID = UUID()
    let name: String
    let description: String
    let date: String
}

struct AdviceCardView: View {
    let advice: AdviceData
    let onTap: () -> Void

    var body: some View {
        HStack(spacing: 4) {
            VStack(alignment: .leading, spacing: 12) {
                Text(advice.name)
                    .font(.custom("Montserrat-Bold", size: 18))
                    .padding(.top,12)
                
                HStack(alignment: .top, spacing: 12) {
                    
                    Rectangle()
                        .fill(Color(hex: "FF6605"))
                        .frame(width: 5)
                        .padding(.bottom,2)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        
                        Text(advice.description)
                            .font(.custom("Montserrat-Regular", size: 10))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.leading) // or .center, but not justified
                            .lineSpacing(4)

                        Spacer()

                        HStack(spacing: 8) {
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Read more")
                                    .font(.custom("Montserrat-SemiBold", size: 12))
                                    .foregroundColor(Color(hex: "FF6605"))
                                
                                Text(advice.date)
                                    .font(.custom("Montserrat-Bold", size: 15))
                                    .foregroundColor(Color(hex: "FF6605"))

                            }
                            
                            Rectangle()
                                .fill((Color(hex: "BFC2D1")))
                                .frame(width: 1)
                                .padding([.top,.bottom],8)

                            
                            Image("eyeclose")
                            .frame(width: 32, height: 32)

                        }
                    }
                }


          
                
            }
            .padding(.leading,16)

            Spacer()
            
            AdviceActionColumn()
                .frame(height:150)
                .padding(.trailing, 0)
            
                
        }
        .padding(.leading, 12)
        .frame(height:180)
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 4)
        .onTapGesture {
            onTap()
        }
    }
}


struct AdviceActionColumn: View {
    let icons = ["Edit", "delete", "Schedule","Post"]

    var body: some View {
        VStack(spacing: 1) {
            ForEach(icons, id: \.self) { icon in
                Button(action: {
                    // Handle tap
                }) {
                    Image(icon)
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.white)
                        .frame(width: 18, height: 18)
                        .padding()
                        .frame(width: 45, height: 45)
                        .background(Color(hex: "FF6605"))
                }
            }
        }
        .padding(.trailing,0)
        .frame(width: 45) // Fixed width for the action column
        .background(
            RoundedCorners(color: Color.white, tl: 0, tr: 12, bl: 12, br: 0)
        )
    }
}
