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
                
                ZStack {
                    VStack {
                        
                        Spacer()
                        
                        VStack(spacing: 24) {
                            Text("How can I help you today?")
                                .font(.title)
                                .fontWeight(.bold)
                            
                            Spacer()
                            
                            CardButton(title: "AI Assistant", iconName: "sparkles", gradientColors: [.orange, .yellow])
                            CardButton(title: "Data Marketplace", iconName: "cart", gradientColors: [.orange, .yellow])
                            
                            Spacer()
                           
                        }
                        
                        Spacer()
                    }

                    VStack {
                        Spacer()
                        CustomTabBar(selectedTab: viewStore.binding(
                                                get: \.selectedTab,
                                                send: DashboardFeature.Action.tabSelected
                                            ))
                    }
                }
                .edgesIgnoringSafeArea(.bottom)
                .background(Color.white)
                .onAppear {
                    viewStore.send(.onAppear)  // ✅ Trigger the reducer case
                }
                
            }
            .navigationBarBackButtonHidden(true)
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
    
    
    
    struct CardButton: View {
        let title: String
        let iconName: String
        let gradientColors: [Color]
        
        var body: some View {
            HStack {
                
                LinearGradient(
                    gradient: Gradient(colors: [Color(hex: "FB531C"), Color(hex: "F79E2D")]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .frame(width: 32)
                .cornerRadius(5)
                
                Spacer()
                
                Text(title)
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Image(systemName: iconName)
                    .foregroundColor(Color(hex: "FB531C"))
                    .padding(.trailing)
            }
            .frame(height: 80)
            .background(Color.black)
            .cornerRadius(12)
            .shadow(radius: 5)
            .padding(.horizontal)
        }
    }
