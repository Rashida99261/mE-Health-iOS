//
//  VitalDetailView.swift
//  mE Health
//
//  Created by Rashida on 27/06/25.
//

import SwiftUI
import ComposableArchitecture

struct VitalDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
            ZStack {
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(spacing: 24) {
                        
                        // Title
                        Text("Details")
                            .font(.custom("Montserrat-Bold", size: 32))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                        
                        TopCardView(title: "Blood pressure panel", subtitle: "140/90 mmHg", desc: "July 1, 2021 at 02:00 pm")
                            .padding(.horizontal)
                        
                        
                        BottomDetailCardView()
                            .padding(.horizontal)
                        


                        VStack(alignment: .leading, spacing: 12) {
                            
                            HStack(spacing: 8) {
                                Text("Visits Status")
                                    .font(.custom("Montserrat-Bold", size: 17))
                                    .foregroundColor(.black)
                                
                                Spacer()
                                
                                Text("In-progress")
                                    .font(.caption)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 4)
                                    .background(Color.blue.opacity(0.2))
                                    .foregroundColor(.blue)
                                    .clipShape(Capsule())
                                
                            }

                            
                            Text("Start Date: 1/07/2021")
                                .font(.custom("Montserrat-SemiBold", size: 13))

                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 2)
                        .padding(.horizontal)



                        Spacer()

                        // Bottom Buttons
                        ActionButtonsView(title: "Sync Data")

                        Button(action: {
                            
                        }) {
                            Text("Log New Vital")
                                .font(.custom("Montserrat-SemiBold", size: 16))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .frame(height:45)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(Color(hex: "FF6605"))
                                .cornerRadius(32)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.horizontal,12)

                        
                        Spacer()

                    }
                }
                .padding(.top)
                .background(Color.white.ignoresSafeArea())
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



struct BottomDetailCardView: View {
    
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            
            HStack(alignment: .top, spacing: 12) {
                
                Rectangle()
                    .fill(Color(hex: "FF6605"))
                    .frame(width: 5)
                    .padding(.bottom,2)
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text("Details")
                        .font(.custom("Montserrat-Bold", size: 17))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading) // or .center, but not justified
                        .lineSpacing(4)

                    HStack(spacing: 8) {
                        
                        Text("Patient Name")
                            .font(.custom("Montserrat-Regular", size: 13))
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        Text("Prithwi Thakuria")
                            .font(.custom("Montserrat-SemiBold", size: 13))
                            .foregroundColor(.black)

                    }
                    
                    HStack(spacing: 8) {
                        Text("Vital ID")
                            .font(.custom("Montserrat-Regular", size: 13))
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        Text("obs-85354-9")
                            .font(.custom("Montserrat-SemiBold", size: 13))
                            .foregroundColor(.black)

                    }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 2)
      


    }
}
