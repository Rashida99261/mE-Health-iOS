//
//  AllergyView.swift
//  mE Health
//
//  Created by Rashida on 11/06/25.
//

import SwiftUI
import ComposableArchitecture

struct AllergyView: View {
    
    let store: StoreOf<LabObservationFeature>
    
    var body: some View {
        
        WithViewStore(store, observe: { $0 }) { viewStore in
            NavigationView {
                ScrollView {
                    if viewStore.isLoading {
                        ProgressView("Loading Allergy Data...")
                    } else {
                        
                        let issueObj = viewStore.labModel?.entry?.first?.resource?.issue?.first
                        let name = issueObj?.code ?? "Unknown"  //
                        let codeLoin = issueObj?.details?.coding?.first?.code ?? ""

                        VStack(alignment: .leading, spacing: 16) {
                            Text("Loading Allergy Data")
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding(.bottom, 8)
                            
                            conditionRow(title: "AllergyId:", value: "e1Ckpez4OVoaobUMGxMonMg3", icon: "lungs.fill")
                            conditionRow(title: "Code:", value: "N0000170136", icon: "calendar.badge.clock")
                            conditionRow(title: "Clinical status:", value: "Active", icon: "waveform.path.ecg")
                            conditionRow(title: "RecordedDate:", value: "2019-04-09T18:36:36Z", icon: "calendar")

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
                .navigationTitle("Allergy")
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



