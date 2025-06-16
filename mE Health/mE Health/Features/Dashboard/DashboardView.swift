import SwiftUI
import SwiftUICore
import ComposableArchitecture

struct DashboardView: View {
    let store: StoreOf<DashboardFeature>
    let sideMenuWidth: CGFloat = 100.0
    @State private var showOverlay = false
    @State private var isAIAssistantActive = false
    @State private var isClinicListActive = false
    @State private var isMenuOpen: Bool = false
    
    private let loginStore = Store(initialState: LoginFeature.State()) {
        LoginFeature()
    }

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            NavigationStack {
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        
                        // MARK: Side Menu
                        SideMenuView(
                            selectedTab: viewStore.selectedMenuTab,
                            onItemTap: { tab in
                                viewStore.send(.tabMenuItemSelected(tab))
                                viewStore.send(.toggleMenu(false))
                            }
                        )
                        .frame(width: 150)
                        .offset(x: viewStore.showMenu ? 0 : -150)
                        .animation(.easeInOut(duration: 0.3), value: viewStore.showMenu)
                        .zIndex(1)
                        
                        // MARK: Dimmed Tap Area
                        if viewStore.showMenu {
                            Color.black.opacity(0.4)
                                .ignoresSafeArea()
                                .onTapGesture {
                                    viewStore.send(.toggleMenu(false))
                                }
                                .offset(x: 150)
                                .zIndex(1.1)
                        }
                        
                        // MARK: Main Content (Sliding)
                        VStack(spacing: 0) {
                            Text("How can I help you today?")
                                .font(.custom("Montserrat-Bold", size: 24))
                                .padding(.top, 64)
                            
                            Spacer()
                            
                            VStack(spacing: 24) {
                                CardButton(title: "AI Assistant", iconName: "AI", gradientColors: [Color(hex: "FB531C"), Color(hex: "F79E2D")]) {
                                    showOverlay = true
                                }
                                
                                CardButton(title: "Data Marketplace", iconName: "shopping_cart", gradientColors: [Color(hex: "FB531C"), Color(hex: "F79E2D")]) {}
                                
                                CardButton(title: "Clinic List", iconName: "shopping_cart", gradientColors: [Color(hex: "FB531C"), Color(hex: "F79E2D")]) {
                                    isClinicListActive = true
                                }
                                
                                
                                
                                NavigationLink(
                                    destination: ClinicListView(
                                        store: Store(
                                            initialState: ClinicFeature.State(),
                                            reducer: { ClinicFeature() }
                                        )
                                    ),
                                    isActive: $isClinicListActive
                                ) {
                                    EmptyView()
                                }
                            }
                            .padding(.horizontal, 0)
                            
                            Spacer()
                            
                            // Reserve space for tab bar
                            Spacer().frame(height: 60)
                        }
                        .padding(.horizontal)
                        .background(Color.white.ignoresSafeArea())
                        .offset(x: viewStore.showMenu ? 150 : 0) // 👈 Slide only this
                        .animation(.easeInOut, value: viewStore.showMenu)
                        .zIndex(2)
                        
                        
                        if showOverlay {
                            ZStack {
                                Color.black.opacity(0.4)
                                    .ignoresSafeArea()

                                VStack(spacing: 24) {
                                    Text("""
                                    The AI Assistant in mEinstein is your personal, intelligent helper that lives right in the app. It’s designed to understand your preferences, habits, and goals—then use that knowledge to help you make decisions, organize your life, and find insights that matter to you. Think of it as a digital sidekick, always ready to offer suggestions, reminders, and personalized advice to help you get the most out of your data and daily routines.
                                    """)
                                    .font(.custom("Montserrat-SemiBold", size: 14))
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(.black)
                                        .padding()
                                    

                                    Button(action: {
                                        withAnimation {
                                            
                                            showOverlay = false
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                                isAIAssistantActive = true
                                            }
                                    }) {
                                        Text("OK")
                                            .font(.custom("Montserrat-Bold", size: 20))
                                            .foregroundColor(.blue)
                                            .frame(maxWidth: .infinity)
                                    }
                                }
                                .padding(.vertical, 32)
                                .padding(.horizontal, 16)
                                .background(Color.white)
                                .cornerRadius(20)
                                .shadow(radius: 10)
                                .padding(.horizontal, 32)
                            }
                            .zIndex(99)
                            .transition(.opacity)
                            .animation(.easeInOut, value: showOverlay)
                        }
                        NavigationLink(
                            destination: AIAssistantView(),
                            isActive: $isAIAssistantActive
                        ) {
                            EmptyView()
                        }


                        
                        // MARK: Fixed Tab Bar (NOT sliding)
                        VStack {
                            Spacer()
                            CustomTabBar(
                                selectedTab: viewStore.binding(
                                    get: \.selectedTab,
                                    send: DashboardFeature.Action.tabSelected
                                ),
                                onMenuTapped: {
                                    if viewStore.selectedTab == .menu {
                                        viewStore.send(.toggleMenu(!viewStore.showMenu))
                                       } else {
                                           viewStore.send(.tabSelected(.menu))
                                       }
                                },
                                onDashboardTapped: {
                                    viewStore.send(.showDashboardList(true))

                                }
                            )
                            .ignoresSafeArea(edges: .bottom)
                        }
                        .zIndex(3) // Keep it above everything
                    }
                    .onAppear {
                        viewStore.send(.onAppear)
                    }
                    .navigationBarBackButtonHidden(true)
                }
                
            }
            
            .navigationDestination(
                isPresented: viewStore.binding(
                    get: \.showDashboardList,
                    send: DashboardFeature.Action.showDashboardList
                )
            ) {
                DashboardViewList(
                    store: Store(
                        initialState: DashboardListFeature.State(),
                        reducer: {
                            DashboardListFeature()
                        }
                    )
                )
            }

            
            .navigationDestination(
                isPresented: viewStore.binding(
                    get: { $0.personaState != nil },
                    send: { isPresented in
                        isPresented ? .onAppear : .personaAction(.navigateBackToHomeTapped)
                    }
                )
            ) {
                IfLetStore(
                    store.scope(state: \.personaState, action: DashboardFeature.Action.personaAction)
                ) { personaStore in
                    PersonaView(
                        store: personaStore,
                        selectedTab: viewStore.binding(get: \.selectedTab, send: DashboardFeature.Action.tabSelected),
                        onMenuTapped: {
                            isMenuOpen.toggle()
                            viewStore.send(.toggleMenu(isMenuOpen))
                        }
                    )
                }
            }
            
            .navigationDestination(
                isPresented: viewStore.binding(
                    get: { $0.personaSelectedDestination != nil },
                    send: { _ in .setPersonaSelectedDestination(nil) }
                )
            ) {
                switch viewStore.personaSelectedDestination {
                case .myHealth:
                    MyHealthView(store: Store(initialState: MyHealthFeature.State(), reducer: {
                        MyHealthFeature()
                    }))
                case .patientProfile:
                    PatientProfileView(store: Store(initialState: PatientProfileFeature.State(), reducer: {
                        PatientProfileFeature()
                    }))
                case .none:
                    EmptyView()
                }
            }


            .navigationDestination(
                item: viewStore.binding(
                    get: \.navigationDestination,
                    send: DashboardFeature.Action.navigationDestinationChanged
                )
            ) { destination in
                switch destination {
                case .login:
                    LoginView(store: loginStore)
                }
            }


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
    let action: () -> Void // Add this

    var body: some View {
        Button(action: action) {
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
                        .font(.custom("Montserrat-Bold", size: 18))
                }
                
                Spacer()
                
                // Trailing icon
                Image(iconName)
                    .padding(.trailing, 12)
            }
            .frame(height: 80)
            .background(Color.black)
            .cornerRadius(12)
            .shadow(radius: 5)
            .padding(.horizontal)
        }
    }
}
