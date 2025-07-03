//
//  Untitled.swift
//  mE Health
//
//  Created by Rashida on 20/06/25.
//
import SwiftUI
import ComposableArchitecture


struct FilterPopupView: View {
    let store: StoreOf<HeaderFeature>

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            ZStack {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .background(.ultraThinMaterial) //
                    .onTapGesture {
                        viewStore.send(.dismissSheet)
                    }

                VStack(spacing: 0) {
                    Spacer()

                    ZStack(alignment: .top) {
                        

                        
                        VStack(spacing: 20) {
                            Spacer().frame(height: 28)

                            ForEach(FilterType.allCases) { filter in
                                Button {
                                    viewStore.send(.toggleFilter(filter))
                                } label: {
                                    HStack {
                                        Image(systemName: viewStore.selectedFilters.contains(filter) ? "checkmark.square.fill" : "square")
                                            .foregroundColor(.black)
                                        Text(filter.rawValue)
                                            .foregroundColor(.black)
                                            .font(.custom("Montserrat-Regular", size: 16))
                                        Spacer()
                                    }
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(6)
                                    .shadow(color: .black.opacity(0.03), radius: 10, x: 0, y: 5)
                                }
                                .padding(.horizontal, 24)
                            }

                            Button(action: {
                                viewStore.send(.applyFilters)
                            }) {
                                Text("Apply")
                                    .foregroundColor(.white)
                                    .font(.custom("Montserrat-Bold", size: 16))
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color(hex: Constants.API.PrimaryColorHex))
                                    .cornerRadius(28)
                            }
                            .frame(width: 180, height: 45)
                            .padding(.top, 44)
                            .padding(.bottom, 32)
                            
                            Rectangle()
                                .fill(Color(hex: "F5F5FC"))
                                .frame(height: 34) // Adjust as needed to hide bottom gap
                                .ignoresSafeArea(.all, edges: .bottom)

                        }
                        .background(Color(hex: "F5F5FC"))
                        .cornerRadius(30, corners: [.topLeft, .topRight])
                        .ignoresSafeArea(.all, edges: .bottom)


                        Button(action: {
                            viewStore.send(.dismissSheet)
                        }) {
                            Image("close")
                                .frame(width: 40, height: 40)
                                .background(Color.white)
                                .clipShape(Circle())
                                .shadow(radius: 2)
                        }
                        .offset(y: -60)
                    }
                  
                }
            }
        }
    }
}

#Preview {
    FilterPopupView(
        store: Store(
            initialState: HeaderFeature.State(
                isFilterPresented: true,
                selectedFilters: []
            ),
            reducer: { HeaderFeature() }
        )
    )
}
