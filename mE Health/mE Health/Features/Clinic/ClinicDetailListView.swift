//
//  ClinicDetailListView.swift
//  mE Health
//
import SwiftUI
import ComposableArchitecture

struct ClinicDetailListView: View {
    
    let store: StoreOf<ClinicDetailFeature>
    let title: String
    @State private var selectedTab = 0
    @State private var searchText = ""
    
    let tabs = ["All", "Recent", "Connected"]
    @State private var selectedIndex = 0
    

    
    var body: some View {
        
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack(spacing: 12) {
                // Title
                Text(title)
                    .font(.custom("Montserrat-Bold", size: 34))
                    .padding(.top)
                
                // Segmented Control
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color(hex: "FF6605"), lineWidth: 2)
                        .frame(height: 45)
                    
                    // Orange background that slides behind selected tab
                    GeometryReader { geo in
                        let tabWidth = geo.size.width / CGFloat(tabs.count)
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(hex: "FF6605"))
                            .frame(width: tabWidth - 4, height: 41)
                            .offset(x: CGFloat(selectedTab) * tabWidth + 2, y: 2)
                            .animation(.easeInOut(duration: 0.25), value: selectedTab)
                    }
                    .frame(height: 45)
                    
                    // Tab Buttons
                    HStack(spacing: 0) {
                        ForEach(tabs.indices, id: \.self) { index in
                            Button(action: {
                                selectedTab = index
                            }) {
                                Text(tabs[index])
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .foregroundColor(selectedTab == index ? .white : .black)
                                    .font(.custom("Montserrat-SemiBold", size: 16))
                            }
                        }
                    }
                }
                .frame(height: 45)
                .padding(.horizontal)
                
                let filteredPractices = (viewStore.practicesData ?? []).filter {
                    searchText.isEmpty || ($0.practice_name?.localizedCaseInsensitiveContains(searchText) ?? false)
                }

                
                // Search Bar
                CustomSearchBar(text: $searchText)
                
                // List of items (for selected tab)
                List(filteredPractices, id: \.practice_name) { item in
                        ClinicDetailCard(
                            practiceObj: item,
                            onConnect: {
                                viewStore.send(.onTapConnect)
                            },
                            isConnected: viewStore.isConnected
                        )
                        .listRowInsets(EdgeInsets())
                        .padding(.vertical, 4)
                    }
                    .listStyle(PlainListStyle())
            }
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                viewStore.send(.onDetailAppear)
            }

        }
    }

}

// MARK: - List Item Card
struct ClinicDetailCard: View {
    
    let practiceObj: PracticesModelData
    var onConnect: () -> Void
    var isConnected: Bool

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // Clinic image
            
            if let logoURL = practiceObj.logo_url, let url = URL(string: logoURL) {
                AsyncImage(url: url) { image in
                    image.resizable()
                } placeholder: {
                    Image("Cambridge")
                        .resizable()
                }
                .scaledToFit()
                .frame(width: 110, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.leading, 8)
            } else {
                Image("Cambridge")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 110, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.leading, 8)

            }


            VStack(alignment: .leading, spacing: 8) {
                ZStack(alignment: .topTrailing) {
                    // Title and connect button
                    VStack(alignment: .leading, spacing: 8) {
                        Text(practiceObj.practice_name ?? "Cleveland Clinic London")
                            .font(.custom("Montserrat-Bold", size: 20))
                            .foregroundColor(.primary)

                        Button(action: {
                            if !isConnected { onConnect() }
                        }) {
                            Text(isConnected ? "Disconnect" : "Connect")
                                .font(.custom("Montserrat-SemiBold", size: 10))
                                .foregroundColor(.white)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 6)
                                .background(Color(hex: "FF6605"))
                                .cornerRadius(8)
                        }
                        .disabled(isConnected)
                    }

                }
            }

            Spacer()
        }
        .frame(height: 132)
        .padding(12)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 1)
        .padding(.horizontal)
    }
}

#Preview {
    ClinicDetailListView(
        store: Store(
            initialState: ClinicDetailFeature.State(),
            reducer: {
                ClinicDetailFeature()
            }
        ), title: ""
    )
}
