//
//  ImagingDetailView.swift
//  mE Health
//
//  Created by Rashida on 7/07/25.
//
import SwiftUI

struct ImagingDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    let imaging: ImagingDummyData
    
    let sampleSeries: [SeriesItem] = [
        SeriesItem(title: "Series 1", imageName: "series_placeholder", reportType: "jpg", iconType: "Image"),
        SeriesItem(title: "Series 2", imageName: "series_placeholder", reportType: "pdf", iconType: "doc"),
        SeriesItem(title: "Series 3", imageName: "series_placeholder", reportType: "pdf", iconType: "doc"),
        SeriesItem(title: "Series 4", imageName: "series_placeholder", reportType: "jpg", iconType: "Image")
    ]
    @State private var showModal = false
    @State private var selectedSeries: SeriesItem? = nil
    @Environment(\.viewController) private var viewControllerHolder: UIViewController?


    var body: some View {
        
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(spacing: 24) {
                    
                    // Title
                    Text("Details")
                        .font(.custom("Montserrat-Bold", size: 32))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text(imaging.title)
                                .font(.custom("Montserrat-Medium", size: 16))
                                .foregroundColor(.black)
                            Spacer()
                            
                            Text("Final")
                                .font(.caption)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 4)
                                .background(Color.green.opacity(0.2))
                                .foregroundColor(.green)
                                .clipShape(Capsule())

                            
                        }
                        .padding(.top,12)
                        .padding(.horizontal,12)

                        Text(imaging.hospitalNAme)
                            .font(.custom("Montserrat-Regular", size: 13))
                            .foregroundColor(.black)
                            .padding(.horizontal,12)
                        
                        Text(imaging.dateValue)
                            .font(.custom("Montserrat-Regular", size: 13))
                            .foregroundColor(.black)
                            .padding(.horizontal,12)

                        Text(imaging.diagnosisValue)
                            .font(.custom("Montserrat-Medium", size: 16))
                            .foregroundColor(.black)
                            .padding(.horizontal,12)
                        
                        Text("ID: #HYP2022105")
                            .font(.custom("Montserrat-SemiBold", size: 16))
                            .foregroundColor(Color(hex: "FF6605"))
                            .padding(.horizontal,12)

                    }
                    .padding()
                    .background(.white)
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 2)
                    .padding(.horizontal)



                    // Patient Card
                    HStack {
                        Image("profile_placeholder") // Replace with actual image
                            .resizable()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("\(userProfileData?.first_name ?? "") \(userProfileData?.last_name ?? "")")
                                .font(.custom("Montserrat-Medium", size: 18))
                                .foregroundColor(Color(hex: "FF6605"))
                            Text("Hospital Name")
                                .font(.custom("Montserrat-Regular", size: 14))
                                .foregroundColor(.gray)
                        }

                        Spacer()

                        Image(systemName: "arrow.right")
                            .foregroundColor(Color(hex: "FF6605"))
                    }
                    .padding()
                    .background(.white)
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 2)
                    .padding(.horizontal)
                    



                    // Visits Card
                    VStack(alignment: .leading, spacing: 12) {
                        HStack(spacing: 24) {
                            Rectangle()
                                .fill(Color(hex: "FF6605"))
                                .frame(width: 5)
                                .frame(height:90)
                                .padding(.leading, 6)
                          
                            VStack(alignment: .leading, spacing: 12) {
                                
                                Text("Conditions (2)")
                                    .font(.custom("Montserrat-Bold", size: 19))
                                    .padding(.leading, 4)
                                
                                HStack {
                                    Text("Essential Hypertension")
                                        .font(.custom("Montserrat-Regular", size: 12))
                                    Spacer()
                                    Text("Clinical Status: Active")
                                        .font(.custom("Montserrat-Medium", size: 12))
                                }
                                
                                HStack {
                                    Text("Type 2 Diabetic")
                                        .font(.custom("Montserrat-Regular", size: 12))
                                    Spacer()
                                    Text("Clinical Status: Active")
                                        .font(.custom("Montserrat-Medium", size: 12))
                                }

                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color.white) // Light blue background
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 2)
                    .padding(.horizontal)
                    
                    
                    
                    VStack(alignment: .leading, spacing: 12) {
                        HStack(spacing: 24) {
                            Rectangle()
                                .fill(Color(hex: "FF6605"))
                                .frame(width: 5)
                                .frame(height:90)
                                .padding(.leading, 6)
                          
                            VStack(alignment: .leading, spacing: 12) {
                                
                                Text("Procedures (1)")
                                    .font(.custom("Montserrat-Bold", size: 19))
                                
                                HStack {
                                    Text("Appendectomy")
                                        .font(.custom("Montserrat-Regular", size: 12))
                                    Spacer()
                                    Text("Status: Completed")
                                        .font(.custom("Montserrat-Medium", size: 12))
                                }

                            }
                            
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color.white) // Light blue background
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 2)
                    .padding(.horizontal)
                    
                    
                    VStack(alignment: .leading, spacing: 12) {
                        
                        Text("Performer")
                            .font(.custom("Montserrat-Bold", size: 17))
                            .foregroundColor(.black)
                        Text("Dr. David")
                            .font(.custom("Montserrat-SemiBold", size: 13))

                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 2)
                    .padding(.horizontal)

                    
                    VStack(alignment: .leading, spacing: 12) {
                        
                        HStack(spacing: 8) {
                            Text("Visits Status")
                                .font(.custom("Montserrat-Bold", size: 17))
                                .foregroundColor(.black)
                            
                            Spacer()
                            
                            Text("In-progress")
                                .font(.caption)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 4)
                                .background(Color.blue.opacity(0.2))
                                .foregroundColor(.blue)
                                .clipShape(Capsule())
                            
                        }
                        Text("Start Date: 11/06/2025")
                            .font(.custom("Montserrat-SemiBold", size: 13))

                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 2)
                    .padding(.horizontal)


                    SeriesGridView(items: sampleSeries) { series in
                        self.viewControllerHolder?.present(style: .overCurrentContext, transitionStyle: .crossDissolve) {
                            ImageViewerCard(item: series)
                        }
                    }

                    // Bottom Buttons
                    ActionButtonsView(title: "Sync Data")

                    
                    Spacer()

                }
                
            }
            .padding(.top)
            .background(Color((UIColor.systemGray6)).ignoresSafeArea())
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

#Preview {
    ImagingDetailView(imaging: ImagingDummyData(title: "X-Ray (DX)", hospitalNAme: "Hospital name", dateValue: "11 Jun 2025", diagnosisValue: "Chest X-ray for bronchitis"))
}
