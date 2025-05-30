//
//  ConsentView.swift
//  mE Health
//
//  Created by Rashida on 23/05/25.
//

import SwiftUI
import ComposableArchitecture


struct ConsentView: View {
    
    let store: StoreOf<ConsentFeature>
    
    var body: some View {
        
        WithViewStore(store, observe: { $0 }) { viewStore in
            NavigationView {
                ScrollView {
                    if viewStore.isLoading {
                        ProgressView("Loading Providers...")
                    } else {
                        
//                        let respourceObj = viewStore.consentModel?.entry?.first?.resource
//                        let name = respourceObj?.code?.text ?? "Unknown"  //
//                        let onsetDate = respourceObj?.onsetDateTime ?? "Unknown"
//                        let status = respourceObj?.clinicalStatus?.text ?? "Unknown"
//                        let recordedDate = respourceObj?.recordedDate ?? "Unknown"

                        VStack(alignment: .leading, spacing: 16) {
                            Text("Condition Details")
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding(.bottom, 8)
                            
                            conditionRow(title: "Data Category", value: "Not Available", icon: "lungs.fill")
                            conditionRow(title: "Consent Status", value: "Not Available", icon: "calendar.badge.clock")
                            conditionRow(title: "Consent Type", value: "Active",icon: "waveform.path.ecg")
                            conditionRow(title: "Expiry Date", value: "Not Available", icon: "calendar")
                            conditionRow(title: "Last Modified", value: "urn:oid:1.2.840.114350.1.13.0.1.7.2.657369", icon: "info.circle")
                            
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
                .navigationTitle("Condition")
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

#Preview {
    ConsentView(
        store: Store(
            initialState: ConsentFeature.State(),
            reducer: {
                ConsentFeature()
            }
        )
    )
}
