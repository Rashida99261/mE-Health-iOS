//
//  DateCardView.swift
//  mE Health
//
//  Created by Ishant on 16/06/25.
//

import SwiftUI
import Foundation

struct DateCardView: View {
    let title: String
    let date: String

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.custom("Montserrat-Bold", size: 16))
                .foregroundColor(Color.black)

            HStack(spacing: 8) {
                Image("anniversary")
                    .foregroundColor(Color(hex: "FF6605"))
                
                VStack(alignment: .leading, spacing: 6) {
                    
                    Text(date)
                        .font(.custom("Montserrat-Medium", size: 14))
                        .foregroundColor(Color.black)
                    
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
        .frame(height:70)
    }
}

struct DatePickerModalView: View {
    let title: String
    @Binding var isPresented: Bool
    @Binding var selectedDate: Date
    var minimumDate: Date? = nil

    var dateRange: ClosedRange<Date> {
        if let min = minimumDate {
            return min...Date.distantFuture
        } else {
            return Date.distantPast...Date.distantFuture
        }
    }

    var body: some View {
        ZStack {
            // Dimmed background
            Color(hex: "F5F5FC")
                .ignoresSafeArea()
                .onTapGesture {
                    isPresented = false
                }

            VStack(spacing: 24) {

                
                Spacer()

                // Date Picker
                DatePicker(
                    "",
                    selection: $selectedDate,
                    in: dateRange,
                    displayedComponents: [.date]
                )
                .datePickerStyle(.wheel)
                .labelsHidden()
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
                .background(Color.white)
                .cornerRadius(20)
                .shadow(radius: 6)
                .accentColor(Color(hex: "FF6605"))

                Spacer()
            }
        }
        .transition(.move(edge: .bottom))
        .animation(.easeInOut, value: isPresented)
    }
}




