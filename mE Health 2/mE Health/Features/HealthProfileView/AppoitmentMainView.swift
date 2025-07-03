//
//  AppoitmentView.swift
//  mE Health
//
//  Created by Rashida on 17/06/25.
//

import SwiftUI

struct AppointmentData: Identifiable, Equatable {
    let id: UUID = UUID()
    let drName: String
    let hospitalName: String
    let dateTime: String
    let description: String
    let status : AppoitmentStatus
}

enum AppoitmentStatus : String {
    case booked = "Booked"
    case completed = "Completed"
    case cancel = "Cancelled"
}

struct TabSelectorView: View {
    @State private var selectedTab = "Today"
    let tabs = ["Today", "All", "Booked", "Canceled"]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(tabs, id: \.self) { tab in
                    Button(action: {
                        selectedTab = tab
                    }) {
                        Text(tab)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(selectedTab == tab ? .white : .black)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 24)
                            .background(
                                Group {
                                    if selectedTab == tab {
                                        Color(hex: "FF6605")
                                    } else {
                                        Color.white
                                    }
                                }
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color(hex: "FF6605"), lineWidth: 2) // Outer border
                            )
                            .cornerRadius(20)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}


//struct AppointmentTabsView: View {
//    @State private var selectedTab: String = "Today"
//
//    let tabs = ["Today", "All", "Booked", "Canceled"]
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 24) {
//            // Tabs Scroll View
//            ScrollView(.horizontal, showsIndicators: false) {
//                HStack(spacing: 24) {
//                    ForEach(tabs, id: \.self) { tab in
//                        Button(action: {
//                            selectedTab = tab
//                        }) {
//                            ZStack {
//                                // Outer white background to give the gap/border feel
//                                Capsule()
//                                    .fill(Color.white)
//
//                                // Stroke + Fill Layer
//                                Capsule()
//                                    .stroke(Color(hex: "FF6605"), lineWidth: 2)
//                                    .background(
//                                        Capsule()
//                                            .fill(selectedTab == tab ? Color(hex: "FF6605") : Color.white)
//                                    )
//
//                                // Text
//                                Text(tab)
//                                    .font(.custom("Montserrat-Bold", size: 16))
//                                    .foregroundColor(selectedTab == tab ? .white : .black)
//                                    .padding(.vertical, 8)
//                                    .padding(.horizontal, 20)
//                            }
//                        }
//                    }
//                }
//                .padding(.horizontal)
//            }
//        }
//    }
//}




struct AppoitmentMainView: View {
    
    let appoinmnt: AppointmentData
    let onTap: () -> Void
    let onReadMoreTap: () -> Void   // Add this new action for "Read more"
    
    
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            
            HStack(alignment: .top, spacing: 12) {
                Text(appoinmnt.drName)
                    .font(.custom("Montserrat-Bold", size: 18))
                    .foregroundColor(.black)
                Spacer()
                
                if appoinmnt.status ==  .booked {
                    
                    Text("Booked")
                        .font(.custom("Montserrat-SemiBold", size: 9))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 4)
                        .background(Color(hex: "0063F7").opacity(0.2))
                        .foregroundColor(Color(hex: "0063F7"))
                        .clipShape(Capsule())

                }
                else if appoinmnt.status ==  .cancel {
                    Text("Canceled")
                        .font(.custom("Montserrat-SemiBold", size: 9))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 4)
                        .background(Color.red.opacity(0.2))
                        .foregroundColor(Color.red)
                        .clipShape(Capsule())
                }
                else if appoinmnt.status ==  .completed {
                    Text("Completed")
                        .font(.custom("Montserrat-SemiBold", size: 9))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 4)
                        .background(Color(hex: "06C270").opacity(0.2))
                        .foregroundColor(Color(hex: "06C270"))
                        .clipShape(Capsule())
                }

            }
            .padding(.top,12)
            
            HStack(alignment: .top, spacing: 12) {
                
                Rectangle()
                    .fill(Color(hex: "FF6605"))
                    .frame(width: 5)
                    .padding(.top,12)
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    
                    Text(appoinmnt.hospitalName)
                        .font(.custom("Montserrat-Regular", size: 14))
                        .foregroundColor(.black)
                    
                    Text(appoinmnt.dateTime)
                        .font(.custom("Montserrat-Regular", size: 12))
                        .foregroundColor(.black)
                    
                    Text(appoinmnt.description)
                        .font(.custom("Montserrat-Regular", size: 10))
                        .foregroundColor(.black)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Text("Read more")
                        .font(.custom("Montserrat-SemiBold", size: 12))
                        .foregroundColor(Color(hex: "FF6605"))
                        .onTapGesture {
                            onReadMoreTap()
                        }
                    
                }
                .padding(.vertical, 12)
            }
        }
        .padding(.horizontal, 12)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 4)
        .contentShape(Rectangle())
        .onTapGesture {
            onTap()
        }
        
    }
    
}




struct AppoitmentSectionView: View {
    let practitioners: [AppointmentData]
    var onCardTap: (AppointmentData) -> Void
    var onReadMoreTap: (AppointmentData) -> Void
    
    var body: some View {
        
        VStack(spacing: 24) {
            ForEach(practitioners) { appoitment in
                AppoitmentMainView(appoinmnt: appoitment,
                                   onTap: {
                    onCardTap(appoitment)
                    },
                                   onReadMoreTap: {
                        onReadMoreTap(appoitment)   // <- Pass specific appointment
                    }
                )
                
                
                
            }
        }
        .padding(.horizontal)

    }
}
