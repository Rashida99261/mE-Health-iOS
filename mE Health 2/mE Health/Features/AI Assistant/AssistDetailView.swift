//
//  AssistDetailView.swift
//  mE Health
//
//  Created by Rashida on 26/06/25.
//

import SwiftUI
import ComposableArchitecture

struct AssistDetailView: View {
    @State private var startDate: Date? = nil
    @State private var endDate: Date? = nil
    @State private var isStartDatePickerPresented = false
    @State private var isEndDatePickerPresented = false
    @State private var isLoading = false
    @State private var showListView = false
    
    @State private var selectedDate = Date()
    @Environment(\.presentationMode) var presentationMode
    
    let assisData : [AssistListData] = [
        
        AssistListData(dateRange: "2000-2020", category: "Chronic Conditions", time: "23-06-2025 12:19PM"),
        AssistListData(dateRange: "2000-2020", category: "Chronic Conditions", time: "23-06-2025 12:19PM"),
        AssistListData(dateRange: "2000-2020", category: "Chronic Conditions", time: "23-06-2025 12:19PM"),
        AssistListData(dateRange: "2000-2020", category: "Chronic Conditions", time: "23-06-2025 12:19PM"),
        AssistListData(dateRange: "2000-2020", category: "Chronic Conditions", time: "23-06-2025 12:19PM")
    ]


    var body: some View {
        VStack(alignment: .leading,spacing: 20) {
            // MARK: - Start Date Card
            
            Text("Chronic Condition Detector")
                .font(.custom("Montserrat-SemiBold", size: 16))
                .padding(.horizontal)
                
            HStack(spacing:12) {
                
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

                // MARK: - End Date Card
                Button(action: {
                    if startDate != nil {
                        isEndDatePickerPresented = true
                    }
                }) {
                    DateCardView(title: "End Date", date: formattedDate(endDate))
                }
                .disabled(startDate == nil)
                .opacity(startDate == nil ? 0.5 : 1.0) // Optional visual cue
                .sheet(isPresented: $isEndDatePickerPresented) {
                    if let safeStartDate = startDate {
                        DatePickerModalView(
                            title: "End Date",
                            isPresented: $isEndDatePickerPresented,
                            selectedDate: Binding(
                                get: { endDate ?? safeStartDate },
                                set: {
                                    // Validation: Only set if >= startDate
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
            
            // MARK: - Apply Button
            if !showListView {
                Button(action: {
                    isLoading = true

                    // Simulate loading
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        isLoading = false
                        showListView = true
                    }
                }) {
                    Text(isLoading ? "Loading..." : "Apply")
                        .font(.custom("Montserrat-SemiBold", size: 17))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(isApplyEnabled ? Color(hex: Constants.API.PrimaryColorHex) : Color(hex: "AAAEB3"))
                        .foregroundColor(.white)
                        .cornerRadius(32)
                        .padding(.horizontal)
                }
                .disabled(!isApplyEnabled || isLoading)
                .padding(.top, 20)
            }

            // MARK: - List View
            if showListView {
                List {
                    ForEach(assisData) { assist in
                        AssistListCardView(assistData: assist) {
                                
                        }
                    }
                    
                }
                .listStyle(.plain)
            }

            Spacer()
        }
        .padding()
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

    private var isApplyEnabled: Bool {
        startDate != nil && endDate != nil
    }

    private func formattedDate(_ date: Date?) -> String {
        guard let date = date else { return "MM-DD-YYYY" }
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}
    


    
struct AssistDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AssistDetailView()
    }
}
