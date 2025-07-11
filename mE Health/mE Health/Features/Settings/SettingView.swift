//
//  SettingView.swift
//  mE Health
//
//  Created by Rashida on 4/07/25.
//

import SwiftUI
import ComposableArchitecture

struct SettingView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var locationAccess: LocationAccess = .whileUsing
    @State private var siriAccess: Bool = true
    @State private var whileUsing: Bool = true
    @State private var Always: Bool = true
    @State private var allowNever: Bool = true
    @State private var allowAlways: Bool = true
    @State private var allowMeAlways: Bool = true
    
    @State private var isClinicListActive = false
    
    private let clinicStore: Store<ClinicFeature.State, ClinicFeature.Action> = {
            withDependencies {
                $0.practicesClient = PracticesClientKey.liveValue
                $0.localClinicStorage = LocalClinicStorageKey.liveValue
            } operation: {
                Store(
                    initialState: ClinicFeature.State(),
                    reducer: { ClinicFeature() }
                )
            }
        }()

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("My Settings")
                        .font(.custom("Montserrat-Bold", size: 37))
                        .padding(.horizontal)
                    
                    Group {
                        Text("Preferences")
                            .font(.custom("Montserrat-SemiBold", size: 16))

                        SettingRow(icon: "setting", title: "Connected Health Accounts") {
                            isClinicListActive = true
                        }
                        SettingRow(icon: "lockOrange", title: "Change Password") {
                            
                        }
                        SettingRow(icon: "Odometer", title: "Update Preferences") {
                            
                        }
                    }
                    .padding(.horizontal)
                    
//                    NavigationLink(
//                        destination: ClinicListView(
//                            store: Store(
//                                initialState: ClinicFeature.State(),
//                                reducer: { ClinicFeature() }
//                            )
//                        ),
//                        isActive: $isClinicListActive
//                    ) {
//                        EmptyView()
//                    }
                    
                    NavigationLink(
                                    destination: ClinicListView(store: clinicStore),
                                    isActive: $isClinicListActive
                                ) {
                                    EmptyView()
                                }
                    
//                    NavigationLink(
//                        destination: {
//                            let store = withDependencies {
//                                $0.practicesClient = PracticesClientKey.liveValue
//                                $0.localClinicStorage = LocalClinicStorageKey.liveValue// Replace with your concrete local storage instance
//                            } operation: {
//                                Store(
//                                    initialState: ClinicFeature.State(),
//                                    reducer: { ClinicFeature() }
//                                )
//                            }
//                            return ClinicListView(store: store)
//                        }(),
//                        isActive: $isClinicListActive
//                    ) {
//                        EmptyView()
//                    }

                    Spacer(minLength: 8)

                    Group {
                        Text("Allow Location Access")
                            .font(.custom("Montserrat-SemiBold", size: 16))
                        
                        ToggleRow(label: "Never", icon: "never", isOn: $allowNever)
                        
                        ToggleRow(label: "While Using The App", icon: "play", isOn: $allowAlways)
                        
                        ToggleRow(label: "Always", icon: "tick", isOn: $Always)

                    }
                    .padding(.horizontal)
                    
                    Spacer(minLength: 8)

                    Group {
                        Text("Allow mE to Access")
                            .font(.custom("Montserrat-SemiBold", size: 16))
                        
                        ToggleRow(label: "Siri & Search", icon: "remix", isOn: $siriAccess)
                        
                        ToggleRow(label: "While Using The App", icon: "married", isOn: $whileUsing)
                        
                        ToggleRow(label: "Always", icon: "married", isOn: $allowMeAlways)
                    }
                    .padding(.horizontal)
                }
                .padding(.horizontal)
            }

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

    enum LocationAccess {
        case never, whileUsing, always
    }
}

// MARK: - Reusable Components

struct SettingRow: View {
    var icon: String
    var title: String
    var onTap: () -> Void = {}

    var body: some View {
        Button(action: {
            onTap()
        }) {
            HStack {
                Image(icon)
                    .foregroundColor(Color(hex: Constants.API.PrimaryColorHex))
                Text(title)
                    .font(.custom("Montserrat-Medium", size: 16))
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .shadow(radius: 5)
        }
        .buttonStyle(PlainButtonStyle()) // So it looks like your custom row, not a blue button
    }

}



struct ToggleRow: View {
    var label: String
    var icon: String
    @Binding var isOn: Bool

    var body: some View {
        HStack {
            Image(icon)
                .foregroundColor(Color(hex: Constants.API.PrimaryColorHex))
            Text(label)
                .font(.custom("Montserrat-Medium", size: 16))
            Spacer()
            Toggle("", isOn: $isOn)
                .toggleStyle(CustomToggleStyle())
                .labelsHidden()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius:5)
    }
}




// MARK: - Preview

#Preview {
    SettingView()
}


struct CustomToggleStyle: ToggleStyle {
    var onColor: Color = Color(hex: "#FF6605")
    var offColor: Color = Color(hex: "#6E6B78")

    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(configuration.isOn ? onColor : offColor)
                    .frame(width: 40, height: 24)

                Circle()
                    .fill(Color.white)
                    .frame(width: 18, height: 18)
                    .offset(x: configuration.isOn ? 10 : -10)
                    .animation(.easeInOut(duration: 0.2), value: configuration.isOn)
            }
            .onTapGesture {
                configuration.isOn.toggle()
            }
        }
    }
}
