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
                                AppoitmentCardView(organization: org, showStatus: true, status: appoitment.status)
                            }
                        }
                        .padding(.horizontal)


                        VStack(spacing: 16) {
                            idHeaderView(appoitment: appoitment)
                        }
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        
                        // Patient Card
                        HStack {
                            Image("profile_placeholder") // Replace with actual image
                                .resizable()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())

                            VStack(alignment: .leading, spacing: 4) {
                                Text(appoitment.practitionerId)
                                    .font(.custom("Montserrat-Medium", size: 18))
                                    .foregroundColor(Color(hex: "FF6605"))
                                Text(appoitment.description)
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
                            
                            Text(appoitment.reasonCode?.display ?? "")
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
                                
                                if appoitment.status ==  "booked" {
                                    
                                    Text("Booked")
                                        .font(.custom("Montserrat-SemiBold", size: 9))
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 4)
                                        .background(Color(hex: "0063F7").opacity(0.2))
                                        .foregroundColor(Color(hex: "0063F7"))
                                        .clipShape(Capsule())

                                }
                                else if appoitment.status ==  "cancel" {
                                    Text("Canceled")
                                        .font(.custom("Montserrat-SemiBold", size: 9))
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 4)
                                        .background(Color.red.opacity(0.2))
                                        .foregroundColor(Color.red)
                                        .clipShape(Capsule())
                                }
                                else if appoitment.status ==  "fulfilled" {
                                    Text("Completed")
                                        .font(.custom("Montserrat-SemiBold", size: 9))
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 4)
                                        .background(Color(hex: "06C270").opacity(0.2))
                                        .foregroundColor(Color(hex: "06C270"))
                                        .clipShape(Capsule())
                                }
                                
                            }

                           
                            Text("Start Date: \(appoitment.formattedStartDate)")
                                .font(.custom("Montserrat-SemiBold", size: 13))
                           // Text("Start Date: 11/06/2025")
                                //.font(.custom("Montserrat-SemiBold", size: 13))

                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 2)
                        .padding(.horizontal)


                        // Bottom Buttons
                        ActionButtonsView(title: "Sync Data")


                        if appoitment.status ==  "booked" {
                            
                            VStack(alignment: .leading, spacing: 16) {
                                
                                Button(action: {
                                    
                                }) {
                                    Text("Edit Appointment")
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

                                Button(action: {
                                    
                                }) {
                                    Text("Cancel Appointment")
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

                            }
                            

                        }
                        
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

    let appoitment: AppointmentData
        var body: some View {
            
            VStack(alignment: .leading, spacing: 4) {
                
                Text("Id: \(appoitment.id)")
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

                        Text(appoitment.formattedStartDate)
                            .font(.custom("Montserrat-Regular", size: 14))
                            .foregroundColor(.black)

                        Text("10:00 AM-11:00 AM")
                            .font(.custom("Montserrat-Regular", size: 12))
                            .foregroundColor(.black)

                        Text(appoitment.description)
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
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .background(Color.white)
            .cornerRadius(12)
            .shadow(radius: 4)
        }

}
