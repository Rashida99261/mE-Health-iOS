
import SwiftUI
import ComposableArchitecture

struct AdviceItem: Identifiable {
    let id = UUID()
    let iconName: String
    let title: String
    let count: String
}

struct AdviceCard: View {
    
    let item: AdviceItem

    var body: some View {
        VStack {
            Spacer()
            
            Image(item.iconName)
                .resizable()
                .scaledToFit()
                .frame(width: 28, height: 28)


            Text(item.title)
                .foregroundColor(.black)
                .font(.custom("Montserrat-Bold", size: 10))
                .padding(.top, 8)

            Text(item.count)
                .foregroundColor(Color(hex: "FB531C"))
                .font(.custom("Montserrat-Bold", size: 13))
                .padding(.top, 8)

            Spacer()
        }
        .frame(height: 150)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 5)
        .padding(4)
    }
}

// MARK: - Clinic List View
struct AdviceView: View {
    
    @Environment(\.presentationMode) var presentationMode
    // 2-column grid layout
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    let adviceItems = [
        AdviceItem(iconName: "Finance", title: "Finance", count: "1"),
        AdviceItem(iconName: "PersonalCare", title: "Personal Care & Activity", count: "2"),
        AdviceItem(iconName: "familycare", title: "Family Care", count: "3"),
        AdviceItem(iconName: "carProfile", title: "Auto maintenance", count: "40"),
        AdviceItem(iconName: "home_p", title: "Home maintenance", count: "99"),
        AdviceItem(iconName: "Vacations", title: "Vacations", count: "6"),
        AdviceItem(iconName: "Health", title: "Health", count: "7")
    ]

    
    
    

    var body: some View {
            NavigationStack {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Advice")
                        .font(.custom("Montserrat-Bold", size: 34))
                        .padding(.horizontal)

                    // Grid List
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(adviceItems) { item in
                                    AdviceCard(item: item)
                                        .onTapGesture {
                                            // Handle tap
                                        }
                                }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.top)
                .onAppear {
                    
                }
                
            }
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

#Preview {
    AdviceView()
}
