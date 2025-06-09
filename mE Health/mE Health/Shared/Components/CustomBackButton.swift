//
//  CustomBackButton.swift
//  mE Health
//
//  Created by Rashida on 9/06/25.
//

import SwiftUI

struct CustomBackButton: View {
    var title: String = "Back"
    var color: Color = Color(hex: Constants.API.PrimaryColorHex)
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 4) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 17, weight: .medium))
                Text(title)
                    .font(.custom("Montserrat-Medium", size: 16))
            }
            .foregroundColor(color)
        }
    }
}
