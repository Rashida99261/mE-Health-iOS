//
//  AllergyDetailView.swift
//  mE Health
//
//  Created by Rashida on 18/06/25.
//

import SwiftUI

struct AllergyDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    let allergy: AllergyDummyData

    var body: some View {
        
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(spacing: 24) {
                    
                    // Title
                    Text("Allergies")
                        .font(.custom("Montserrat-Bold", size: 32))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    // Allergy Detail Card
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Dust Allergy")
                            .font(.custom("Montserrat-Bold", size: 19))

                        HStack {
                            Text("Clinical Status")
                            Spacer()
                            Text("Active")
                                .font(.custom("Montserrat-SemiBold", size: 8))
                                .padding(.vertical, 4)
                                .padding(.horizontal, 10)
                                .background(Color(hex: "06C270").opacity(0.2))
                                .foregroundColor(Color(hex: "06C270"))
                                .cornerRadius(12)
                                .frame(width: 60, height: 24)
                        }

                        HStack {
                            Text("Recorded Date")
                            .font(.custom("Montserrat-Regular", size: 14))
                            Spacer()
                            Text("Mar 15, 2024")
                            .font(.custom("Montserrat-SemiBold", size: 13))
                        }

                        HStack {
                            Text("Allergy ID")
                            .font(.custom("Montserrat-Regular", size: 14))
                            Spacer()
                            Text("ALG-2024-392")
                                .font(.custom("Montserrat-SemiBold", size: 13))
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 2)
                    .padding(.horizontal)


                    // Patient Card
                    HStack {
                        Image("profile_placeholder") // Replace with actual image
                            .resizable()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Sarah Johnson")
                                .font(.custom("Montserrat-Medium", size: 18))
                                .foregroundColor(Color(hex: "FF6605"))
                            Text("34 years - Female")
                                .font(.custom("Montserrat-Regular", size: 14))
                                .foregroundColor(.gray)
                        }

                        Spacer()

                        Image(systemName: "arrow.right")
                            .foregroundColor(Color(hex: "FF6605"))
                    }
                    .padding()
                    .background(.white)
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 2)
                    .padding(.horizontal)
                    
                    
                    VStack(alignment: .leading, spacing: 12) {
                        
                        HStack(spacing: 8) {
                            Text("Visits Status")
                                .font(.custom("Montserrat-Bold", size: 17))
                                .foregroundColor(.black)
                            
                            Spacer()
                            
                            Text("Active")
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



                    // Visits Card
                    VStack(alignment: .leading, spacing: 12) {
                        HStack(spacing: 24) {
                            Rectangle()
                                .fill(Color(hex: "FF6605"))
                                .frame(width: 5)
                                .frame(height:90)
                                .padding(.leading, 6)
                          
                            VStack(alignment: .leading, spacing: 12) {
                                
                                Text("Conditions (2)")
                                    .font(.custom("Montserrat-Bold", size: 19))
                                    .padding(.leading, 4)
                                
                                HStack {
                                    Text("Essential Hypertension")
                                        .font(.custom("Montserrat-Regular", size: 12))
                                    Spacer()
                                    Text("Clinical Status: Active")
                                        .font(.custom("Montserrat-Medium", size: 12))
                                }
                                
                                HStack {
                                    Text("Type 2 Diabetic")
                                        .font(.custom("Montserrat-Regular", size: 12))
                                    Spacer()
                                    Text("Clinical Status: Active")
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
                    
                    
                    
                    VStack(alignment: .leading, spacing: 12) {
                        HStack(spacing: 24) {
                            Rectangle()
                                .fill(Color(hex: "FF6605"))
                                .frame(width: 5)
                                .frame(height:90)
                                .padding(.leading, 6)
                          
                            VStack(alignment: .leading, spacing: 12) {
                                
                                Text("Medications (2)")
                                    .font(.custom("Montserrat-Bold", size: 19))
                                    .padding(.leading, 4)
                                
                                HStack {
                                    Text("Lisinopril 10mg")
                                        .font(.custom("Montserrat-Regular", size: 12))
                                    Spacer()
                                    Text("Clinical Status: Active")
                                        .font(.custom("Montserrat-Medium", size: 12))
                                }
                                
                                HStack {
                                    Text("Metformin 500mg")
                                        .font(.custom("Montserrat-Regular", size: 12))
                                    Spacer()
                                    Text("Clinical Status: Active")
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


                    // Bottom Buttons
                    ActionButtonsView(title: "Refresh Data")

                    
                    Spacer()

                }
                .padding(.horizontal,8)
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

struct ActionButtonsView: View {
    
    let title : String
    var body: some View {
        HStack(spacing: 32) {
            HStack(spacing: 8) {
                Image("Refresh_data")
                    .foregroundColor(Color(hex: "FF6605"))
                Text(title)
                    .foregroundColor(.black)
                    .font(.custom("Montserrat-Medium", size: 16))
            }

            HStack(spacing: 8) {
                Image("ShareRecord")
                    .foregroundColor(Color(hex: "FF6605"))
                Text("Share Record")
                    .foregroundColor(.black)
                    .font(.custom("Montserrat-Medium", size: 16))
            }
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 16)
        .background(Color(hex: "F5F5F5")) // Light gray background
        .cornerRadius(32)
        .padding(.horizontal)
    }
}
