//
//  DatePickerPage.swift
//  mE Health
//
//  Created by Rashida on 9/05/25.
//

import SwiftUI

struct DatePickerPage: View {
    @Binding var selectedDate: Date
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment: .center)
        {
            Spacer()
            
            DatePicker("", selection: $selectedDate, displayedComponents: [.date])
                .datePickerStyle(.wheel)
                .labelsHidden()
            
            Spacer()
        }
    }
}


