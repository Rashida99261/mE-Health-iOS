//
//  AppoitmentDetailView.swift
//  mE Health
//
//  Created by Rashida on 25/06/25.
//

import SwiftUI

struct AppoitmentDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    let appoitment: AppointmentData
    
    let organizations: [Organization] = [
        Organization(name: "11 Jun 2025", type: " 10:00 AM - 11:00 AM", imageName: "organis_placeholder")
    ]


    var body: some View {
        
        ZStack {
            
            VStack(alignment: .leading, spacing: 16) {
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 24) {
                        
                        Text("Details")
                            .font(.custom("Montserrat-Bold", size: 32))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                        
                        VStack(spacing: 16) {
                            ForEach(organizations) { org in
                                AppoitmentCardView(organization: org, showStatus: true)
                            }
                        }
                        .padding(.horizontal)


                        VStack(spacing: 16) {
                            idHeaderView()
                        }
                        .padding(.horizontal)
                        
                        
                        // Patient Card
                        HStack {
                            Image("profile_placeholder") // Replace with actual image
                                .resizable()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())

                            VStack(alignment: .leading, spacing: 4) {
                                Text("Dr. Davide Joe")
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
                        
                        VStack(alignment: .leading, spacing: 12) {
                            
                            Text("Reason")
                                .font(.custom("Montserrat-Bold", size: 17))
                            
                            Text("To go for regular checkups for diabetes")
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

                            
                            Text("Start Date: 11/06/2025")
                                .font(.custom("Montserrat-SemiBold", size: 13))

                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 2)
                        .padding(.horizontal)


                        // Bottom Buttons
                        ActionButtonsView()

                        
                        Spacer()

                        
                    }
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


struct idHeaderView: View {

        var body: some View {
            
            VStack(alignment: .leading, spacing: 4) {
                
                Text("Id: APT-2023051501")
                .font(.custom("Montserrat-Bold", size: 18))
                .foregroundColor(.black)
                .padding(.top,16)
            
                HStack(alignment: .top, spacing: 12) {
                    
                    Rectangle()
                        .fill(Color(hex: "FF6605"))
                        .frame(width: 5)
                        .padding(.top,12)
                        .padding(.bottom,12)

                    VStack(alignment: .leading, spacing: 8) {

                        Text("11 Jun 2025,")
                            .font(.custom("Montserrat-Regular", size: 14))
                            .foregroundColor(.black)

                        Text("10:00 AM-11:00 AM")
                            .font(.custom("Montserrat-Regular", size: 12))
                            .foregroundColor(.black)

                        Text("Based on your recent activity and climate, here’s personalized guidance on your daily water intake to stay hydrated and healthy.")
                            .font(.custom("Montserrat-Regular", size: 10))
                            .foregroundColor(.black)
                            .fixedSize(horizontal: false, vertical: true)

                        Text("Read more")
                            .font(.custom("Montserrat-SemiBold", size: 12))
                            .foregroundColor(Color(hex: "FF6605"))
                    }
                    .padding(.vertical, 12)
                }
            }
            .padding(.horizontal, 12)
            .background(Color.white)
            .cornerRadius(12)
            .shadow(radius: 4)
        }

}
