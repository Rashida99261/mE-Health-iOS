import SwiftUI
import SwiftUICore
import ComposableArchitecture

struct DashboardView: View {
    let store: StoreOf<DashboardFeature>
    let sideMenuWidth: CGFloat = 100.0
    @State private var isClinicListActive = false
    @State private var isMenuOpen: Bool = false

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
                                CardButton(title: "AI Assistant", iconName: "AI", gradientColors: [Color(hex: "FB531C"), Color(hex: "F79E2D")]) {}
                                
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
                store: store.scope(state: \.$persona, action: DashboardFeature.Action.persona),
                destination: { personaStore in
                    PersonaView(
                        store: personaStore,
                        selectedTab: viewStore.binding(
                            get: \.selectedTab,
                            send: DashboardFeature.Action.tabSelected
                        ),
                        onMenuTapped: {
                            isMenuOpen.toggle()
                            viewStore.send(.toggleMenu(isMenuOpen))
                        }
                    )
                    .onDisappear {
                            viewStore.send(DashboardFeature.Action.dismissPersona)
                    }
                }
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
