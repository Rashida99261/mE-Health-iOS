//
//  PersonaView.swift
//  mE Health
//

import SwiftUI
import ComposableArchitecture

import SwiftUI
import ComposableArchitecture

struct PersonaView: View {
    let store: StoreOf<PersonaFeature>

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
            .onAppear {
                //viewStore.send(.callApi)
            }

            .background(Color.white)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    CustomBackButton {
                        viewStore.send(.navigateBackToHomeTapped)
                    }
                }
            }
            .navigationDestination(
                item: viewStore.binding(
                    get: \.selectedDestination,
                    send: { _ in .dismissDestination }
                )
            ) { destination in
                switch destination {
                case .patientProfile:
                    PatientProfileView(
                        store: Store(
                            initialState: PatientProfileFeature.State(),
                            reducer: { PatientProfileFeature() }
                        )
                    )
                case .myHealth:
                    MyHealthView(
                        store: Store(
                            initialState: MyHealthFeature.State(),
                            reducer: { MyHealthFeature() }
                        )
                    )
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
        )
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
