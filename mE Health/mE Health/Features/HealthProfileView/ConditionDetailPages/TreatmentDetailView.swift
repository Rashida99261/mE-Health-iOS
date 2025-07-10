//
//  TreatmentDetailView.swift
//  mE Health
//
//  Created by Rashida on 9/07/25.
//
import SwiftUI

struct TreatmentDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode

    @State private var showPractitionerList = false
    
    let appoitment = AppointmentData(drName: "Dr. David Joe", hospitalName: "Hospital name", dateTime: "11 Jun 2025,03:30 PM - 4:00 PM", description: "Based on your recent activity and climate, here’s personalized guidance on your daily water intake to stay hydrated and healthy.",status: .booked)
    
    let org = Organization(name: "11 Jun 2025", type: " 10:00 AM - 11:00 AM", imageName: "organis_placeholder")

    var body: some View {
        
        ZStack {
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
                    Text("Treatment")
                        .font(.custom("Montserrat-Bold", size: 32))
                        .padding(.horizontal)
                    
                    Divider()
                    
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
                                .background(Color(hex: "DBFCE6"))
                                .foregroundColor(.green)
                                .clipShape(Capsule())
                        }
                        
                        HStack {
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Onset")
                                    .font(.custom("Montserrat-Regular", size: 12))
                                
                                Text("01/07/2021")
                                    .font(.custom("Montserrat-Regular", size: 14))
                                
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Recorded")
                                    .font(.custom("Montserrat-Regular", size: 12))
                                
                                Text("01/07/2021")
                                    .font(.custom("Montserrat-Regular", size: 14))
                                
                            }
                        }
                        
                        
                        HStack {
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Category")
                                    .font(.custom("Montserrat-Regular", size: 12))
                                
                                Text("Problem List Item")
                                    .font(.custom("Montserrat-Regular", size: 14))
                                
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Condition ID")
                                    .font(.custom("Montserrat-Regular", size: 12))
                                
                                Text("#J30.1")
                                    .font(.custom("Montserrat-Regular", size: 14))
                                
                            }
                        }
                        
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 4)
                    .padding(.horizontal)
                    
                    AppoitmentMainView(appoinmnt: appoitment,
                                       onTap: {},
                                       onReadMoreTap: {})
                    .padding(.horizontal)
                    
                    
                    VStack(spacing: 12) {
                        HStack {
                            Text("Practitioners")
                                .font(.custom("Montserrat-Bold", size: 22))
                            
                            Spacer()
                            
                            Text("View All")
                                .font(.custom("Montserrat-SemiBold", size: 12))
                                .foregroundColor(Color(hex: "06C270"))
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color(hex: "DBFCE6"))
                                .cornerRadius(16)
                        }
                        
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
                            
                        }
                        .background(.clear)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    
                    
                    VStack(spacing: 12) {
                        HStack {
                            Text("Visits")
                                .font(.custom("Montserrat-Bold", size: 22))
                            
                            Spacer()
                            
                            Text("View All")
                                .font(.custom("Montserrat-SemiBold", size: 12))
                                .foregroundColor(Color(hex: "06C270"))
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color(hex: "DBFCE6"))
                                .cornerRadius(16)
                        }
                        .padding(.horizontal)
                        
                        HStack(spacing: 12) {
                            Image("date_placeholder")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .foregroundColor(Color(hex: "FF6605"))
                            
                            VStack(alignment: .leading, spacing: 4) {
                                
                                Text("Jan 1, 2023") // You can pull from organization.type if dynamic
                                    .font(.custom("Montserrat-Medium", size: 16))
                                    .foregroundColor(.black)
                                
                                Text("ABC Hospital")
                                    .font(.custom("Montserrat-Regular", size: 12))
                                    .foregroundColor(Color(hex: "FF6605"))
                            }
                        }
                        .frame(height: 70)
                        .background(Color.clear)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack(spacing: 12) {
                        
                        HStack(alignment: .top, spacing: 12) {
                            
                            Rectangle()
                                .fill(Color(hex: "FF6605"))
                                .frame(width: 5)
                                .padding(.bottom,2)
                            
                            VStack(alignment: .leading, spacing: 8) {
                                
                                Text("Lab Result")
                                    .font(.custom("Montserrat-Bold", size: 17))
                                    .foregroundColor(.black)
                                    .multilineTextAlignment(.leading) // or .center, but not justified
                                    .lineSpacing(4)
                                
                                HStack(spacing: 8) {
                                    Text("Hemoglobin")
                                        .font(.custom("Montserrat-Regular", size: 13))
                                        .foregroundColor(.black)
                                    
                                    Spacer()
                                    
                                    Text("13.5")
                                        .font(.custom("Montserrat-Regular", size: 14))
                                        .foregroundColor(Color.black)
                                    
                                }
                                
                                HStack(spacing: 8) {
                                    Text("Wbc")
                                        .font(.custom("Montserrat-Regular", size: 13))
                                        .foregroundColor(.black)
                                    
                                    Spacer()
                                    
                                    Text("5.6")
                                        .font(.custom("Montserrat-Regular", size: 14))
                                        .foregroundColor(Color.black)
                                    
                                }
                                
                                
                            }
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 4)
                    .padding(.horizontal)
                    
                    
                    VStack(spacing: 12) {
                        
                        HStack(alignment: .top, spacing: 12) {
                            
                            Rectangle()
                                .fill(Color(hex: "FF6605"))
                                .frame(width: 5)
                                .padding(.bottom,2)
                            
                            VStack(alignment: .leading, spacing: 8) {
                                
                                HStack(spacing: 8) {
                                    
                                    Text("Procedure")
                                        .font(.custom("Montserrat-Bold", size: 17))
                                        .foregroundColor(.black)
                                        .multilineTextAlignment(.leading) // or .center, but not justified
                                        .lineSpacing(4)
                                    
                                    
                                    Spacer()
                                    
                                    Text("Active")
                                        .font(.custom("Montserrat-SemiBold", size: 12))
                                        .foregroundColor(Color(hex: "06C270"))
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 6)
                                        .background(Color(hex: "DBFCE6"))
                                        .cornerRadius(16)
                                    
                                    
                                }
                                
                                
                                Text("Appendectomy")
                                    .font(.custom("Montserrat-Regular", size: 13))
                                    .foregroundColor(.black)
                                
                                Text("03/15/2024")
                                    .font(.custom("Montserrat-Regular", size: 13))
                                    .foregroundColor(.black)
                                
                                
                                
                                
                                
                                
                            }
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 4)
                    .padding(.horizontal)
                    
                    
                    VStack(spacing: 12) {
                        
                        HStack(alignment: .top, spacing: 12) {
                            
                            Rectangle()
                                .fill(Color(hex: "FF6605"))
                                .frame(width: 5)
                                .padding(.bottom,2)
                            
                            VStack(alignment: .leading, spacing: 8) {
                                
                                HStack(spacing: 8) {
                                    
                                    Text("Current Medication")
                                        .font(.custom("Montserrat-Bold", size: 17))
                                        .foregroundColor(.black)
                                        .multilineTextAlignment(.leading) // or .center, but not justified
                                        .lineSpacing(4)
                                    
                                    
                                    Spacer()
                                    
                                    Text("Active")
                                        .font(.custom("Montserrat-SemiBold", size: 12))
                                        .foregroundColor(Color(hex: "06C270"))
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 6)
                                        .background(Color(hex: "DBFCE6"))
                                        .cornerRadius(16)
                                    
                                    
                                }
                                
                                Text("Amoxicillin")
                                    .font(.custom("Montserrat-Regular", size: 13))
                                    .foregroundColor(.black)
                                
                                Text("500 mg. Twice Daily")
                                    .font(.custom("Montserrat-Regular", size: 13))
                                    .foregroundColor(.black)
                                
                                Spacer()
                                
                                Text("Amoxicillin")
                                    .font(.custom("Montserrat-Regular", size: 13))
                                    .foregroundColor(.black)
                                
                                Text("500 mg. Twice Daily")
                                    .font(.custom("Montserrat-Regular", size: 13))
                                    .foregroundColor(.black)
                            }
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 4)
                    .padding(.horizontal)
                    
                    
                    VStack(spacing: 12) {
                        
                        Text("Medical Documents")
                            .font(.custom("Montserrat-Bold", size: 22))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        
                        VStack(alignment: .leading, spacing: 12) {
                            
                            Text("Diagnostic Report")
                                .font(.custom("Montserrat-Bold", size: 17))
                            
                            Text("PDF • 2.4 MB")
                                .font(.custom("Montserrat-SemiBold", size: 13))

                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(radius: 4)

                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)

                


                    
                    // Bottom Buttons
                    ActionButtonsView(title: "Sync Data")
                        .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 2)
                        .padding(.horizontal)


                    
                    Spacer()
                }
                
                NavigationLink(
                    destination: PractionerListView(),
                    isActive: $showPractitionerList,
                    label: {
                        EmptyView()
                    })

                
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



#Preview {
    TreatmentDetailView()
}
