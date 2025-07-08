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
    @State private var startDate: Date? = nil
    @State private var endDate: Date? = nil
    @State private var isStartDatePickerPresented = false
    @State private var isEndDatePickerPresented = false
    @State private var selectedDate = Date()

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
                                    .foregroundColor(.black)
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
                
                if viewStore.isDatePickerPresented {
                    if let start = startDate, let end = endDate {
                        HStack {
                            HStack(spacing: 8) {
                                Text("Date Range: ")
                                    .font(.custom("Montserrat-Medium", size: 12))
                                    .foregroundColor(.black)

                                Text("\(formattedRange(start: start, end: end))")
                                    .font(.custom("Montserrat-Medium", size: 12))
                                    .foregroundColor(.black)
                                
                                Spacer()

                                Button(action: {
                                    // Clear selected dates
                                    isStartDatePickerPresented = false
                                    isEndDatePickerPresented = false
                                    startDate = nil
                                    endDate = nil
                                    viewStore.send(.removeDate)
                                    
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.gray)
                                }
                            }
                            .frame(height: 40)
                            .background(Color.clear)
                            .padding(.leading,4)
                        }
                        .padding(.horizontal)
                    } else {
                        // Show start and end date pickers
                        HStack(spacing: 12) {
                            Button(action: {
                                isStartDatePickerPresented = true
                            }) {
                                DateCardView(title: "Start Date", date: formattedDate(startDate))
                            }
                            .sheet(isPresented: $isStartDatePickerPresented) {
                                DatePickerModalView(
                                    title: "Start Date",
                                    isPresented: $isStartDatePickerPresented,
                                    selectedDate: Binding(
                                        get: { startDate ?? Date() },
                                        set: { startDate = $0 }
                                    ),
                                    minimumDate: nil
                                )
                            }

                            Button(action: {
                                if startDate != nil {
                                    isEndDatePickerPresented = true
                                }
                            }) {
                                DateCardView(title: "End Date", date: formattedDate(endDate))
                            }
                            .disabled(startDate == nil)
                            .opacity(startDate == nil ? 0.5 : 1.0)
                            .sheet(isPresented: $isEndDatePickerPresented) {
                                if let safeStartDate = startDate {
                                    DatePickerModalView(
                                        title: "End Date",
                                        isPresented: $isEndDatePickerPresented,
                                        selectedDate: Binding(
                                            get: { endDate ?? safeStartDate },
                                            set: {
                                                if $0 >= safeStartDate {
                                                    endDate = $0
                                                }
                                            }
                                        ),
                                        minimumDate: safeStartDate
                                    )
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }


            }

            .sheet(isPresented: Binding(get: {
                viewStore.isUploadPresented
            }, set: { _ in
                viewStore.send(.dismissSheet)
            })) {
                if viewStore.isUploadPresented {
                    UploadView()
                }
            }

        }

    }
    
    private func formattedDate(_ date: Date?) -> String {
        guard let date = date else { return "MM-DD-YYYY" }
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
    
    private func formattedRange(start: Date, end: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return "\(formatter.string(from: start)) - \(formatter.string(from: end))"
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
