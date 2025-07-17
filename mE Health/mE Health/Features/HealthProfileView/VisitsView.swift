//
//  VisitsView.swift
//  mE Health
//


import SwiftUI

struct VisitDummyData: Identifiable, Equatable {
    let id: UUID = UUID()
    let name: String
    let recordDate: String
    let status: VisitStatus?
}

enum VisitStatus: String {
    case planned = "Planned"
    case cancel = "Cancelled"
    case schedule = "Scheduled"
    case finish = "Finished"
}


struct VisitsView: View {

    let visit: VisitDummyData
    let onTap: () -> Void
        
        var body: some View {

                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(visit.name)
                            .font(.custom("Montserrat-Bold", size: 18))
                            .foregroundColor(.black)
                        Spacer()
                        
                        
                        if visit.status ==  .planned {
                            
                            Text("Planned")
                                .font(.custom("Montserrat-SemiBold", size: 9))
                                .padding(.horizontal, 12)
                                .padding(.vertical, 4)
                                .background(Color(hex: "F09C00").opacity(0.2))
                                .foregroundColor(Color(hex: "F09C00"))
                                .clipShape(Capsule())

                        }
                        else if visit.status ==  .cancel {
                            Text("Canceled")
                                .font(.custom("Montserrat-SemiBold", size: 9))
                                .padding(.horizontal, 12)
                                .padding(.vertical, 4)
                                .background(Color.red.opacity(0.2))
                                .foregroundColor(Color.red)
                                .clipShape(Capsule())
                        }
                        else if visit.status ==  .schedule {
                            Text("Scheduled")
                                .font(.custom("Montserrat-SemiBold", size: 9))
                                .padding(.horizontal, 12)
                                .padding(.vertical, 4)
                                .background(Color.blue.opacity(0.2))
                                .foregroundColor(Color.blue)
                                .clipShape(Capsule())
                        }
                        else if visit.status ==  .finish {
                            Text("Finished")
                                .font(.custom("Montserrat-SemiBold", size: 9))
                                .padding(.horizontal, 12)
                                .padding(.vertical, 4)
                                .background(Color.green.opacity(0.2))
                                .foregroundColor(Color.green)
                                .clipShape(Capsule())
                        }
                        
                    }
                    .padding(.top,12)
                    .padding(.horizontal,12)

                    Text(visit.recordDate)
                        .font(.custom("Montserrat-Regular", size: 14))
                        .foregroundColor(.black)
                        .padding(.horizontal,12)

                    
                    Button(action: onTap) {
                        Text("View Details")
                            .font(.custom("Montserrat-SemiBold", size: 14))
                            .foregroundColor(.white)
                            .frame(width:135)
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

struct VisitsSectionView: View {
    let visit: [VisitDummyData]
    let searchText: String
    var onCardTap: (VisitDummyData) -> Void
    
    var filterVisits: [VisitDummyData] {
           if searchText.isEmpty {
               return visit
           } else {
               return visit.filter { vData in
                   vData.name.localizedCaseInsensitiveContains(searchText)
               }
           }
       }

    
    var body: some View {
        
        VStack(spacing: 20) {
            // Horizontal date cards
            
            if filterVisits.isEmpty {
                NoDataView()
            } else {
                ForEach(filterVisits) { visitData in
                    VisitsView(visit: visitData) {
                        onCardTap(visitData)
                    }
                }
            }

        }
        .padding(.horizontal)
    }
}
