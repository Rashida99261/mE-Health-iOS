//
//  PractitionerDetailView.swift
//  mE Health
//
//  Created by Ishant on 16/06/25.
//

import SwiftUI

struct PractitionerDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    let practitioner: PractitionerData
    let organizations: [Organization] = [
        Organization(name: "Massachusetts General Hospital", type: "Start Time: Jan 1, 2021", imageName: "organis_placeholder"),
        Organization(name: "Middleton Family Practice", type: "Start Time: Jan 1, 2021", imageName: "organis_placeholder")
    ]


    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 24) {
                Text("Details")
                    .font(.custom("Montserrat-Bold", size: 32))
                    .padding(.horizontal)
                
                // Horizontal date cards
                HStack(spacing: 16) {
                    DateCardView(title: "Start Date", date: "MM-DD-YYYY")
                    DateCardView(title: "End Date", date: "MM-DD-YYYY")
                }
                
                // Practitioner list
                PractitionerCardView(practitioner: practitioner) {
                    
                }
                
                Divider()
                
                VStack(spacing: 12) {
                    
                    Text("Organizations")
                        .font(.custom("Montserrat-Bold", size: 22))
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(organizations) { org in
                                OrganizationCardView(organization: org)
                            }
                        }
                        .frame(height:110)
                        .padding(.horizontal)
                    }
                }
                
                VStack(spacing: 12) {
                    HStack {
                        Text("Appointments")
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

                    VStack(spacing: 16) {
                        ForEach(organizations) { org in
                            AppoitmentCardView(organization: org, showStatus: false, status: .booked)
                        }
                    }
                    .padding(.horizontal)
                }

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
                    .padding(.horizontal)

                    VStack(spacing: 16) {
                        ForEach(organizations) { org in
                            AppoitmentCardView(organization: org,showStatus: false, status: .booked)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .padding()
            .background(Color.white)
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
