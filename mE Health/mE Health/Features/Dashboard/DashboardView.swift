//
//  DashboardView.swift
//  mE Health
//
//  # =============================================================================
//# mEinstein - CONFIDENTIAL
//#
//# Copyright ©️ 2025 mEinstein Inc. All Rights Reserved.
//#
//# NOTICE: All information contained herein is and remains the property of
//# mEinstein Inc. The intellectual and technical concepts contained herein are
//# proprietary to mEinstein Inc. and may be covered by U.S. and foreign patents,
//# patents in process, and are protected by trade secret or copyright law.
//#
//# Dissemination of this information, or reproduction of this material,
//# is strictly forbidden unless prior written permission is obtained from
//# mEinstein Inc.
//#
//# Author(s): Ishant 
//# ============================================================================= on 22/05/25.
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
            .alert(
                isPresented: viewStore.binding(
                    get: \.showErrorAlert,
                    send: .alertDismissed
                )
            ) {
                Alert(title: Text("Patient Data Saved"), message: Text(viewStore.errorMessage), dismissButton: .default(Text("OK")))
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


