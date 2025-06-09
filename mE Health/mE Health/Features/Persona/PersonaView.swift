//
//  PersonaView.swift
//  mE Health
//

import SwiftUI
import ComposableArchitecture

struct PersonaView: View {
    let store: StoreOf<PersonaFeature>
    @State private var isMenuOpen: Bool = false
    let selectedTab: Binding<DashboardTab>
    let onMenuTapped: () -> Void
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack(alignment: .leading) {
                
                Text("My Persona")
                    .font(.custom("Montserrat-Bold", size: 32))
                    .padding(.horizontal)
                .padding(.top, 32)

                // List
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(viewStore.items) { item in
                            Button {
                                viewStore.send(.itemTapped(item))
                            } label: {
                                HStack(spacing: 12) {
                                    // Leading gradient bar
                                    LinearGradient(
                                        gradient: Gradient(colors: [Color(hex: Constants.API.PrimaryColorHex)]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                    .frame(width: 12)
                                    .cornerRadius(5)
                                    
                                    Image(item.iconName)
                                        .foregroundColor(.orange)
                                        .font(.system(size: 22))
                                    
                                    Text(item.title)
                                        .foregroundColor(Color(hex: "777777"))
                                        .font(.custom("Montserrat-Medium", size: 17))
                                        .padding(.leading,0)
                                    
                                    Spacer()

                                    // Right arrow
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.gray)
                                        .padding(.trailing,12)
                                    
                                    
                                    

                                }
                                .frame(height: 80)
                                .background(Color.white)
                                .cornerRadius(12)
                                .shadow(radius: 5)
                                .padding(.horizontal)
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.top)
                }
//
//                Spacer()
//                
//                CustomTabBar(
//                    selectedTab: selectedTab,
//                    onMenuTapped: onMenuTapped
//                )

                .ignoresSafeArea(edges: .bottom)

            }
            .background(Color.white) // matching light background
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    CustomBackButton {
                        viewStore.send(.navigateBackToHomeTapped)
                    }
                }
            }
        }
    }
}


// MARK: - Preview

#Preview {
    PersonaView(
        store: Store(
            initialState: PersonaFeature.State(),
            reducer: {
                PersonaFeature()
            }
        ),
        selectedTab: .constant(.menu), // Provide a constant binding
        onMenuTapped: {} // Provide an empty closure for preview
    )
}
