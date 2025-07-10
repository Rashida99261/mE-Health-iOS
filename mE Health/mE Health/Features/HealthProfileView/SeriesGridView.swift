//
//  SeriesGridView.swift
//  mE Health
//
//  Created by Rashida on 7/07/25.
//

import SwiftUI

struct SeriesItem: Identifiable {
    let id = UUID()
    let title: String
    let imageName: String
    let reportType: String // "jpg" or "pdf"
    let iconType: String
}

struct SeriesGridView: View {
    let items: [SeriesItem]
    let onItemTap: (SeriesItem) -> Void
    

    let columns = [
        GridItem(.flexible(), spacing: 24),
        GridItem(.flexible(), spacing: 24)
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("Series Preview")
                .font(.custom("Montserrat-Bold", size: 18))
                .padding(.horizontal, 12)
                .padding(.top)

            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(items) { item in
                    SeriesCardView(item: item)
                        .onTapGesture {
                            onItemTap(item)
                        }

                }
            }
            .padding(.horizontal, 12)
            .padding(.bottom)
        }
        .background(.clear)
        .cornerRadius(12)
        .padding(.horizontal)
    }
}


struct SeriesCardView: View {
    let item: SeriesItem

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(item.imageName)
                .resizable()
                .scaledToFill()
                .frame(width:145) // ✅ Forces full width of card
                .frame(height: 56)
                .clipped()
                .cornerRadius(10)


            Text(item.title)
                .font(.custom("Montserrat-Regular", size: 14))

            HStack(spacing: 4) {
                Image(item.iconType)
                Text("6 Image")
                    .font(.custom("Montserrat-Regular", size: 10))

                Text("Report.\(item.reportType)")
                    .font(.custom("Montserrat-Bold", size: 10))
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        .frame(maxWidth: .infinity)
    }
}


struct ImageViewerCard: View {
    let item: SeriesItem
    @Environment(\.viewController) private var viewControllerHolder: UIViewController?

    var body: some View {
        ZStack {
            // Dimmed background
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture {
                    viewControllerHolder?.dismiss(animated: true)
                }

            VStack(spacing: 0) {
                Spacer()

                ZStack(alignment: .top) {
                    VStack(spacing: 16) {
                        // Drag indicator
                        Capsule()
                            .frame(width: 40, height: 5)
                            .foregroundColor(Color(hex: "F5F5FC"))
                            .padding(.top, 12)

                        // Title

                        Text(item.title)
                            .font(.custom("Montserrat-Regular", size: 16))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading,12)

                        HStack(spacing: 4) {
                            Image(item.iconType)
                            Text("6 Image")
                                .font(.custom("Montserrat-Regular", size: 14))

                            Text("Report.\(item.reportType)")
                                .font(.custom("Montserrat-Bold", size: 14))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading,12)



                        // X-ray Image
                        Image(item.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 350, height: 350)
                            .clipped()
                            .cornerRadius(20)

                        Spacer()
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: UIScreen.main.bounds.height * 0.65)
                    .background(
                        RoundedCorner(radius: 24, corners: [.topLeft, .topRight])
                            .fill(Color(hex: "F5F5FC"))
                    )
                    .clipShape(RoundedCorner(radius: 24, corners: [.topLeft, .topRight]))
                    .shadow(radius: 10)


                    // Close Button (X)
                    Button(action: {
                        viewControllerHolder?.dismiss(animated: true)
                    }) {
                        Image("close")
                            .frame(width: 40, height: 40)
                            .background(Color(hex: "F5F5FC"))
                            .clipShape(Circle())
                            .shadow(radius: 2)
                    }
                    .padding(.top, -64)
                }
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

