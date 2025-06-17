//
//  MyHealthView.swift
//  mE Health
//
//  Created by Ishant on 16/06/25.
//

import SwiftUI
import ComposableArchitecture

struct MyHealthView: View {
    let store: StoreOf<MyHealthFeature>
    
    var samplePractioner : [PractitionerData] = [
        PractitionerData(name: "Dr. Ashley David", specialty: "Gynecologist", phone: "(212) 555-1234", email: "info@totalcaremaintenance.com"),
        PractitionerData(name: "Dr. Ashley David", specialty: "Gynecologist", phone: "(212) 555-1234", email: "info@totalcaremaintenance.com")]

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack(alignment: .leading, spacing: 16) {
                Text("My Health")
                    .font(.custom("Montserrat-Bold", size: 32))
                    .padding(.horizontal)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(viewStore.tiles.indices, id: \.self) { index in
                            let tile = viewStore.tiles[index]

                            MyHealthTileView(
                                icon: tile.icon,
                                title: tile.title,
                                countItem : tile.countItem,
                                isSelected: viewStore.selectedIndex == index
                            )
                            .onTapGesture {
                                viewStore.send(.selectTile(index), animation: .easeInOut(duration: 0.3))
                            }
                        }
                    }
                    .frame(height:180)
                    .padding(.horizontal)
                }
                
                Divider()
                
                
                let selectedTileTitle = viewStore.tiles[viewStore.selectedIndex].title
                switch selectedTileTitle {
                case "Practitioner":
                    PractitionerSectionView(
                        practitioners: samplePractioner, // Replace with state-driven data
                        startDate: "06-01-2025",
                        endDate: "06-16-2025",
                        onCardTap: { practitioner in
                            viewStore.send(.practitionerTapped(practitioner))
                        }

                    )

                case "Conditions":
                    Text("Conditions Section") // Replace with ConditionsView

                case "Medication":
                    Text("Medication Section")

                default:
                    EmptyView()
                }

            }
            .padding(.top, 8)
            
            .navigationDestination(
                isPresented: viewStore.binding(
                    get: { $0.selectedPractitioner != nil },
                    send: .dismissPractitionerDetail
                )
            ) {
                if let selected = viewStore.selectedPractitioner {
                    PractitionerDetailView(practitioner: selected)
                }
            }

            
        }
    }
}

struct MyHealthTileView: View {
    let icon: String
    let title: String
    let countItem : String
    let isSelected: Bool

    var body: some View {
        VStack(spacing: 12) {
            
            Text(title)
                .font(.custom("Montserrat-Bold", size: 12))
                .foregroundColor(.black)
            
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .foregroundColor(Color(hex: "FF6605"))

            Text(countItem)
                .font(.custom("Montserrat-Bold", size: 10))
                .foregroundColor(.black)
            

            // Selection Indicator Line
            if isSelected {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color(hex: "FF6605"))
                    .frame(height: 10)
                    .padding(.horizontal, 12)
            }
            else {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color(hex: "6E6B78"))
                    .frame(height: 10)
                    .padding(.horizontal, 12)
            }

            
            
        }
        .frame(width: 110, height: isSelected ? 170 : 130)
        .background(Color.white)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(isSelected ? Color(hex: "FF6605") : Color.clear, lineWidth: 2)
        )
        .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
        .animation(.easeInOut(duration: 0.3), value: isSelected)
    }
}


#Preview {
    MyHealthView(
        store: Store(
            initialState: MyHealthFeature.State(),
            reducer: {
                MyHealthFeature()
            }
        )
    )
}
