
import SwiftUI
import ComposableArchitecture



// MARK: - Clinic List View
struct AdviceView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var showOverlay = false
    
    @State private var showFilterScreen = false
    @State private var selectedFilters: Set<FilterOption> = [.all]

    @State private var selectedTab: DashboardTab = .dashboard
    @State private var showMenu: Bool = false
    @State private var selectedMenuTab: SideMenuTab = .dashboard
    @State private var navigateToSettings = false
    @State private var navigateToDashboard = false
    @State private var navigateToPersona = false
    
    let adviceItems = [
        AdviceData(name: "Health: Daily Water Intake", description: "Based on your recent activity and climate, here’s personalized guidance on your daily water intake to stay hydrated and healthy.", date: "03/24/2025"),
        AdviceData(name: "Health: Sleep Quality", description: "We analyzed your sleep patterns and have tips to improve your sleep quality for better energy, focus, and overall well-being.", date: "03/24/2025"),
        AdviceData(name: "Health: Heart Health Score", description: "Your recent heart rate data shows room for improvement. Get recommendations to maintain a strong and healthy heart.", date: "03/24/2025"),
        AdviceData(name: "Health: Nutrient Balance", description: "Your meals seem to lack essential nutrients. Here's a breakdown and suggestions to improve your diet and energy levels.", date: "03/24/2025")
    ]

    
    var body: some View {
        NavigationStack {
            ZStack {
                
                MainLayout(
                    selectedTab: $selectedTab,
                    showMenu: $showMenu,
                    selectedMenuTab: selectedMenuTab,
                    onMenuItemTap: { tab in
                        selectedMenuTab = tab
                        showMenu = false
                        // Optional: route or update state
                        if tab == .dashboard {
                            navigateToDashboard = true
                        }
                        else if tab == .settings {
                            navigateToSettings = true
                        }
                        else if tab == .persona {
                            navigateToPersona = true
                        }
                    },
                    onDashboardTabTapped: {
                            navigateToDashboard = true
                        }
                ) {
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Advice")
                            .font(.custom("Montserrat-Bold", size: 34))
                            .padding(.horizontal)
                        
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack(spacing: 24) {
                                ForEach(adviceItems) { item in
                                    AdviceCardView(advice: item) {
                                        withAnimation {
                                            showOverlay = true
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                        .padding(.top)
                    }
                    .navigationBarBackButtonHidden(true)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            CustomBackButton {
                                presentationMode.wrappedValue.dismiss()
                            }
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                showFilterScreen = true
                                
                            }) {
                                Image("filter")
                                    .foregroundColor(Color(hex: "FF6605"))
                            }
                        }
                    }
                    
                    .fullScreenCover(isPresented: $showFilterScreen) {
                        AdviceFilterView(selectedFilters: $selectedFilters)
                    }
                    
                    navigationLinks()
                }
                // MARK: - Overlay
                if showOverlay {
                    ZStack {
                        // Dimmed Background
                        Color.black.opacity(0.4)
                            .ignoresSafeArea()
                            .transition(.opacity)
                        
                        // Centered Modal with padding
                        VStack(spacing: 16) {
                            Text("""
                        Based on the data provided, here is some advice on savings ratio for your finance profile:
                        
                        1. Understand Your Financial Goals:
                        Start by identifying your short-term and long-term financial goals. Whether it's saving for a vacation, emergency fund, retirement, or any other goal, having clarity on what you are saving for will help determine your savings ratio.
                        
                        2. *Assess Your Current Financial Situation:* Review your income, expenses, assets, liabilities, and spending habits. Understanding your cash flow will give you a clear...
                        """)
                            .font(.custom("Montserrat-Semibold", size: 14))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                            .padding(.top, 24)
                            
                            Divider()
                            
                            Button(action: {
                                withAnimation {
                                    showOverlay = false
                                }
                            }) {
                                Text("OK")
                                    .font(.custom("Montserrat-Bold", size: 20))
                                    .foregroundColor(.blue)
                                    .frame(maxWidth: .infinity)
                                    .padding(.bottom, 12)
                            }
                        }
                        .padding(.vertical, 16)
                        .background(Color.white)
                        .cornerRadius(20)
                        .shadow(radius: 10)
                        .padding(.horizontal, 24) // ✅ This is now applied directly to the card
                        .transition(.scale)
                    }
                    .zIndex(10)
                }
            }
        }
    }

    @ViewBuilder
    func navigationLinks() -> some View {
        
        // ✅ Add this
              NavigationLink(
                  destination: SettingView(),
                  isActive: $navigateToSettings
              ) {
                  EmptyView()
              }
        
        NavigationLink(
            destination: DashboardView(
                store: Store(
                    initialState: DashboardFeature.State(),
                    reducer: { DashboardFeature() }
                )
            ),
            isActive: $navigateToDashboard
        ) {
            EmptyView()
        }

        NavigationLink(
            destination: PersonaView(
                store: Store(
                    initialState: PersonaFeature.State(),
                    reducer: { PersonaFeature() }
                )
            ),
            isActive: $navigateToPersona
        ) {
            EmptyView()
        }

    }
}

#Preview {
    AdviceView()
}
