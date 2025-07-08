
import SwiftUI

struct ImmuneResponse: Codable {
    let immunizations: [ImmuneDummyData]
}



struct ImmuneDummyData: Identifiable, Equatable, Codable {
    let id: String
    let vaccineCodeSystem: String
    let vaccineCodeCode: String
    let vaccineCodeDisplay: String
    let rawVaccineCode: String
    let status: String
    let occurrenceDate: String
    let patientId: String
    let encounterId: String
    let createdAt: String
    let updatedAt: String

    // Parsed vaccineCode as object
    var vaccineCode: CodeInfo? {
        try? JSONDecoder().decode(CodeInfo.self, from: Data(rawVaccineCode.utf8))
    }

    var formattedOccurrenceDate: String {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime]

        if let date = isoFormatter.date(from: occurrenceDate) {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            return formatter.string(from: date)
        }
        return occurrenceDate
    }

    enum CodingKeys: String, CodingKey {
        case id
        case vaccineCodeSystem = "vaccineCode_system"
        case vaccineCodeCode = "vaccineCode_code"
        case vaccineCodeDisplay = "vaccineCode_display"
        case rawVaccineCode = "vaccineCode"
        case status
        case occurrenceDate
        case patientId
        case encounterId
        case createdAt
        case updatedAt
    }
}

struct ImmuneMainView: View {

    let immune: ImmuneDummyData
    let onTap: () -> Void
        
        
        var body: some View {

                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text(immune.vaccineCodeDisplay)
                            .font(.custom("Montserrat-Medium", size: 20))
                            .foregroundColor(.black)
                        Spacer()
                        
                        if immune.status == "completed" {
                            
                            Text("Completed")
                                .font(.caption)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 4)
                                .background(Color.green.opacity(0.2))
                                .foregroundColor(.green)
                                .clipShape(Capsule())

                        }
                        else {
                            Text("Not Done")
                                .font(.caption)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 4)
                                .background(Color(hex: "F02C2C").opacity(0.2))
                                .foregroundColor(Color(hex: "F02C2C"))
                                .clipShape(Capsule())
                        }
                        
                    }
                    .padding(.top,12)
                    .padding(.horizontal,12)

                    Text("Occurrence Date: \(immune.formattedOccurrenceDate)")
                        .font(.custom("Montserrat-Medium", size: 16))
                        .foregroundColor(.gray)
                        .padding(.horizontal,12)
                    
                    Text("N/A")
                        .font(.custom("Montserrat-Medium", size: 12))
                        .foregroundColor(.gray)
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

struct ImmuneSectionView: View {
    let immune: [ImmuneDummyData]
    let startDate: String
    let endDate: String
    var onCardTap: (ImmuneDummyData) -> Void
    @State private var searchText = ""
    
    var body: some View {
        
        VStack(spacing: 20) {
            // Horizontal date cards
            
            if immune.isEmpty {
                        NoDataView()
            } else {
                ForEach(immune) { labdata in
                    ImmuneMainView(immune: labdata) {
                        onCardTap(labdata)
                    }
                }
            }
            


        }
        .padding(.horizontal)

    }
}
