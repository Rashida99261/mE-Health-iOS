//
//  AppoitmentView.swift
//  mE Health
//
//  Created by Rashida on 17/06/25.
//

import SwiftUI

struct AppointmentResponse: Codable {
    let appointments: [AppointmentData]
}


struct AppointmentData: Identifiable, Equatable, Codable {
    let id: String
    let startTime: String
    let endTime: String
    let status: String
    let patientId: String
    let practitionerId: String
    let encounterId: String
    let description: String
    let reasonCodeRaw: String
    let createdAt: String
    let updatedAt: String
    
    var formattedStartDate: String {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime]

        if let date = isoFormatter.date(from: startTime) {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            return formatter.string(from: date)
        }
        return startTime
    }
    
    var formattedEndDate: String {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime]

        if let date = isoFormatter.date(from: endTime) {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            return formatter.string(from: date)
        }
        return endTime
    }

    enum CodingKeys: String, CodingKey {
        case id, startTime, endTime, status, patientId, practitionerId, encounterId, description
        case reasonCodeRaw = "reasonCode"
        case createdAt, updatedAt
    }

    // Computed property to decode reasonCode JSON string
    var reasonCode: CodeInfo? {
        guard let data = reasonCodeRaw.data(using: .utf8) else { return nil }
        return try? JSONDecoder().decode(CodeInfo.self, from: data)
    }
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

struct AppoitmentMainView: View {
    
    let appoinmnt: AppointmentData
    let onTap: () -> Void
    let onReadMoreTap: () -> Void   // Add this new action for "Read more"
    
    
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            
            HStack(alignment: .top, spacing: 12) {
                Text(appoinmnt.practitionerId)
                    .font(.custom("Montserrat-Bold", size: 18))
                    .foregroundColor(.black)
                Spacer()
                
                if appoinmnt.status ==  "booked" {
                    
                    Text("Booked")
                        .font(.custom("Montserrat-SemiBold", size: 9))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 4)
                        .background(Color(hex: "0063F7").opacity(0.2))
                        .foregroundColor(Color(hex: "0063F7"))
                        .clipShape(Capsule())

                }
                else if appoinmnt.status ==  "cancel" {
                    Text("Canceled")
                        .font(.custom("Montserrat-SemiBold", size: 9))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 4)
                        .background(Color.red.opacity(0.2))
                        .foregroundColor(Color.red)
                        .clipShape(Capsule())
                }
                else if appoinmnt.status ==  "fulfilled" {
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
                    
                    Text(appoinmnt.reasonCode?.display ?? "")
                        .font(.custom("Montserrat-Regular", size: 14))
                        .foregroundColor(.black)
                    
                    Text(appoinmnt.formattedStartDate)
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
    let appoitmentarray: [AppointmentData]
    var onCardTap: (AppointmentData) -> Void
    var onReadMoreTap: (AppointmentData) -> Void
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            if appoitmentarray.isEmpty {
                        NoDataView()
            } else {
                ForEach(appoitmentarray) { appoitment in
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
        }
        .padding(.horizontal)

    }
}
