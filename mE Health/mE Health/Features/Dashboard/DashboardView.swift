import SwiftUI
import ComposableArchitecture

struct DashboardView: View {
    let store: StoreOf<DashboardFeature>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            NavigationStack {
                GeometryReader { geometry in
                    ZStack {
                        Color.white.ignoresSafeArea()

                        VStack(spacing: 0) {
                            Text("How can I help you today?")
                                .font(.custom("Inter-Bold", size: 24))
                                .padding(.top, 64)

                            Spacer()

                            VStack(spacing: 24) {
                                CardButton(title: "AI Assistant", iconName: "sparkles", gradientColors: [Color(hex: "FB531C"), Color(hex: "F79E2D")])
                                CardButton(title: "Data Marketplace", iconName: "cart", gradientColors: [Color(hex: "FB531C"), Color(hex: "F79E2D")])
                            }
                            .padding(.horizontal, 24)

                            Spacer()

                            // This spacer leaves space for the tab bar
                            Spacer().frame(height: 60)
                        }

                        // Bottom Tab Bar
                        VStack {
                            Spacer()
                            
                            CustomTabBar(selectedTab: viewStore.binding(
                                get: \.selectedTab,
                                send: DashboardFeature.Action.tabSelected
                            ))
                            .ignoresSafeArea(edges: .bottom) // Crucial!
                        }
                    }
                    .onAppear {
                        viewStore.send(.onAppear)
                    }
                    .navigationBarBackButtonHidden(true)
                }
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
    
    
struct CardButton: View {
    let title: String
    let iconName: String
    let gradientColors: [Color]

    var body: some View {
        HStack(spacing: 16) {
            // Leading gradient bar
            LinearGradient(
                gradient: Gradient(colors: gradientColors),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .frame(width: 32)
            .cornerRadius(5)

            // Left-aligned text and icon
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .foregroundColor(.white)
                    .font(.custom("Inter-Bold", size: 18))
            }

            Spacer()

            // Trailing icon
            Image(systemName: iconName)
                .foregroundColor(Color(hex: "FB531C"))
                .padding(.trailing, 8)
        }
        .frame(height: 80)
        .background(Color.black)
        .cornerRadius(12)
        .shadow(radius: 5)
        .padding(.horizontal)
    }
}
