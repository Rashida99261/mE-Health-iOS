//
//  HeaderView.swift
//  mE Health
//
//  Created by Rashida on 20/06/25.
//

import SwiftUI
import ComposableArchitecture

struct HeaderView: View {
    let store: StoreOf<HeaderFeature>

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack(spacing: 16) {
                HStack {
                    Text(viewStore.title)
                        .font(.custom("Montserrat-Bold", size: 20))
                        .foregroundColor(.black)

                    Spacer()

                    HStack(spacing: 16) {
                        ForEach(HeaderFeature.HeaderIcon.allCases) { icon in
                            Button {
                                viewStore.send(.iconTapped(icon))
                            } label: {
                                Image(icon.iconName)
                            }
                        }
                    }
                }
                .padding(.horizontal)

                if viewStore.isSearchVisible {
                    

                    HStack {
                        HStack(spacing: 8) {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(Color(hex: Constants.API.PrimaryColorHex))

                            TextField("Search...", text: viewStore.binding(
                                get: \.searchText,
                                send: HeaderFeature.Action.searchTextChanged
                            ))
                            .font(.custom("Montserrat-Regular", size: 14))
                            .padding(.vertical, 10)
                        }
                        .frame(height: 50)
                        .padding(.horizontal)
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(hex: Constants.API.PrimaryColorHex), lineWidth: 1.5)
                        )
                        .cornerRadius(10)

                        Button {
                            viewStore.send(.hideSearch)
                        } label: {
                            Image("close")
                        }
                        .padding(.leading, 4)
                    }
                    .padding(.horizontal)

                }
                

                
                if !viewStore.selectedFilters.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(viewStore.selectedFilters) { filter in
                                HStack(spacing: 6) {
                                    Text(filter.rawValue)
                                        .font(.custom("Montserrat-Bold", size: 13))
                                        .foregroundColor(Color.white)
                                    
                                    // Close icon button
                                    Button(action: {
                                        // Call action to remove this filter
                                        viewStore.send(.removeFilter(filter))
                                    }) {
                                        Image(systemName: "xmark.circle.fill")
                                            .font(.system(size: 14, weight: .bold))
                                            .foregroundColor(Color.white)
                                            
                                    }
                                    .buttonStyle(.plain)
                                }
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color(hex: Constants.API.PrimaryColorHex))
                                .cornerRadius(18)
                            }
                        }
                        .padding(.horizontal)
                    }
                }

            }

            .sheet(isPresented: Binding(get: {
                viewStore.isDatePickerPresented || viewStore.isUploadPresented
            }, set: { _ in
                viewStore.send(.dismissSheet)
            })) {
                if viewStore.isDatePickerPresented {
                    DatePickerView()
                } else if viewStore.isUploadPresented {
                    UploadView()
                }
            }

        }

    }
}



extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(
            RoundedCorner(radius: radius, corners: corners)
        )
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat
    var corners: UIRectCorner

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
