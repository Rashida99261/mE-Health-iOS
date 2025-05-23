//
//  LabObservationView.swift
//  mE Health
//
//  Created by Rashida on 23/05/25.
//

import SwiftUI
import ComposableArchitecture

struct LabObservationView: View {
    
    let store: StoreOf<LabObservationFeature>
    
    var body: some View {
        
        WithViewStore(store, observe: { $0 }) { viewStore in
            NavigationView {
                ScrollView {
                    if viewStore.isLoading {
                        ProgressView("Loading Providers...")
                    } else {
                        
                        let issueObj = viewStore.labModel?.entry?.first?.resource?.issue?.first
                        let name = issueObj?.code ?? "Unknown"  //
                        let codeLoin = issueObj?.details?.coding?.first?.code ?? ""

                        VStack(alignment: .leading, spacing: 16) {
                            Text("Condition Details")
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding(.bottom, 8)
                            
                            conditionRow(title: "Test Name", value: name, icon: "lungs.fill")
                            conditionRow(title: "Value", value: "Not Available", icon: "calendar.badge.clock")
                            conditionRow(title: "Units", value: "Not Available", icon: "waveform.path.ecg")
                            conditionRow(title: "Date", value: "20 Oct 2022", icon: "calendar")
                            conditionRow(title: "LOINC Code", value: codeLoin, icon: "info.circle")
                            conditionRow(title: "Normal Range", value: "Not Available", icon: "info.circle")
                            conditionRow(title: "Interpretation", value: "Not Available", icon: "info.circle")
                            conditionRow(title: "Source", value: "Not Available", icon: "info.circle")
                            
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


struct VitalObservationView: View {
    
    let store: StoreOf<VitalsObservationFeature>
    
    var body: some View {
        
        WithViewStore(store, observe: { $0 }) { viewStore in
            NavigationView {
                ScrollView {
                    if viewStore.isLoading {
                        ProgressView("Loading Providers...")
                    } else {
                        
                        
                        let issueObj = viewStore.vitalModel?.entry?.first?.resource?.issue?.first
                        let name = issueObj?.code ?? "Unknown"  //
                        let codeLoin = issueObj?.details?.coding?.first?.code ?? ""

                        
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Condition Details")
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding(.bottom, 8)
                            
                            conditionRow(title: "Test Name", value: name, icon: "lungs.fill")
                            conditionRow(title: "Value", value: "Not Available", icon: "calendar.badge.clock")
                            conditionRow(title: "Units", value: "Not Available", icon: "waveform.path.ecg")
                            conditionRow(title: "Date", value: "Not Available", icon: "calendar")
                            conditionRow(title: "LOINC Code", value: codeLoin, icon: "info.circle")
                            conditionRow(title: "Normal Range", value: "Not Available", icon: "info.circle")
                            conditionRow(title: "Interpretation", value: "Not Available", icon: "info.circle")
                            conditionRow(title: "Source", value: "Not Available", icon: "info.circle")
                            
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
