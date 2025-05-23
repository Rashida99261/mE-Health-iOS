//
//  MedicationCategoryView.swift
//  mE Health
//
//  Created by Rashida on 22/05/25.
//


import SwiftUI
import ComposableArchitecture


struct MedicationCategoryView: View {
    
    let store: StoreOf<MedicationFeature>
    
    var body: some View {
        
        WithViewStore(store, observe: { $0 }) { viewStore in
            NavigationView {
                ScrollView {
                    
                    if viewStore.isLoading {
                        ProgressView("Loading Providers...")
                    } else {
                        
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Condition Details")
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding(.bottom, 8)
                            
                            medicationRow(title: "Medication Name", value: "2 (two) times a day with meals", icon: "waveform.path.ecg.fill")
                            medicationRow(title: "Dosage", value: "Take 1 tablet (125 mcg total) by mouth 1 (one) time each day., Starting Mon 4/29/2019, Until Tue 4/28/2020, Print", icon: "calendar.badge.clock")
                            medicationRow(title: "Frequency", value: "365 days repeat", icon: "waveform.path.ecg")
                            medicationRow(title: "Route", value: "Oral", icon: "calendar")
                            medicationRow(title: "RxNorm Code", value: "", icon: "info.circle")
                            medicationRow(title: "Prescriber", value: "Physician", icon: "info.circle")
                            medicationRow(title: "Refills", value: "numberOfRepeatsAllowed : 11", icon: "info.circle")
                            
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
    private func medicationRow(title: String, value: String, icon: String) -> some View {
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
    MedicationCategoryView(
        store: Store(
            initialState: MedicationFeature.State(),
            reducer: {
                MedicationFeature()
            }
        )
    )
}
