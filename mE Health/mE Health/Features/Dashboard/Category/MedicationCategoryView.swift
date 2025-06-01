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
                        ProgressView("Loading Medical Data...")
                    } else {
                        
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Medical Details")
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding(.bottom, 8)
                            
                            let resourceObj = viewStore.medicationModel?.entry?.first?.resource
                            let name = resourceObj?.courseOfTherapyType?.text ?? "Unknown"  //
                            let dosage = resourceObj?.dosageInstruction?.first?.text ?? "Unknown"
                            let route = resourceObj?.dosageInstruction?.first?.route?.text ?? "Unknown"
                            let frequency = resourceObj?.dosageInstruction?.first?.timing?.Repeat?.count ?? 0
                            let requester = resourceObj?.requester?.display ?? "Unknown"
                            let noOfRepeat = resourceObj?.dispenseRequest?.numberOfRepeatsAllowed ?? 0
                            
                            medicationRow(title: "Medication Name", value: name, icon: "waveform.path.ecg.fill")
                            medicationRow(title: "Dosage", value: dosage, icon: "calendar.badge.clock")
                            medicationRow(title: "Frequency", value: "\(frequency) days repeat", icon: "waveform.path.ecg")
                            medicationRow(title: "Route", value: route, icon: "calendar")
                            medicationRow(title: "RxNorm Code", value: "", icon: "info.circle")
                            medicationRow(title: "Prescriber", value: requester, icon: "info.circle")
                            medicationRow(title: "Refills", value: "numberOfRepeatsAllowed : \(noOfRepeat)", icon: "info.circle")
                            
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
            .onAppear {
                viewStore.send(.loadMedication)
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
