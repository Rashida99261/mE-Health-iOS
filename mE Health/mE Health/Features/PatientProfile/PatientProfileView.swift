//
//  PatientProfileView.swift
//  mE Health
//
//  Created by Ishant on 13/06/25.
//

import SwiftUI
import ComposableArchitecture

struct PatientProfileView: View {
    let store: StoreOf<PatientProfileFeature>
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack(alignment: .leading, spacing: 0) {
                Text("My Profile")
                    .font(.custom("Montserrat-Bold", size: 37))
                    .padding()

                // Header Card
                VStack(alignment: .leading,spacing: 24) {
                    HStack(spacing: 8) {
                        VStack(alignment: .leading,spacing: 12) {
                            Text(viewStore.name)
                                .font(.custom("Montserrat-Bold", size: 24))
                                .foregroundColor(Color(hex: "FF6605"))
                            Text(viewStore.addressLine)
                                .font(.custom("Montserrat-Regular", size: 14))
                                .foregroundColor(Color(hex: "333333"))
                            ProgressView(value: viewStore.completion)
                                .accentColor(.green)
                                .padding([.top,.bottom],4)
                                
                        }
                        .padding(.leading,8)
                        Spacer()
                        Image("profile_placeholder")
                            .resizable()
                            .frame(width: 74, height: 74)
                            .padding(.trailing, 8)
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(radius: 2)
                .padding(.horizontal)
                .frame(height:150)
                
                Spacer()
                
                VStack(alignment: .leading,spacing: 8) {
                    
                    Text("Basic Details")
                        .font(.custom("Montserrat-Medium", size: 18))
                        .foregroundColor(.black)
                        .padding(.leading,16)
                        .padding(.top,16)
                        
                    ScrollView {
                        VStack(spacing: 24) {
                            ProfileCardView(icon: "Phone", title: "Phone", value: viewStore.phone)
                            ProfileCardView(icon: "mail", title: "Email", value: viewStore.email)
                            ProfileCardView(icon: "address", title: "Address (\(viewStore.addresses.count))", value: viewStore.addresses.first ?? "")
                            ProfileCardView(icon: "anniversary", title: "Anniversary", value: viewStore.anniversary ?? "")

                            MarriedCardView(icon: "married", title: "Married", isOn: viewStore.binding(
                                get: \.isMarried,
                                send: PatientProfileFeature.Action.toggleMarried
                            ))

                            ProfileCardView(icon: "gender", title: "Gender", value: viewStore.gender)
                            ProfileCardView(icon: "dob", title: "Date Of Birth", value: viewStore.dob)
                        }
                        .padding()
                    }
                }

            }
            .background(Color(UIColor.systemGray6))
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


struct ProfileCardView: View {
    let icon: String
    let title: String
    let value: String

    var body: some View {
        Group {
            if value.isEmpty {
                HStack(spacing: 12) {
                    Image(icon)
                        .font(.title3)
                        .foregroundColor(.orange)

                    Text(title)
                        .font(.custom("Montserrat-Medium", size: 17))
                        .foregroundColor(.gray)

                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding()
            } else {
                HStack(alignment: .top, spacing: 12) {
                    Image(icon)
                        .font(.title3)
                        .foregroundColor(.orange)
                        .padding(.top, 4)

                    VStack(alignment: .leading, spacing: 4) {
                        Text(title)
                            .font(.custom("Montserrat-Medium", size: 17))
                            .foregroundColor(.gray)


                        Text(value)
                            .font(.custom("Montserrat-SemiBold", size: 17))
                            .foregroundColor(.gray)
                    }

                    Spacer()
                }
                .padding()
            }
        }
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .gray.opacity(0.1), radius: 3, x: 0, y: 1)
    }
}

struct MarriedCardView: View {
    let icon: String
    let title: String
    @Binding var isOn: Bool

    var body: some View {
        HStack(spacing: 12) {
            Image(icon)
                .font(.title3)
                .foregroundColor(.orange)

            Text(title)
                .font(.custom("Montserrat-Medium", size: 17))
                .foregroundColor(.gray)

            Spacer()

            Toggle("", isOn: $isOn)
                .labelsHidden()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .gray.opacity(0.1), radius: 3, x: 0, y: 1)
    }
}



#Preview {
    PatientProfileView(
        store: Store(
            initialState: PatientProfileFeature.State(),
            reducer: {
                PatientProfileFeature()
            }
        )
    )
}
