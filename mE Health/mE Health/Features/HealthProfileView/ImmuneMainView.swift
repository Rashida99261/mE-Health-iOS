
import SwiftUI

struct ImmuneDummyData: Identifiable, Equatable {
    let id: UUID = UUID()
    let name: String
    let recordDate: String
    let location: String
    var isCompleted: Bool = true
}


struct ImmuneMainView: View {

    let immune: ImmuneDummyData
    let onTap: () -> Void
        
        
        var body: some View {

                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text(immune.name)
                            .font(.custom("Montserrat-Medium", size: 20))
                            .foregroundColor(.black)
                        Spacer()
                        
                        if immune.isCompleted {
                            
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

                    Text(immune.recordDate)
                        .font(.custom("Montserrat-Medium", size: 16))
                        .foregroundColor(.gray)
                        .padding(.horizontal,12)
                    
                    Text(immune.location)
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
        
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 24) {
                // Horizontal date cards
                
                Spacer()
                
                HStack(spacing: 16) {
                    DateCardView(title: "Start Date", date: startDate)
                    DateCardView(title: "End Date", date: endDate)
                }
                
                    VStack(spacing: 24) {
                        
                        
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(Color(hex: Constants.API.PrimaryColorHex))
                                .padding(.leading, 8)

                            TextField("Search ....", text: $searchText)
                                .font(.custom("Montserrat-Regular", size: 14))
                                .padding(.vertical, 10)
                                .padding(.horizontal, 4)
                        }
                        .frame(height: 50)
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(hex: Constants.API.PrimaryColorHex), lineWidth: 1.5)
                        )
                        .cornerRadius(10)

                        
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
}
