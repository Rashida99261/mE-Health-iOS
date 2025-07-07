//
//  AssistView.swift
//  mE Health
//
//  Created by Rashida on 25/06/25.
//

import SwiftUI
import ComposableArchitecture

struct AssistView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var navigateToDetail = false
    @Dependency(\.assitAdviceClient) var client
    
    @State private var assistItems: [AssistData] = []
    @State private var isLoading = false
    @State private var errorMessage: String?


    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 16) {
                Text("Health")
                    .font(.custom("Montserrat-Bold", size: 34))
                    .padding(.horizontal)

                if isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                } else if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                } else {
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 24) {
                            ForEach(assistItems) { item in
                                AssistCardView(assist: item) {
                                    withAnimation {
                                        navigateToDetail = true
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.top)
                }

                NavigationLink(
                    destination: AssistDetailView(),
                    isActive: $navigateToDetail
                ) {
                    EmptyView()
                }
            }
            .background(Color(hex: "F5F5FC").ignoresSafeArea())
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    CustomBackButton {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
        .task {
            await loadAssistItems()
        }
    }

    private func loadAssistItems() async {
        isLoading = true
        defer { isLoading = false }

        do {
            let response = try await client.getAssistList(
                AssistRequest(application: "Health") // or dynamic
            )
            assistItems = response.data ?? []
        } catch {
            errorMessage = "Failed to load assist items."
            print("API error:", error)
        }
    }

//    private func loadAssistItemsStatic() async {
//            assistItems = [
//                AssistDummyData(name: "Chronic Condition Detector"),
//                AssistDummyData(name: "Preventive Care Advisor"),
//                AssistDummyData(name: "Medication Adherence Risk Predictor"),
//                AssistDummyData(name: "Social Determinants of Health (SDoH) Estimator"),
//                AssistDummyData(name: "Polypharmacy Risk Detector"),
//                AssistDummyData(name: "Gaps in Care Identifier"),
//                AssistDummyData(name: "Behavioral Health Risk Estimator"),
//                AssistDummyData(name: "Health Goal Interpreter"),
//                AssistDummyData(name: "Date Range Handler"),
//                AssistDummyData(name: "Imaging Based Condition Validator"),
//                AssistDummyData(name: "Imaging Trend Analyzer")
//            ]
//        
//    }
}


#Preview {
    AssistView()
}
