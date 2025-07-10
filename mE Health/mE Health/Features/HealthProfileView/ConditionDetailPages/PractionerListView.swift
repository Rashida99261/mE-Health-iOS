import SwiftUI


struct condPracItem: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let hospitalName: String
}


struct PractionerListView: View {

    @Environment(\.presentationMode) var presentationMode
    let arrayItem : [condPracItem] = [
        condPracItem(name: "Dr. Emily Carter, MD", hospitalName: "Family Medicine"),
        condPracItem(name: "Dr. Rajesh Patel, MD", hospitalName: "Allergy and Immunology"),
        condPracItem(name: "Dr. Susan Lee, MD", hospitalName: "Pulmonary Medicine"),
        condPracItem(name: "Dr. Michael Nguyen, MD", hospitalName: "Cardiology"),
        condPracItem(name: "Dr. Laura Kim, MD", hospitalName: "Diagnostic Radiology"),
        condPracItem(name: "Dr. James O’Connor, MD", hospitalName: "Orthopedic Surgery"),
        condPracItem(name: "Dr. Richard Allara, MD", hospitalName: "Family Medicine")
    ]
    @State private var showDetail = false
    let condition: ConditionDummyData
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 12) {
            
            Text("List Of Practitioners")
                .font(.custom("Montserrat-Bold", size: 32))
                .padding(.horizontal)
            
            Divider()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    if arrayItem.isEmpty {
                        NoDataView()
                    } else {
                        ForEach(arrayItem) { item in
                            PracItemCardView(item: item) {
                                // Your action here
                                showDetail = true
                            }
                            .frame(maxWidth: .infinity, alignment: .leading) // align cards left full width
                        }
                    }
                }
                .padding(.horizontal)
            }
            
            NavigationLink(
                destination: TreatmentDetailView(condition: condition),
                isActive: $showDetail,
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


struct PracItemCardView: View {
    
    let item : condPracItem
    let onTap: () -> Void
    
    var body: some View {
        
        VStack(spacing: 8) {
            
            HStack {
                Image("profile_placeholder") // Replace with actual image
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.name)
                        .font(.custom("Montserrat-Medium", size: 18))
                        .foregroundColor(Color(hex: "FF6605"))
                    Text(item.hospitalName)
                        .font(.custom("Montserrat-Regular", size: 14))
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                Image(systemName: "arrow.right")
                    .foregroundColor(Color.black)
            }
            .padding(.horizontal)
        }
        .frame(height: 90)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 5)
        .padding(4)
        .onTapGesture {
            onTap()
        }

    }
}


