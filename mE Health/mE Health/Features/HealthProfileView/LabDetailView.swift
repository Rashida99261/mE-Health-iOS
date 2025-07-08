//
//  LabDetailView.swift
//  mE Health
//
//  Created by Rashida on 25/06/25.
//

import SwiftUI
import ComposableArchitecture

struct LabDetailView: View {
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
                        
                        TopCardView(title: "", subtitle: "Lab ID: 12345", desc: "")
                            .padding(.horizontal)
                        
                        // Allergy Detail Card
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Results")
                                .font(.custom("Montserrat-Bold", size: 17))

                            HStack {
                                Text("Clinical Status")
                                .font(.custom("Montserrat-Regular", size: 14))
                                Spacer()
                                Text("13.5")
                                .font(.custom("Montserrat-SemiBold", size: 13))
                            }

                            HStack {
                                Text("RCB")
                                .font(.custom("Montserrat-Regular", size: 14))
                                Spacer()
                                Text("2500")
                                .font(.custom("Montserrat-SemiBold", size: 13))
                            }

                            HStack {
                                Text("WBC")
                                .font(.custom("Montserrat-Regular", size: 14))
                                Spacer()
                                Text("200")
                                    .font(.custom("Montserrat-SemiBold", size: 13))
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 2)
                        .padding(.horizontal)
                        
                        VStack(alignment: .leading, spacing: 12) {
                            
                            Text("Performer")
                                .font(.custom("Montserrat-Bold", size: 17))
                            
                            Text("Dr. David")
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
                                
                                Text("In-progress")
                                    .font(.caption)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 4)
                                    .background(Color.blue.opacity(0.2))
                                    .foregroundColor(.blue)
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
                        ActionButtonsView(title: "Refresh Data")

                        
                        Spacer()

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


//#Preview {
//    LabDetailView()
//}

struct TopCardView: View {
    
    let title : String
    let subtitle : String
    let desc : String
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            
            HStack(alignment: .top, spacing: 12) {
                
                Rectangle()
                    .fill(Color(hex: "FF6605"))
                    .frame(width: 5)
                    .padding(.bottom,2)
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text(title)
                        .font(.custom("Montserrat-Bold", size: 17))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading) // or .center, but not justified
                        .lineSpacing(4)

                    HStack(spacing: 8) {
                        Text(subtitle)
                            .font(.custom("Montserrat-Regular", size: 13))
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
                    
                    Text(desc)
                        .font(.custom("Montserrat-Regular", size: 14))
                        .foregroundColor(Color.black)


                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 2)
      


    }
}
