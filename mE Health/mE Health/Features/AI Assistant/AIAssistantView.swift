//
//  AIAssistantView.swift
//  mE Health
//
//  Created by Ishant on 16/06/25.
//

import SwiftUI
import SwiftUICore
import ComposableArchitecture

struct AIAssistantView: View {
    
    @State private var isAdviceViewActive = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
       
            NavigationStack {
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {

                        
                        // MARK: Main Content (Sliding)
                        VStack(spacing: 0) {
                            
                            Spacer()
                            
                            VStack(spacing: 24) {
                                CardButton(title: "Assist", iconName: "AI", gradientColors: [Color(hex: "FB531C"), Color(hex: "F79E2D")]) {
                                }
                                
                                CardButton(title: "Advice", iconName: "shopping_cart", gradientColors: [Color(hex: "FB531C"), Color(hex: "F79E2D")]) {
                                   // isAdviceViewActive = true
                                }

                                NavigationLink(
                                    destination: AdviceView()
                                ,
                                isActive: $isAdviceViewActive
                                ) {
                                    EmptyView()
                                }
                            }
                            .padding(.horizontal, 0)
                            
                            Spacer()
                            
                            // Reserve space for tab bar
                            Spacer().frame(height: 60)
                        }
                        .padding(.horizontal)
                        .background(Color.white.ignoresSafeArea())
                        .zIndex(2)
                        

                        
                    }
                    .onAppear {
                        //viewStore.send(.onAppear)
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
    }

}

#Preview {
    AIAssistantView()
    }
    
