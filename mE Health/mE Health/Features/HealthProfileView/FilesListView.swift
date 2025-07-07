//
//  FilesListView.swift
//  mE Health
//
//  Created by Rashida on 27/06/25.
//
import SwiftUI

struct FilesDummyData: Identifiable, Equatable {
    let id: UUID = UUID()
    let name: String
    let specialty: String
    let date: String
}



struct FilesListView: View {
    let fileData: FilesDummyData
    let onTap: () -> Void

    var body: some View {
        HStack(spacing: 4) {
            VStack(alignment: .leading, spacing: 12) {
                
                Text(fileData.name)
                    .font(.custom("Montserrat-Bold", size: 14))
                
                HStack(spacing: 0) {
                    Text("Category:")
                        .font(.custom("Montserrat-Bold", size: 14))
                    Text(fileData.specialty)
                        .font(.custom("Montserrat-Regular", size: 12))
                }

                Text(fileData.date)
                    .font(.custom("Montserrat-Regular", size: 12))

                                
            }

            Spacer()
            
            FilesActionColumn()
                .frame(height:150)
                .padding(.trailing, 0)
        }
        .padding(.leading, 12)
        .frame(height:150)
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 4)
        .onTapGesture {
            onTap()
        }
    }
}


struct FilesSectionView: View {
    let filesArray: [FilesDummyData]
    var onCardTap: (FilesDummyData) -> Void
    
    @State private var showActionSheet = false
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var mediaSource: UIImagePickerController.SourceType = .photoLibrary
    @State private var navigateToPreview = false

    @State private var showDocumentPicker = false
    @State private var selectedFileURL: URL?

    @State private var showVideoPicker = false
    @State private var selectedVideoURL: URL?


    var body: some View {
      
       // NavigationStack {
        VStack(spacing: 24) {
            // Horizontal date cards
            
            if filesArray.isEmpty {
                        NoDataView()
            } else {
                
                ForEach(filesArray) { files in
                    FilesListView(fileData: files) {
                        onCardTap(files)
                    }
                }
                
                Button(action: {
                    showActionSheet = true
                }) {
                    HStack(spacing: 8) {
                        Image("upload_white") // your custom image asset
                            .resizable()
                            .scaledToFit()
                            .frame(width: 18, height: 18) // adjust size as needed
                        
                        Text("Upload")
                            .font(.custom("Montserrat-SemiBold", size: 16))
                    }
                    .font(.custom("Montserrat-SemiBold", size: 16))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .frame(height:40)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color(hex: "FF6605"))
                    .cornerRadius(32)
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.horizontal,24)

            }
        }
        .padding(.horizontal)
        .actionSheet(isPresented: $showActionSheet) {
            ActionSheet(
                title: Text("Select Type"),
                buttons: [
                    .default(Text("Picture")) {
                        mediaSource = .photoLibrary
                        showImagePicker = true
                        
                    },
                    .default(Text("Video")) {
                        showVideoPicker = true
                    },
                    .default(Text("Document")) {
                        showDocumentPicker = true
                    },
                    .cancel()
                ]
            )
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(sourceType: mediaSource) { image in
                self.selectedImage = image
                self.navigateToPreview = true
            }
        }
        .sheet(isPresented: $showVideoPicker) {
            VideoPicker { url in
                if let url = url {
                    selectedVideoURL = url
                    // Navigate to next view or preview
                }
            }
        }
        .sheet(isPresented: $showDocumentPicker) {
            DocumentPicker { urls in
                if let first = urls.first {
                    selectedFileURL = first
                    // Navigate to your next screen or process the file
                }
            }
        }

        
        .navigationDestination(isPresented: $navigateToPreview) {
            if let selectedImage = selectedImage {
                UploadPreviewView(image: selectedImage)
            } else {
                Text("No image selected") // fallback if needed
            }
        }
    }
}


struct FilesActionColumn: View {
    let icons = ["AIAdvice", "delete", "white_Ignore"]

    var body: some View {
        VStack(spacing: 1) {
            ForEach(icons, id: \.self) { icon in
                Button(action: {
                    // Handle tap
                }) {
                    Image(icon)
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.white)
                        .frame(width: 20, height: 20)
                        .padding()
                        .frame(width: 50, height: 50)
                        .background(Color(hex: "FF6605"))
                }
            }
        }
        .padding(.trailing,0)
        .frame(width: 50) // Fixed width for the action column
        .background(
            RoundedCorners(color: Color.white, tl: 0, tr: 12, bl: 12, br: 0)
        )
    }
}

