import SwiftUI

struct NoDataView: View {
    var title: String = "No records found in this range."
    var message: String = "Maybe your body was just busy being awesome."
    
    var body: some View {
        VStack(spacing: 20) {
            // Placeholder illustration
            Image("noData")
                .resizable()
                .scaledToFit()
                .frame(width: 230, height: 230)
            
            Text(title)
                .font(.custom("Montserrat-Bold", size: 12))
                .multilineTextAlignment(.center)
            
            Text(message)
                .font(.custom("Montserrat-SemiBold", size: 12))
                .multilineTextAlignment(.center)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }


}
