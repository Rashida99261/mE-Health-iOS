//
//  VisitsDetailView.swift
//  mE Health
//
//  Created by Rashida on 30/06/25.
//

import SwiftUI

struct VisitsDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    let visit: VisitDummyData

    var body: some View {
        
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(spacing: 24) {
                    
                    // Title
                    Text("Details")
                        .font(.custom("Montserrat-Bold", size: 32))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    // Allergy Detail Card
                    VStack(alignment: .leading, spacing: 16) {
                        
                        HStack(spacing: 8) {
                            Text("Visit Details")
                                .font(.custom("Montserrat-Bold", size: 18))
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

                        HStack {
                            Text("Visit ID")
                                .font(.custom("Montserrat-Medium", size: 12))
                            Spacer()
                            Text("ENC-2023-10156")
                            .font(.custom("Montserrat-SemiBold", size: 12))
                        }

                        HStack {
                            Text("Status")
                                .font(.custom("Montserrat-Medium", size: 12))
                            Spacer()
                            Text("In Progress")
                            .font(.custom("Montserrat-SemiBold", size: 12))
                        }

                        HStack {
                            Text("Start date")
                                .font(.custom("Montserrat-Medium", size: 12))
                            Spacer()
                            Text("06/11/2025")
                            .font(.custom("Montserrat-SemiBold", size: 12))
                        }
                        
                        HStack {
                            Text("Type")
                                .font(.custom("Montserrat-Medium", size: 12))
                            Spacer()
                            Text("Ambulatory")
                            .font(.custom("Montserrat-SemiBold", size: 12))
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
                            Text("Dr. Michael Chen")
                                .font(.custom("Montserrat-Medium", size: 18))
                                .foregroundColor(Color(hex: "FF6605"))
                            Text("Hospital Name")
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
                                
                                Text("Procedures (1)")
                                    .font(.custom("Montserrat-Bold", size: 19))
                                    .padding(.leading, 4)
                                
                                HStack {
                                    Text("Appendectomy")
                                        .font(.custom("Montserrat-Regular", size: 12))
                                    Spacer()
                                    Text("Status: Completed")
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
                    
                    
                    VStack(alignment: .leading, spacing: 12) {
                        HStack(spacing: 24) {
                            Rectangle()
                                .fill(Color(hex: "FF6605"))
                                .frame(width: 5)
                                .frame(height:90)
                                .padding(.leading, 6)
                          
                            VStack(alignment: .leading, spacing: 12) {
                                
                                Text("Allergies (2)")
                                    .font(.custom("Montserrat-Bold", size: 19))
                                    .padding(.leading, 4)
                                
                                HStack {
                                    Text("Penicillin")
                                        .font(.custom("Montserrat-Regular", size: 12))
                                    Spacer()
                                    Text("Severity: Severe")
                                        .font(.custom("Montserrat-Medium", size: 12))
                                }
                                
                                HStack {
                                    Text("Sulfa Drugs")
                                        .font(.custom("Montserrat-Regular", size: 12))
                                    Spacer()
                                    Text("Severity: Moderate")
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
                    ActionButtonsView(title: "Sync  Data")

                    
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
