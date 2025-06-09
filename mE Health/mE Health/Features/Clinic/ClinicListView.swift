//
//  ClinicListView.swift
//  mE Health
//

import SwiftUI
import ComposableArchitecture


// MARK: - Clinic Card View
struct ClinicCard: View {
    let state: TopStates

    var body: some View {
        VStack {
            Spacer()

            if let logoURL = state.logo, let url = URL(string: logoURL) {
                AsyncImage(url: url) { image in
                    image.resizable()
                } placeholder: {
                    Image("country_placeholder")
                        .resizable()
                }
                .scaledToFit()
                .frame(width: 40, height: 40)
            } else {
                Image("country_placeholder")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
            }

            Text(state.state ?? "Unknown")
                .foregroundColor(.black)
                .font(.custom("Montserrat-Bold", size: 10))
                .padding(.top, 8)

            Text("\(state.count ?? 0)")
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
    
    let store: StoreOf<ClinicFeature>
    @State private var searchText = ""
    @State private var selectedClinic: TopStates?
    @Environment(\.presentationMode) var presentationMode
    // 2-column grid layout
    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        WithViewStore(store, observe: \.self) { viewStore in
            NavigationStack {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Connect to Your Provider")
                        .font(.custom("Montserrat-Bold", size: 34))
                        .padding(.horizontal)

                    // Search Bar
                    CustomSearchBar(text: $searchText)

                    // Loading View
                    if viewStore.isLoading {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                    }

                    // Grid List
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(filteredClinics(from: viewStore.stateData), id: \.state) { clinic in
                                ClinicCard(state: clinic)
                                    .onTapGesture {
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
                                ), title: $0.state ?? ""
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
                .onAppear {
                    viewStore.send(.onAppear)
                }
                .alert("Error", isPresented: .constant(viewStore.showErrorAlert)) {
                    Button("OK", role: .cancel) {}
                } message: {
                    Text(viewStore.errorMessage)
                }
                
            }
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

    func filteredClinics(from clinics: [TopStates]?) -> [TopStates] {
        guard let clinics = clinics else { return [] }

        if searchText.isEmpty {
            return clinics
        } else {
            return clinics.filter {
                ($0.state ?? "").localizedCaseInsensitiveContains(searchText)
            }
        }
    }

}

#Preview {
    ClinicListView(
        store: Store(
            initialState: ClinicFeature.State(),
            reducer: {
                ClinicFeature()
            }
        )
    )
}
