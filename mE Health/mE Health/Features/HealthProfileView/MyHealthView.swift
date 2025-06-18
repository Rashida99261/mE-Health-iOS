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
    @Environment(\.presentationMode) var presentationMode
    
    var samplePractioner : [PractitionerData] = [
        PractitionerData(name: "Dr. Ashley David", specialty: "Gynecologist", phone: "(212) 555-1234", email: "info@totalcaremaintenance.com"),
        PractitionerData(name: "Dr. Ashley David", specialty: "Gynecologist", phone: "(212) 555-1234", email: "info@totalcaremaintenance.com")]
    
    var sampleAppoitmnt : [AppointmentData] = [
        AppointmentData(drName: "Dr. David Joe", hospitalName: "Hospital name", dateTime: "11 Jun 2025,03:30 PM - 4:00 PM", description: "Based on your recent activity and climate, here’s personalized guidance on your daily water intake to stay hydrated and healthy."),
        AppointmentData(drName: "Dr. David Joe", hospitalName: "Hospital name", dateTime: "11 Jun 2025,03:30 PM - 4:00 PM", description: "Based on your recent activity and climate, here’s personalized guidance on your daily water intake to stay hydrated and healthy."),
        AppointmentData(drName: "Dr. David Joe", hospitalName: "Hospital name", dateTime: "11 Jun 2025,03:30 PM - 4:00 PM", description: "Based on your recent activity and climate, here’s personalized guidance on your daily water intake to stay hydrated and healthy.")]
    
    var sampleAleData : [AllergyDummyData] = [
        AllergyDummyData(name: "Peanut Allergy", recordDate: "Recorded Date: 05/06/2025"),
        AllergyDummyData(name: "Dust Allergy", recordDate: "Recorded Date: 05/06/2025"),
        AllergyDummyData(name: "Penicillin Allergy", recordDate: "Recorded Date: 05/06/2025")
        ]
        
    var sampleLabData : [LabDummyData] = [
            LabDummyData(name: "Complete Blood Count", recordDate: "Recorded Date: 05/06/2025",isActive:true),
            LabDummyData(name: "Lipid Panel", recordDate: "Recorded Date: 12/06/2025",isActive:false),
            LabDummyData(name: "Lipid Panel", recordDate: "Recorded Date: 12/06/2025",isActive:true)
    ]
    
    var sampleImmubeData : [ImmuneDummyData] = [
        ImmuneDummyData(name: "COVID-19 Vaccine", recordDate: "Occurrence Date: N/A", location: "Location: N/A", isCompleted: false),
        ImmuneDummyData(name: "COVID-19 Vaccine", recordDate: "Occurrence Date: N/A", location: "Location: N/A", isCompleted: true),
        ImmuneDummyData(name: "COVID-19 Vaccine", recordDate: "Occurrence Date: N/A", location: "Location: N/A", isCompleted: true)
    ]
    
    

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

                case "Appointment":
                    AppoitmentSectionView(
                        practitioners: sampleAppoitmnt,
                        startDate: "06-01-2025", 
                        endDate: "06-01-2025",
                        onCardTap:{ practitioner in }
                        )
                case "Allergy":
                    AllergySectionView(allergies: sampleAleData, startDate: "06-01-2025", endDate: "06-01-2025", onCardTap: { allergy in
                        viewStore.send(.allergyTapped(allergy))
                    })
                case "Lab":
                    LabSectionView(labs: sampleLabData, startDate: "06-01-2025", endDate: "06-01-2025", onCardTap: { lab in
                    })
                case "Immunizations":
                    ImmuneSectionView(immune: sampleImmubeData, startDate: "06-01-2025", endDate: "06-01-2025", onCardTap: { lab in
                    })
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
            
            .navigationDestination(
                isPresented: viewStore.binding(
                    get: { $0.selelctedAllergy != nil },
                    send: .dismissAllergyDetail
                )
            ) {
                if let selected = viewStore.selelctedAllergy {
                    AllergyDetailView(allergy: selected)
                }
            }
            
            .background(Color.white)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    CustomBackButton {
                        presentationMode.wrappedValue.dismiss()
                    }
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
                .font(.custom("Montserrat-Bold", size: 9))
                .foregroundColor(.black)
            
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: 22, height: 22)
                .foregroundColor(Color(hex: "FF6605"))

            Text(countItem)
                .font(.custom("Montserrat-Bold", size: 9))
                .foregroundColor(.black)
            

            // Selection Indicator Line
            if isSelected {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color(hex: "FF6605"))
                    .frame(width:58)
                    .frame(height: 6)
                    .padding(.horizontal, 8)
            }
            else {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color(hex: "6E6B78"))
                    .frame(width:58)
                    .frame(height: 6)
                    .padding(.horizontal, 8)
            }

            
            
        }
        .frame(width: 102, height: isSelected ? 168 : 133)
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
