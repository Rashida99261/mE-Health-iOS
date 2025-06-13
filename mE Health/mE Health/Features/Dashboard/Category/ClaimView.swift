//
//  ClaimView.swift
//  mE Health
//
//  Created by //# Author(s): Ishant  on 12/06/25.
//

import SwiftUI
import ComposableArchitecture

struct ClaimView: View {
    
    let store: StoreOf<AllergyFeature>
    
    var body: some View {
        
        WithViewStore(store, observe: { $0 }) { viewStore in
            NavigationView {
                ScrollView {
                    if viewStore.isLoading {
                        ProgressView("Loading Claim Data...")
                    } else {
                        
                        
                        VStack(alignment: .leading, spacing: 16) {
                            Text("No Claim Data")
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding(.bottom, 8)

                            Spacer()
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color(.systemBackground))
                                .shadow(color: .gray.opacity(0.2), radius: 10, x: 0, y: 5)
                        )
                        .padding()
                    }
                }
                .navigationTitle("ClaimView")
            }
            .onAppear {
                viewStore.send(.loadAllergy)
            }

        }
    }

    @ViewBuilder
    private func conditionRow(title: String, value: String, icon: String) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 24, height: 24)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Text(value)
                    .font(.body)
                    .fontWeight(.medium)
            }
        }
        .padding(.vertical, 4)
    }
}



