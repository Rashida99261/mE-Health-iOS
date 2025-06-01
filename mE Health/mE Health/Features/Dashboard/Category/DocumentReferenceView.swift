//
//  DocumentReferenceView.swift
//  mE Health
//
//  Created by Rashida on 23/05/25.
//

import ComposableArchitecture
import SwiftUI

struct DocumentReferenceView: View {
    
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
                            
                            conditionRow(title: "File Name", value: "Binary/fMx3jGctXpu4WmCzzoRKrs9onxHn1NdeJINRLfKaayws4", icon: "lungs.fill")
                            conditionRow(title: "Type", value: "Not Available", icon: "calendar.badge.clock")
                            conditionRow(title: "Upload Date", value: "2020-09-05T07:57:47Z",icon: "waveform.path.ecg")
                            conditionRow(title: "Souce", value: "Not Available", icon: "calendar")
                            
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
