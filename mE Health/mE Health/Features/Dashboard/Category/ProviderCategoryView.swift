//
//  ProviderCategoryView.swift
//  mE Health
//
//  Created by Rashida on 22/05/25.
//

import SwiftUI
import ComposableArchitecture

struct ProviderCategoryView: View {
    
    let store: StoreOf<ProviderCategoryFeature>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            NavigationView {
                ScrollView {
                    if viewStore.isLoading {
                        ProgressView("Loading Providers...")
                    } else {
                        
                        let name = viewStore.patient?.name?.first?.text ?? "Unknown"  //
                        let speciality = viewStore.practitioner?.display ?? "Unknown"
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Provider Details")
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding(.bottom, 8)

                            providerRow(title: "Name", value: name, icon: "person.fill")
                            providerRow(title: "Specialty", value: speciality, icon: "stethoscope")
                            providerRow(title: "Last Visit", value: "Oct 15, 2024", icon: "calendar.badge.clock")

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
                .navigationTitle("Providers")

            }
        }
    }

    @ViewBuilder
    private func providerRow(title: String, value: String, icon: String) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.green)
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

    let patientJSON = """
    {
      "resourceType": "Patient",
      "id": "mock-patient",
      "generalPractitioner": [
        { "reference": "Practitioner/123" }
      ]
    }
    """.data(using: .utf8)!
    let mockPatient = try! JSONDecoder().decode(Patient.self, from: patientJSON)
        ProviderCategoryView(
            store: Store(
                initialState: ProviderCategoryFeature.State(patient: mockPatient),
                reducer: {
                    ProviderCategoryFeature()
                }
            )
        )
}
