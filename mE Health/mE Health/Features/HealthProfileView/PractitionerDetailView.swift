//
//  PractitionerDetailView.swift
//  mE Health
//
//  Created by Ishant on 16/06/25.
//

import SwiftUI

struct PractitionerDetailView: View {
    
    let practitioner: PractitionerData
    let organizations: [Organization] = [
        Organization(name: "City Hospital", type: "General Medicine", imageName: "building.2.crop.circle"),
        Organization(name: "Sunrise Clinic", type: "Cardiology", imageName: "heart.text.square.fill")
    ]


    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 24) {
                
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
                        .padding(.horizontal)
                    }
                }
                
                VStack(spacing: 12) {
                    
                    Text("Appointments")
                        .font(.custom("Montserrat-Bold", size: 22))
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    
                    
                    VStack(spacing: 16) {
                        ForEach(organizations) { org in
                            AppoitmentCardView(organization: org)
                        }
                    }
                    .padding(.horizontal)
                    
                }
            }
            .padding()
        }
    }
}
