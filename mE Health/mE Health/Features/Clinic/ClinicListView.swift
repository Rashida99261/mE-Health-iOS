//
//  ClinicListView.swift
//  mE Health
//
//  Created by Rashida on 4/06/25.
//

import SwiftUI
import ComposableArchitecture

// MARK: - Clinic Model
struct Clinic: Identifiable {
    let id = UUID()
    let name: String
    let iconName: String
    let count : String
}

// MARK: - Clinic Card View
struct ClinicCard: View {
    let clinic: Clinic

    var body: some View {
        VStack {

            Spacer()

            Image(clinic.iconName)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)

            Text(clinic.name)
                .foregroundColor(.black)
                .font(.custom("Montserrat-Bold", size: 10))
                .padding(.top, 8)
            
            Text(clinic.count)
                .foregroundColor(Color(hex: "FB531C"))
                .font(.custom("Montserrat-Bold", size: 13))
                .padding(.top, 8)


            Spacer()
        }
        .frame(height: 150)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 5)
        .padding(4)
    }
}

// MARK: - Clinic List View
struct ClinicListView: View {
    @State private var searchText = ""
    @State private var selectedClinic: Clinic?
    
    // Dummy Data
    let clinics = [
        Clinic(name: "Abkhazia", iconName: "country_placeholder", count: "26"),
        Clinic(name: "Cuba", iconName: "country_placeholder", count: "10"),
        Clinic(name: "Malaysia", iconName: "country_placeholder", count: "31"),
        Clinic(name: "Massachusetts", iconName: "country_placeholder", count: "54"),
        Clinic(name: "United Kingdom", iconName: "country_placeholder", count: "54"),
        Clinic(name: "Zimbabwe", iconName: "country_placeholder", count: "54"),
        Clinic(name: "Abkhazia", iconName: "country_placeholder", count: "26"),
        Clinic(name: "Cuba", iconName: "country_placeholder", count: "10")
    ]
    
    var filteredClinics: [Clinic] {
        if searchText.isEmpty {
            return clinics
        } else {
            return clinics.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }

    // 2-column grid layout
    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                Text("Connect to Your Provider")
                    .font(.custom("Montserrat-Bold", size: 34))
                    .padding(.horizontal)
                
                // Search Bar
                TextField("Search by Name , City or Country", text: $searchText)
                    .padding(10)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                // Grid List
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(filteredClinics) { clinic in
                            ClinicCard(clinic: clinic)
                                .onTapGesture {
                                    // Handle tap (e.g., navigation)
                                    print("Tapped on \(clinic.name)")
                                    selectedClinic = clinic
                                    
                                }
                        }
                    }
                    .padding(.horizontal)
                }
                NavigationLink(
                    destination: selectedClinic.map {
                        
                        ClinicDetailListView(
                            store: Store(
                                initialState: ClinicDetailFeature.State(),
                                reducer: {
                                    ClinicDetailFeature()
                                }
                            ), title: $0.name
                        )
                    },
                    isActive: Binding(
                        get: { selectedClinic != nil },
                        set: { if !$0 { selectedClinic = nil } }
                    )
                ) {
                    EmptyView()
                }
            }
            .padding(.top)
        }
    }
}

#Preview {
    ClinicListView()
}
