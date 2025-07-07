//
//  ImagePreviewView.swift
//  mE Health
//
//  Created by Rashida on 2/07/25.
//
import SwiftUI
struct UploadPreviewView: View {
    let image: UIImage

    @State private var isExpanded = true
    @State private var selectedTags: Set<String> = ["Practitioner", "Appointment", "Condition"]
    @Environment(\.presentationMode) var presentationMode
    @State private var showSaveAlert = false
    
    private let tags = [
        "Practitioner", "Appointment", "Condition", "Lab", "Vital",
        "Medication", "Visits", "Billing", "Procedure", "Allergy", "Immunization"
    ]

    @State private var tagWidths: [String: CGFloat] = [:]
    
    private var tagRows: [[String]] {
        var rows: [[String]] = [[]]
        let totalWidth = UIScreen.main.bounds.width - 48
        var currentRowWidth: CGFloat = 0

        for tag in tags {
            let tagWidth = tagWidths[tag, default: 150] + 12
            if currentRowWidth + tagWidth > totalWidth {
                rows.append([tag])
                currentRowWidth = tagWidth
            } else {
                rows[rows.count - 1].append(tag)
                currentRowWidth += tagWidth
            }
        }

        return rows
    }


    var body: some View {
        VStack(spacing: 16) {

            // Title
            Text("Data Items")
                .font(.custom("Montserrat-Bold", size: 28))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)

            // Image
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .cornerRadius(8)
                .padding(.horizontal)

            // File Info
            VStack(spacing: 4) {
                Text("Name: Image_20250623_173306.jpg")
                Text("File Size: 3.72 MB")
            }
            .font(.custom("Montserrat-Regular", size: 14))
            .foregroundColor(.gray)

            // Dropdown with tags
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text("Image")
                        .font(.custom("Montserrat-SemiBold", size: 16))
                    Spacer()
                    Button(action: { isExpanded.toggle() }) {
                        Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                            .foregroundColor(Color(hex: "FF6605"))
                    }
                }
                .padding([.top,.bottom], 16)
                
                
                if isExpanded {
                    HStack(spacing: 0) {
                        Rectangle()
                            .fill(Color(hex: "FF6605"))
                            .frame(height: 1)
                    }
                    .frame(maxWidth: .infinity)
                    .padding([.leading,.trailing], 0)

                }

                if isExpanded {
                    VStack(alignment: .leading, spacing: 12) {
                        ForEach(tagRows, id: \.self) { row in
                            HStack(spacing: 12) {
                                ForEach(row, id: \.self) { tag in
                                    TagItemView(tag: tag, isSelected: selectedTags.contains(tag)) {
                                        if selectedTags.contains(tag) {
                                            selectedTags.remove(tag)
                                        } else {
                                            selectedTags.insert(tag)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding([.top,.bottom], 16)
                    .onPreferenceChange(TagWidthPreferenceKey.self) { value in
                        tagWidths = value
                    }
                }
                
            }
            .padding()
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke((Color(hex: "FF6605")), lineWidth: 1)
            )
            Spacer()

            // Action Buttons
            HStack(spacing: 16) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Cancel")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(32)
                        .overlay(
                            RoundedRectangle(cornerRadius: 32)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                        )
                }
                .foregroundColor(.black)

                Button(action: {
                    showSaveAlert = true
                }) {
                    Text("Save")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(hex: "FF6605"))
                        .foregroundColor(.white)
                        .cornerRadius(32)
                }
                .alert("Saved Successfully", isPresented: $showSaveAlert) {
                    Button("OK") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .padding(.horizontal)
            
            Spacer()

        }
        .padding(.horizontal,16)
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



struct TagWidthPreferenceKey: PreferenceKey {
    static var defaultValue: [String: CGFloat] = [:]

    static func reduce(value: inout [String: CGFloat], nextValue: () -> [String: CGFloat]) {
        value.merge(nextValue(), uniquingKeysWith: { $1 })
    }
}

struct TagItemView: View {
    let tag: String
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 4) {
                Text(tag)
                if isSelected {
                    Image("tick_full")
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .stroke((Color(hex: "FF6605")), lineWidth: 1)
            )
            .foregroundColor((Color(hex: "FF6605")))
            .font(.custom("Montserrat-Regular", size: 14))
            .background(
                GeometryReader { geo in
                    Color.clear
                        .preference(key: TagWidthPreferenceKey.self, value: [tag: geo.size.width])
                }
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

