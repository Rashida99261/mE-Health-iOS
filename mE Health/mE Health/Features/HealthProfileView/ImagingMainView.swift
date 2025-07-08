//
//  ImagingMainView.swift
//  mE Health
//
//  Created by Rashida on 7/07/25.
//

import SwiftUI

struct ImagingDummyData: Identifiable, Equatable {
    let id: UUID = UUID()
    let title: String
    let hospitalNAme: String
    let dateValue: String
    let diagnosisValue: String
}


struct ImagingMainView: View {

    let imaging: ImagingDummyData
    let onTap: () -> Void
        
        
        var body: some View {

                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(imaging.title)
                            .font(.custom("Montserrat-Medium", size: 16))
                            .foregroundColor(.black)
                        Spacer()
                        
                        Text("Final")
                            .font(.caption)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 4)
                            .background(Color.green.opacity(0.2))
                            .foregroundColor(.green)
                            .clipShape(Capsule())

                        
                    }
                    .padding(.top,12)
                    .padding(.horizontal,12)

                    Text(imaging.hospitalNAme)
                        .font(.custom("Montserrat-Regular", size: 13))
                        .foregroundColor(.black)
                        .padding(.horizontal,12)
                    
                    Text(imaging.dateValue)
                        .font(.custom("Montserrat-Regular", size: 13))
                        .foregroundColor(.black)
                        .padding(.horizontal,12)

                    Text(imaging.diagnosisValue)
                        .font(.custom("Montserrat-Medium", size: 16))
                        .foregroundColor(.black)
                        .padding(.horizontal,12)

                    
                    Button(action: onTap) {
                        Text("View Details")
                            .font(.custom("Montserrat-Bold", size: 14))
                            .foregroundColor(.white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color(hex: "FF6605"))
                            .cornerRadius(20)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.bottom, 12)
                    .padding(.horizontal,12)

                }
                .padding(.leading, 12)
                .background(Color.white)
                .cornerRadius(8)
                .shadow(radius: 4)

            
        }

}

struct ImagingSectionView: View {

    let arrayImaging: [ImagingDummyData]
    var onCardTap: (ImagingDummyData) -> Void
    
    var body: some View {
        
        VStack(spacing: 20) {
            // Horizontal date cards
            
            if arrayImaging.isEmpty {
                NoDataView()
            } else {
                ForEach(arrayImaging) { data in
                    ImagingMainView(imaging: data) {
                        onCardTap(data)
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}
