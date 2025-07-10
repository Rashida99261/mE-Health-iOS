//
//  BillingDetailView.swift
//  mE Health
//
//  Created by Rashida on 1/07/25.
//
import SwiftUI

struct BillingDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    let billing: BillingItem

    var body: some View {
        
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(spacing: 24) {
                    
                    // Title
                    Text("Billing")
                        .font(.custom("Montserrat-Bold", size: 32))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    
                    BillingCardView(claim: billing){
                    }
                    .padding(.horizontal)
                    

                    VStack(alignment: .leading, spacing: 12) {
                        HStack(spacing: 24) {
                            Rectangle()
                                .fill(Color(hex: "FF6605"))
                                .frame(width: 5)
                                .frame(height:90)
                                .padding(.leading, 6)
                          
                            VStack(alignment: .leading, spacing: 12) {
                                
                                Text("Insurance Details")
                                    .font(.custom("Montserrat-Bold", size: 19))
                                    .padding(.leading, 4)
                                
                                HStack {
                                    Text("Insurance Company")
                                        .font(.custom("Montserrat-Regular", size: 12))
                                    Spacer()
                                    Text("Blue Cross Blue Shield")
                                        .font(.custom("Montserrat-Medium", size: 12))
                                }
                                
                                HStack {
                                    Text("Coverage Type")
                                        .font(.custom("Montserrat-Regular", size: 12))
                                    Spacer()
                                    Text("Primary")
                                        .font(.custom("Montserrat-Medium", size: 12))
                                }
                                
                                HStack {
                                    Text("Plan ID")
                                        .font(.custom("Montserrat-Regular", size: 12))
                                    Spacer()
                                    Text("BCBS-2023-456")
                                        .font(.custom("Montserrat-Medium", size: 12))
                                }

                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color.white) // Light blue background
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
                    .padding(.horizontal)
                    
                    
                    Spacer()
                    
                    // Bottom Buttons
                    ActionButtonsView(title: "Sync Data")
                        .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 2)


                    Button(action: {
                        
                    }) {
                        Text("View Invoice")
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
                    .padding(.horizontal,24)

                    
                    Spacer()

                }
                .padding(.horizontal,8)
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
