//
//  ImagingMainView.swift
//  mE Health
//
//  Created by Rashida on 7/07/25.
//

import SwiftUI


struct ImagingStudyResponse: Codable {
    let imagingStudies: [ImagingDummyData]
}

struct ImagingDummyData: Codable, Identifiable, Equatable {
    let id: String
    let status: String

    // Raw JSON strings
    let modalityRaw: String
    let reasonCodeRaw: String
    let procedureCodeRaw: String
    let seriesRaw: String
    let performerRaw: String
    let noteRaw: String

    let started: String
    let description: String
    let modalitySystem: String
    let modalityCode: String
    let modalityDisplay: String
    let reasonCodeSystem: String
    let reasonCodeCode: String
    let reasonCodeDisplay: String
    let procedureCodeSystem: String
    let procedureCodeCode: String
    let procedureCodeDisplay: String

    let numberOfSeries: Int
    let numberOfInstances: Int
    let patientId: String
    let encounterId: String
    let conditionId: String
    let procedureId: String
    let appointmentId: String
    let createdAt: String
    let updatedAt: String
    
    var formattedStartDate: String {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime]

        if let date = isoFormatter.date(from: started) {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            return formatter.string(from: date)
        }
        return started
    }


    enum CodingKeys: String, CodingKey {
        case id, status, started, description
        case modalityRaw = "modality"
        case reasonCodeRaw = "reasonCode"
        case procedureCodeRaw = "procedureCode"
        case seriesRaw = "series"
        case performerRaw = "performer"
        case noteRaw = "note"
        case modalitySystem = "modality_system"
        case modalityCode = "modality_code"
        case modalityDisplay = "modality_display"
        case reasonCodeSystem = "reasonCode_system"
        case reasonCodeCode = "reasonCode_code"
        case reasonCodeDisplay = "reasonCode_display"
        case procedureCodeSystem = "procedureCode_system"
        case procedureCodeCode = "procedureCode_code"
        case procedureCodeDisplay = "procedureCode_display"
        case numberOfSeries, numberOfInstances
        case patientId, encounterId, conditionId, procedureId, appointmentId
        case createdAt, updatedAt
    }

    // Computed properties to parse embedded JSON strings
    var modality: CodeInfo? {
        decodeJSONString(from: modalityRaw)
    }

    var reasonCode: CodeInfo? {
        decodeJSONString(from: reasonCodeRaw)
    }

    var procedureCode: CodeInfo? {
        decodeJSONString(from: procedureCodeRaw)
    }

    var series: [SeriesInfo]? {
        decodeJSONString(from: seriesRaw)
    }

    var performer: [PerformerInfo]? {
        decodeJSONString(from: performerRaw)
    }

    var note: NoteInfo? {
        decodeJSONString(from: noteRaw)
    }

    private func decodeJSONString<T: Decodable>(from jsonString: String) -> T? {
        guard let data = jsonString.data(using: .utf8) else { return nil }
        return try? JSONDecoder().decode(T.self, from: data)
    }
}

struct SeriesInfo: Codable {
    let uid: String
    let bodySite: CodeInfo
}

struct PerformerInfo: Codable {
    let reference: String
    let display: String
}

struct NoteInfo: Codable {
    let text: String
}



struct ImagingMainView: View {

    let imaging: ImagingDummyData
    let onTap: () -> Void
        
        var body: some View {

                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("\(imaging.modalityDisplay) (\(imaging.modalityCode))")
                            .font(.custom("Montserrat-Medium", size: 16))
                            .foregroundColor(.black)
                        Spacer()
                        
                        Text(imaging.status)
                            .font(.caption)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 4)
                            .background(Color.green.opacity(0.2))
                            .foregroundColor(.green)
                            .clipShape(Capsule())

                        
                    }
                    .padding(.top,12)
                    .padding(.horizontal,12)

                    Text("Hospital Name")
                        .font(.custom("Montserrat-Regular", size: 13))
                        .foregroundColor(.black)
                        .padding(.horizontal,12)
                    
                    Text(imaging.formattedStartDate)
                        .font(.custom("Montserrat-Regular", size: 13))
                        .foregroundColor(.black)
                        .padding(.horizontal,12)

                    Text(imaging.description)
                        .font(.custom("Montserrat-Medium", size: 16))
                        .foregroundColor(.black)
                        .padding(.horizontal,12)

                    
                    Button(action: onTap) {
                        Text("View Details")
                            .font(.custom("Montserrat-Bold", size: 14))
                            .foregroundColor(.white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color(hex: "FF6605"))
                            .cornerRadius(20)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.bottom, 12)
                    .padding(.horizontal,12)

                }
                .padding(.leading, 12)
                .background(Color.white)
                .cornerRadius(8)
                .shadow(radius: 4)

            
        }

}

struct ImagingSectionView: View {

    let arrayImaging: [ImagingDummyData]
    let searchText: String
    var onCardTap: (ImagingDummyData) -> Void
    
    var filteredAppointments: [ImagingDummyData] {
           if searchText.isEmpty {
               return arrayImaging
           } else {
               return arrayImaging.filter { imaging in
                   imaging.modalityDisplay.localizedCaseInsensitiveContains(searchText) ||
                   imaging.modalityCode.localizedCaseInsensitiveContains(searchText)
               }
           }
       }


    
    var body: some View {
        
        VStack(spacing: 20) {
            // Horizontal date cards
            
            if filteredAppointments.isEmpty {
                NoDataView()
            } else {
                ForEach(filteredAppointments) { data in
                    ImagingMainView(imaging: data) {
                        onCardTap(data)
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}
