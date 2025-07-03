//
//  ConditionDetailView.swift
//  mE Health
//
//  Created by Rashida on 1/07/25.
//

import SwiftUI

struct ConditionDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode

    let organizations: [Organization] = [
        Organization(name: "HealthCare", type: "Start Time: Jan 1, 2022", imageName: "organis_placeholder"),
        Organization(name: "HealthCare", type: "Start Time: Jan 1, 2022", imageName: "organis_placeholder")
    ]


    var body: some View {
        
        ZStack {
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
                    Text("Current Details")
                        .font(.custom("Montserrat-Bold", size: 32))
                        .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        
                        HStack(spacing: 8) {
                            Text("Hypertension")
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
                        
                        HStack {
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Onset")
                                    .font(.custom("Montserrat-Regular", size: 12))
                                
                                Text("01/05/2022")
                                    .font(.custom("Montserrat-Regular", size: 14))
                                
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Recorded")
                                    .font(.custom("Montserrat-Regular", size: 12))
                                
                                Text("01/10/2022")
                                    .font(.custom("Montserrat-Regular", size: 14))
                                
                            }
                        }
                        
                        
                        HStack {
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Category")
                                    .font(.custom("Montserrat-Regular", size: 12))
                                
                                Text("Chronic")
                                    .font(.custom("Montserrat-Regular", size: 14))
                                
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Condition ID")
                                    .font(.custom("Montserrat-Regular", size: 12))
                                
                                Text("#HYP2022105")
                                    .font(.custom("Montserrat-Regular", size: 14))
                                
                            }
                        }
                        
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 2)
                    .padding(.horizontal)
                    
                    
                    VStack(spacing: 12) {
                        HStack {
                            Text("Practitioners")
                                .font(.custom("Montserrat-Bold", size: 22))
                            
                            Spacer()
                            
                            Button(action: {
                                // Handle tap on "View All"
                            }) {
                                Text("View All")
                                    .font(.custom("Montserrat-SemiBold", size: 12))
                                    .foregroundColor(Color(hex: "FF6605"))
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(Color(hex: "FF6605").opacity(0.1))
                                    .cornerRadius(16)
                            }
                        }
                        .padding(.horizontal)
                        
                        HStack {
                            Image("profile_placeholder") // Replace with actual image
                                .resizable()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Dr. John Doe")
                                    .font(.custom("Montserrat-Medium", size: 18))
                                    .foregroundColor(Color(hex: "FF6605"))
                                Text("Apollo Hospital")
                                    .font(.custom("Montserrat-Regular", size: 14))
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                            
                            Image(systemName: "arrow.right")
                                .foregroundColor(Color(hex: "FF6605"))
                        }
                        .padding()
                        .background(.clear)
                        .padding(.horizontal)
                    }
                    .padding(.horizontal)
                    
                    VStack(spacing: 12) {
                        HStack {
                            Text("Vitals")
                                .font(.custom("Montserrat-Bold", size: 22))
                            
                            Spacer()
                            
                            Button(action: {
                                // Handle tap on "View All"
                            }) {
                                Text("View All")
                                    .font(.custom("Montserrat-SemiBold", size: 12))
                                    .foregroundColor(Color(hex: "FF6605"))
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(Color(hex: "FF6605").opacity(0.1))
                                    .cornerRadius(16)
                            }
                        }
                        
                        
                        VStack(spacing: 16) {
                            
                            HStack(spacing: 12) {
                                Image("date_placeholder")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(Color(hex: "FF6605"))
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    
                                    Text("11 Jun 2025") // You can pull from organization.type if dynamic
                                        .font(.custom("Montserrat-Medium", size: 16))
                                        .foregroundColor(.black)
                                    
                                    Text("New York Sector C")
                                        .font(.custom("Montserrat-Regular", size: 12))
                                        .foregroundColor(Color(hex: "FF6605"))
                                }
                                
                            }
                            .padding(.horizontal, 12)
                            .frame(height: 80)
                            .background(Color.white)
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 2)


                    }
                    .padding()
                    .background(Color.clear)
                    .padding(.horizontal)
                    
                    VStack(spacing: 12) {
                        HStack {
                            Text("Labs")
                                .font(.custom("Montserrat-Bold", size: 22))
                            
                            Spacer()
                            
                            Button(action: {
                                // Handle tap on "View All"
                            }) {
                                Text("View All")
                                    .font(.custom("Montserrat-SemiBold", size: 12))
                                    .foregroundColor(Color(hex: "FF6605"))
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(Color(hex: "FF6605").opacity(0.1))
                                    .cornerRadius(16)
                            }
                        }
                        
                        
                        VStack(spacing: 16) {
                            
                            HStack(spacing: 12) {
                                Image("date_placeholder")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(Color(hex: "FF6605"))
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    
                                    Text("ZX Pathology") // You can pull from organization.type if dynamic
                                        .font(.custom("Montserrat-Medium", size: 16))
                                        .foregroundColor(.black)
                                    
                                    Text("New York Sector C")
                                        .font(.custom("Montserrat-Regular", size: 12))
                                        .foregroundColor(Color(hex: "FF6605"))
                                }
                                
                            }
                            .padding(.horizontal, 12)
                            .frame(height: 80)
                            .background(Color.white)
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 2)
                    }
                    .padding()
                    .background(Color.clear)
                    .padding(.horizontal)
                    
                    VStack(spacing: 12) {
                        HStack {
                            Text("Visits")
                                .font(.custom("Montserrat-Bold", size: 22))
                            
                            Spacer()
                            
                            Button(action: {
                                // Handle tap on "View All"
                            }) {
                                Text("View All")
                                    .font(.custom("Montserrat-SemiBold", size: 12))
                                    .foregroundColor(Color(hex: "FF6605"))
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(Color(hex: "FF6605").opacity(0.1))
                                    .cornerRadius(16)
                            }
                        }
                        
                        
                        VStack(spacing: 16) {
                            
                            HStack(spacing: 12) {
                                Image("date_placeholder")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(Color(hex: "FF6605"))
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    
                                    Text("ZX Pathology") // You can pull from organization.type if dynamic
                                        .font(.custom("Montserrat-Medium", size: 16))
                                        .foregroundColor(.black)
                                    
                                    Text("New York Sector C")
                                        .font(.custom("Montserrat-Regular", size: 12))
                                        .foregroundColor(Color(hex: "FF6605"))
                                }
                                
                            }
                            .padding(.horizontal, 12)
                            .frame(height: 80)
                            .background(Color.white)
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 2)
                    }
                    .padding()
                    .background(Color.clear)
                    .padding(.horizontal)
                    
                    VStack(spacing: 12) {
                        HStack {
                            Text("Medication")
                                .font(.custom("Montserrat-Bold", size: 22))
                            
                            Spacer()
                            
                            Button(action: {
                                // Handle tap on "View All"
                            }) {
                                Text("View All")
                                    .font(.custom("Montserrat-SemiBold", size: 12))
                                    .foregroundColor(Color(hex: "FF6605"))
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(Color(hex: "FF6605").opacity(0.1))
                                    .cornerRadius(16)
                            }
                        }
                        
                        
                        VStack(spacing: 16) {
                            
                            HStack(spacing: 12) {
                                Image("date_placeholder")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(Color(hex: "FF6605"))
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    
                                    Text("ZX Pathology") // You can pull from organization.type if dynamic
                                        .font(.custom("Montserrat-Medium", size: 16))
                                        .foregroundColor(.black)
                                    
                                    Text("New York Sector C")
                                        .font(.custom("Montserrat-Regular", size: 12))
                                        .foregroundColor(Color(hex: "FF6605"))
                                }
                                
                            }
                            .padding(.horizontal, 12)
                            .frame(height: 80)
                            .background(Color.white)
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 2)
                    }
                    .padding()
                    .background(Color.clear)
                    .padding(.horizontal)

                    
                    // Bottom Buttons
                    ActionButtonsView(title: "Sync Data")
                        .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 2)
                        .padding(.horizontal)


                    
                    Button(action: {
                        
                    }) {
                        Text("Add Related Data")
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
                
            }
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
