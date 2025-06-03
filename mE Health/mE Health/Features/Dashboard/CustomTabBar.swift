//
//  CustomTabBar.swift
//  mE Health
//

import SwiftUI
import ComposableArchitecture

//struct CustomTabBar: View {
//    let store: StoreOf<DashboardFeature>
//
//    var body: some View {
//        WithViewStore(store, observe: \.selectedTab) { viewStore in
//            HStack {
//                // Left Tab
//                TabButton(tab: .menu, icon: "house", viewStore: viewStore)
//
//                Spacer()
//
//                // Center Tab (Bigger)
//                Button(action: {
//                    viewStore.send(.tabSelected(.voice))
//                }) {
//                    Image(systemName: "plus")
//                        .font(.system(size: 28, weight: .bold))
//                        .foregroundColor(.white)
//                        .frame(width: 60, height: 60)
//                        .background(Color.accentColor)
//                        .clipShape(Circle())
//                        .shadow(radius: 4)
//                }
//                .offset(y: -20)
//
//                Spacer()
//
//                // Right Tab
//                TabButton(tab: .dashboard, icon: "gear", viewStore: viewStore)
//            }
//            .padding(.horizontal, 40)
//            .padding(.top, 10)
//            .padding(.bottom, 30)
//            .background(Color.white.shadow(radius: 5))
//        }
//    }
//}

struct CustomTabBar: View {
    @Binding var selectedTab: DashboardTab

    var body: some View {
        ZStack {
            HStack {
                TabItem(
                    icon: "house",
                    title: "Menu",
                    isSelected: selectedTab == .menu,
                    action: { selectedTab = .menu }
                )

                Spacer()

                TabItem(
                    icon: "slider.horizontal.3",
                    title: "Dashboard",
                    isSelected: selectedTab == .dashboard,
                    action: { selectedTab = .dashboard }
                )
            }
            .padding(.horizontal, 32)
            .padding(.top, 10)
            .frame(height: 70)
            .background(Color.white.shadow(radius: 5))

            Button(action: {
                selectedTab = .voice
            }) {
                ZStack {
                    Circle()
                        .fill(LinearGradient(colors: [Color(hex: "FB531C"), Color(hex: "F79E2D")], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(width: 70, height: 70)
                        .shadow(radius: 4)

                    Image(systemName: "mic.circle.fill")
                        .resizable()
                        .foregroundColor(.white)
                        .frame(width: 30, height: 30)
                }
            }
            .offset(y: -35)
        }
    }
}


//struct TabButton: View {
//    let tab: Tab
//    let icon: String
//    let viewStore: ViewStore<Tab, DashboardFeature.Action>
//
//    var body: some View {
//        Button(action: {
//            viewStore.send(.tabSelected(tab))
//        }) {
//            Image(systemName: icon)
//                .font(.system(size: 22))
//                .foregroundColor(viewStore.state == tab ? .accentColor : .gray)
//        }
//    }
//}

struct TabItem: View {
    let icon: String
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(isSelected ? Color(hex: "FB531C") : .gray)
                Text(title)
                    .font(.caption)
                    .foregroundColor(isSelected ? Color(hex: "FB531C") : .gray)
            }
        }
    }
}
