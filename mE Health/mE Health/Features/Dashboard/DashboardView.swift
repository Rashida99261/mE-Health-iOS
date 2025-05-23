//
//  DashboardView.swift
//  mE Health
//
//  Created by Rashida on 22/05/25.
//

import SwiftUI
import ComposableArchitecture

struct DashboardView: View {
    let store: StoreOf<DashboardFeature>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            NavigationStack {
                
                VStack {
                    if viewStore.isLoading {
                        ProgressView("Loading patient...")
                    } else if let patient = viewStore.patient {
                        VStack(alignment: .leading, spacing: 8) {
                            
                            
                            
                            //                            Text("Patient: \(patient.name?.first?.text ?? "Unknown")")
                            //                            Text("DOB: \(patient.birthDate ?? "N/A")")
                            //                            Text("Gender: \(patient.gender ?? "N/A")")
                        }
                        .padding()
                    }
                    }
                    List {
                        ForEach(HealthCategory.allCases) { category in
                            Button {
                                viewStore.send(.categoryTapped(category))
                            } label: {
                                Text(category.rawValue)
                                    .padding(.vertical, 8)
                            }
                        }
                    }
                    .navigationTitle("Health Record")
                    .sheet(
                        item: Binding(
                            get: { viewStore.selectedCategory },
                            set: { _ in viewStore.send(.categoryDetailDismissed) }
                        )
                    ) { category in
                        if let patient = viewStore.patient {
                            destinationView(for: category, patient: patient)
                    }
                    }
                }
                    .onAppear {
                            viewStore.send(.onAppear)  // ✅ Trigger the reducer case
                        }
            }
        }
        
        @ViewBuilder
        private func destinationView(for category: HealthCategory,patient: Patient) -> some View {
            switch category {
            case .providers:
                ProviderCategoryView(
                    store: Store(
                        initialState: ProviderCategoryFeature.State(patient: patient),
                        reducer: {
                            ProviderCategoryFeature()
                        }
                    )
                )
            case .conditions:
                ConditionCategoryView(
                    store: Store(
                        initialState: ConditionFeature.State(),
                        reducer: {
                            ConditionFeature()
                        }
                    )
                )
            case .medications:
                MedicationCategoryView(
                    store: Store(
                        initialState: MedicationFeature.State(),
                        reducer: {
                            MedicationFeature()
                        }
                    )
                )
            case .labs:
                LabObservationView(
                    store: Store(
                        initialState: LabObservationFeature.State(),
                        reducer: {
                            LabObservationFeature()
                        }
                    )
                )
            case .vitals:
                VitalObservationView(
                    store: Store(
                        initialState: VitalsObservationFeature.State(),
                        reducer: {
                            VitalsObservationFeature()
                        }
                    )
                )
            case .uploads:
                DocumentReferenceView(
                    store: Store(
                        initialState: ConsentFeature.State(),
                        reducer: {
                            ConsentFeature()
                        }
                    )
                )
            case .consents:
                ConsentView(
                    store: Store(
                        initialState: ConsentFeature.State(),
                        reducer: {
                            ConsentFeature()
                        }
                    )
                )
            }
        }
        
    }
    
    
    
    #Preview {
        DashboardView(
            store: Store(
                initialState: DashboardFeature.State(),
                reducer: {
                    DashboardFeature()
                }
            )
        )
    }
    
    
