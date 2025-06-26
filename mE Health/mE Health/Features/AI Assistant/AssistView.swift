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
    
    let assistItem = [
        AssistData(name: "Chronic Condition Detector"),
        AssistData(name: "Preventive Care Advisor"),
        AssistData(name: "Medication Adherence Risk Predictor"),
        AssistData(name: "Social Determinants of Health (SDoH) Estimator"),
        AssistData(name: "Social Determinants of Health (SDoH) Estimator"),
        AssistData(name: "Social Determinants of Health (SDoH) Estimator"),
        AssistData(name: "Polypharmacy Risk Detector"),
        AssistData(name: "Gaps in Care Identifier"),
        AssistData(name: "Behavioral Health Risk Estimator")]

    
    var body: some View {
            ZStack {
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("Health")
                        .font(.custom("Montserrat-Bold", size: 34))
                        .padding(.horizontal)

                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 24) {
                            ForEach(assistItem) { item in
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
                    NavigationLink(
                        destination: AssistDetailView()
                    ,
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

    }
}


#Preview {
    AssistView()
}
