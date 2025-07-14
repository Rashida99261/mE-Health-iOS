import SwiftUI

struct MedicationAllView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    let array: [VitalTempData] = [
        VitalTempData(dateString: "Cetirizine 10 mg", vitalName: "1 General Street, Lawrence, MA 01841"),
        VitalTempData(dateString: "Cetirizine 10 mg", vitalName: "1 General Street, Lawrence, MA 01841"),
        VitalTempData(dateString: "Cetirizine 10 mg", vitalName: "1 General Street, Lawrence, MA 01841"),
        VitalTempData(dateString: "Cetirizine 10 mg", vitalName: "1 General Street, Lawrence, MA 01841")
    ]
    
    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 16) {
                    
                    Text("List of Medication")
                        .font(.custom("Montserrat-Bold", size: 32))
                        .padding(.horizontal)
                    
                    if array.isEmpty {
                        NoDataView()
                    } else {
                        ForEach(array) { vital in
                            HStack(spacing: 12) {
                                Image("date_placeholder")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(Color(hex: "FF6605"))
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(vital.dateString)
                                        .font(.custom("Montserrat-Medium", size: 16))
                                        .foregroundColor(.black)
                                    
                                    Text(vital.vitalName)
                                        .font(.custom("Montserrat-Regular", size: 12))
                                        .foregroundColor(Color(hex: "FF6605"))
                                }
                            }
                            .padding(12)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 2)
                            
                        }
                    }
                }
                .padding(.horizontal,16)
                .padding(.vertical)
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

