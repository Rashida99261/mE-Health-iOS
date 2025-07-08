//
//  ConditionListView.swift
//  mE Health
//
//  Created by Rashida on 27/06/25.
//

import SwiftUI

struct ConditionDummyData: Identifiable, Equatable {
    let id: UUID = UUID()
    let name: String
    let date: String
    let status: ConditionStatus?
}

enum ConditionStatus: String {
    case active = "Active"
    case resolved = "Resolved"
}



struct ConditionListView: View {

    let condition: ConditionDummyData
    let onTap: () -> Void
        
        
        var body: some View {

                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(condition.name)
                            .font(.custom("Montserrat-Bold", size: 18))
                            .foregroundColor(.black)
                        Spacer()
                        
                        if condition.status ==  .active {
                            
                            Text("Active")
                                .font(.custom("Montserrat-SemiBold", size: 9))
                                .padding(.horizontal, 12)
                                .padding(.vertical, 4)
                                .background(Color(hex: "06C270").opacity(0.2))
                                .foregroundColor(Color(hex: "06C270"))
                                .clipShape(Capsule())

                        }
                        else if condition.status ==  .resolved {
                            Text("Resolved")
                                .font(.custom("Montserrat-SemiBold", size: 9))
                                .padding(.horizontal, 12)
                                .padding(.vertical, 4)
                                .background(Color(hex: "A811C7").opacity(0.2))
                                .foregroundColor(Color(hex: "A811C7"))
                                .clipShape(Capsule())
                        }
                    }
                    .padding(.top,12)
                    .padding(.horizontal,12)

                    Text(condition.date)
                        .font(.custom("Montserrat-Regular", size: 16))
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

struct ConditionSectionView: View {
    let conditions: [ConditionDummyData]
    var onCardTap: (ConditionDummyData) -> Void
    
    var body: some View {
        
        VStack(spacing: 20) {
            if conditions.isEmpty {
                        NoDataView()
            } else {
                ForEach(conditions) { condition in
                    ConditionListView(condition: condition) {
                        onCardTap(condition)
                    }
                }
            }
        }
        .padding(.horizontal)

    }
}
