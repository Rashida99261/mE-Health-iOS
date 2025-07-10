//
//  MedicationDetailView.swift
//  mE Health
//
//  Created by Rashida on 30/06/25.
//

import SwiftUI
import ComposableArchitecture

struct MedicationDetailView: View {
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
                        
                        TopCardView(title: "Cetirizine 10 mg", subtitle: "Take 1 tablet daily as needed for allergy symptoms", desc: "01/07/2021", status: "Active")
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
                                Text("MBBS, Physician")
                                    .font(.custom("Montserrat-Regular", size: 14))
                                    .foregroundColor(.gray)
                                
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
                        
                        VStack(alignment: .leading, spacing: 12) {

                            HStack {
                                Text("Medication ID")
                                .font(.custom("Montserrat-Bold", size: 17))
                                Spacer()
                                Text("123...")
                                .font(.custom("Montserrat-SemiBold", size: 13))
                            }

                            HStack {
                                Text("Label Field Notes")
                                .font(.custom("Montserrat-Regular", size: 14))
                                Spacer()
                                Text("Take with food...")
                                .font(.custom("Montserrat-SemiBold", size: 13))
                            }

                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .padding(.horizontal)



                        VStack(alignment: .leading, spacing: 12) {
                            
                            Text("Dosage Instruction")
                                .font(.custom("Montserrat-Bold", size: 17))
                            
                            Text("Take 1 capsule by mouth 3 time daily")
                                .font(.custom("Montserrat-SemiBold", size: 13))
                            
                            Text("For 7 day with food")
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
                        
                        VStack(alignment: .leading, spacing: 12) {
                            
                            Text("Reason")
                                .font(.custom("Montserrat-Bold", size: 17))
                            
                            Text("Upper respiratory infection")
                                .font(.custom("Montserrat-SemiBold", size: 13))
                            
                            Text("Fever")
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
                            .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 2)


                        Button(action: {
                            
                        }) {
                            Text("Edit Medication")
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


#Preview {
    MedicationDetailView()
}

