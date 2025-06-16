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
    @State private var selectedItem: PersonaItem?

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack(alignment: .leading) {
                Text("My Persona")
                    .font(.custom("Montserrat-Bold", size: 32))
                    .padding(.horizontal)
                    .padding(.top, 32)

                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(viewStore.items) { item in
                            Button(action: {
                                viewStore.send(.itemTapped(item.destination))
                            }) {
                                PersonaCardView(item: item)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.top)
                }
            }
            .background(Color.white)
            .navigationBarBackButtonHidden(true) // allow system back
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    CustomBackButton {
                        viewStore.send(.dismissNavigation)
                    }
                }
            }
            .navigationDestination(
                isPresented: viewStore.binding(
                    get: { $0.selectedDestination != nil },
                    send: .dismissNavigation
                )
            ) {
                switch viewStore.selectedDestination {
                case .patientProfile:
                    PatientProfileView(
                        store: Store(initialState: PatientProfileFeature.State(), reducer: {
                            PatientProfileFeature()
                        })
                    )
                case .myHealth:
                    MyHealthView(
                        store: Store(
                            initialState: MyHealthFeature.State(),
                            reducer: {
                                MyHealthFeature()
                            }
                        )
                    )
                case .none:
                    EmptyView()
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

struct PersonaCardView: View {
    let item: PersonaItem

    var body: some View {
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

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
                .padding(.trailing, 12)
        }
        .frame(height: 80)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
        .padding(.horizontal)
    }
}
