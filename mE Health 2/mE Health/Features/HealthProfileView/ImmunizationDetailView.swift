//
//  .swift
//  mE Health
//
//  Created by Rashida on 29/06/25.
//

import SwiftUI
import ComposableArchitecture
import UIKit

struct ImmunizationDetailView: View {
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
                        
                        VStack(alignment: .leading, spacing: 12) {
                            
                            HStack(spacing: 8) {
                                Text("COVID-19 Booster")
                                    .font(.custom("Montserrat-Bold", size: 17))
                                    .foregroundColor(.black)
                                
                                Spacer()
                                
                                Text("Completed")
                                    .font(.caption)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 4)
                                    .background(Color.green.opacity(0.2))
                                    .foregroundColor(.green)
                                    .clipShape(Capsule())
                                
                            }

                            
                            Text("Sarah Parker")
                                .font(.custom("Montserrat-SemiBold", size: 13))
                            
                            Text("Initial Consultation")
                                .font(.custom("Montserrat-SemiBold", size: 13))


                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 2)
                        .padding(.horizontal)
                        
                        
                        VStack(alignment: .leading, spacing: 12) {
                            
                            HStack(spacing: 8) {
                                Text("Visits Status")
                                    .font(.custom("Montserrat-Bold", size: 17))
                                    .foregroundColor(.black)
                                
                                Spacer()
                                
                                Text("Completed")
                                    .font(.caption)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 4)
                                    .background(Color.green.opacity(0.2))
                                    .foregroundColor(.green)
                                    .clipShape(Capsule())
                                
                            }

                            
                            Text("Recorded Date: 06/11/2025")
                                .font(.custom("Montserrat-SemiBold", size: 13))

                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 2)
                        .padding(.horizontal)

                        VStack(alignment: .leading, spacing: 12) {
                            Text("Record Details")
                                .font(.custom("Montserrat-Bold", size: 17))

                            HStack {
                                Text("Immunization ID")
                                .font(.custom("Montserrat-Regular", size: 14))
                                Spacer()
                                Text("#IMM78901")
                                .font(.custom("Montserrat-SemiBold", size: 13))
                            }

                            HStack {
                                Text("Location")
                                .font(.custom("Montserrat-Regular", size: 14))
                                Spacer()
                                Text("Apollo Hospital")
                                .font(.custom("Montserrat-SemiBold", size: 13))
                            }

                            HStack {
                                Text("Provider")
                                .font(.custom("Montserrat-Regular", size: 14))
                                Spacer()
                                Text("Dr. Sarah Johnson")
                                    .font(.custom("Montserrat-SemiBold", size: 13))
                            }
                        }
                        .padding()
                        .background(Color.clear)
                        .cornerRadius(12)
                        .padding(.horizontal)
                        

                        // Bottom Buttons
                        ActionButtonsView(title: "Sync Data")

                        
                        Spacer()
                        
                        Button(action: {
                            
                        }) {
                            Text("Add Immunization")
                                .font(.custom("Montserrat-SemiBold", size: 16))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .frame(height:40)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(Color(hex: "FF6605"))
                                .cornerRadius(32)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.horizontal,12)


                    }
                }
                .padding(.top)
                .background(Color(UIColor.systemGray6).ignoresSafeArea())
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
    ImmunizationDetailView()
}


