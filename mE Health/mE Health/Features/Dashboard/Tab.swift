
enum DashboardTab: Equatable {
    case menu
    case voice
    case dashboard
}

import SwiftUI

struct MainLayout<Content: View>: View {
    @Binding var selectedTab: DashboardTab
    @Binding var showMenu: Bool
    let selectedMenuTab: SideMenuTab
    let onMenuItemTap: (SideMenuTab) -> Void
    let content: Content

    init(
        selectedTab: Binding<DashboardTab>,
        showMenu: Binding<Bool>,
        selectedMenuTab: SideMenuTab,
        onMenuItemTap: @escaping (SideMenuTab) -> Void,
        @ViewBuilder content: () -> Content
    ) {
        self._selectedTab = selectedTab
        self._showMenu = showMenu
        self.selectedMenuTab = selectedMenuTab
        self.onMenuItemTap = onMenuItemTap
        self.content = content()
    }

    var body: some View {
        ZStack(alignment: .leading) {
            // Side menu
            SideMenuView(
                selectedTab: selectedMenuTab,
                onItemTap: { tab in
                    onMenuItemTap(tab)
                }
            )
            .frame(width: 150)
            .offset(x: showMenu ? 0 : -150)
            .animation(.easeInOut, value: showMenu)
            .zIndex(1)

            // Dimmed overlay
            if showMenu {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        showMenu = false
                    }
                    .offset(x: 150)
                    .zIndex(1.1)
            }

            // Main content
            VStack(spacing: 0) {
                content
                Spacer().frame(height: 60) // space for tab bar
            }
           // .background(Color(UIColor.systemGray6))
            .background(Color(UIColor.systemGray6).ignoresSafeArea())
            .offset(x: showMenu ? 150 : 0)
            .animation(.easeInOut, value: showMenu)
            .zIndex(2)

            // Tab bar
            VStack {
                Spacer()
                CustomTabBar(
                    selectedTab: $selectedTab,
                    onMenuTapped: {
                        if selectedTab == .menu {
                            showMenu.toggle()
                        } else {
                            selectedTab = .menu
                        }
                    },
                    onDashboardTapped: {
                        selectedTab = .dashboard
                        showMenu = false
                    }
                )
                .ignoresSafeArea(edges: .bottom)
            }
            .zIndex(3)
        }
    }
}

