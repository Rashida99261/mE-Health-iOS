//
//  AdviceFilterView.swift
//  mE Health
//
//  Created by Rashida on 23/06/25.
//
import Foundation
import SwiftUI

enum FilterOption: String, CaseIterable, Identifiable {
    case all = "All"
    case fav = "Fav"
    case ignore = "Ignore"
    case review = "Review"
    case read = "Read"
    case unread = "Unread"

    var id: String { rawValue }

    var iconName: String {
        switch self {
        case .all: return "Filter_fill"
        case .fav: return "Like"
        case .ignore: return "Ignore"
        case .review: return "filter"
        case .read: return "tick"
        case .unread: return "married"
        }
    }
}

struct AdviceFilterView: View {
    @Binding var selectedFilters: Set<FilterOption>
    @Environment(\.dismiss) var dismiss
    

    var body: some View {
        ZStack(alignment: .top) {
            // Main background
            Color.white.ignoresSafeArea()

            VStack(spacing: 0) {
                // Top bar with Back button
                HStack {
                    
                    Button(action: {
                        dismiss()
                    }) {
                        HStack(spacing: 4) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 17, weight: .medium))
                            Text("Back")
                                .font(.custom("Montserrat-Semibold", size: 16))
                        }
                        .foregroundColor(Color(hex: Constants.API.PrimaryColorHex))
                    }
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.bottom, 12)
                .background(Color.white)

                Spacer()
                
                // Filter container
                VStack(spacing: 24) {
                    ForEach(FilterOption.allCases) { option in
                        HStack {
                            Image(option.iconName)
                                .foregroundColor(Color(hex: Constants.API.PrimaryColorHex))

                            Text(option.rawValue)
                                .font(.custom("Montserrat-Medium", size: 16))

                            Spacer()

                            Image(systemName: selectedFilters.contains(option) ? "checkmark.square.fill" : "square")
                                .foregroundColor(selectedFilters.contains(option) ? Color(hex: Constants.API.PrimaryColorHex) : .gray)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.white)
                                .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 2)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(option == .fav && selectedFilters.contains(option) ? Color.purple : Color.clear, lineWidth: 0)
                                )
                        )
                        .onTapGesture {
                            if selectedFilters.contains(option) {
                                selectedFilters.remove(option)
                            } else {
                                selectedFilters.insert(option)
                            }
                        }
                    }
                }
                .padding()
                .padding(.leading,24)
                .padding(.trailing,24)
                .padding(.top,32)
                .padding(.bottom,32)
                .background(
                    RoundedCorner(radius: 32, corners: [.topLeft, .topRight])
                        .fill(Color(hex: "#F5F5FB"))
                        .ignoresSafeArea(edges: .bottom)
                )
            }

        }
    }
}

