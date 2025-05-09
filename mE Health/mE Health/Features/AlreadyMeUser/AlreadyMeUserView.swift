//
//  AlreadyMeUserView.swift
//  mE Health
//
//  Created by Rashida on 9/05/25.
//

import SwiftUI
import ComposableArchitecture

struct AlreadyMeUserView: View {

    @FocusState private var isTextFieldFocused: Bool
    @Environment(\.colorScheme) var colorScheme
    let store: StoreOf<AlreadyMeUserFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(spacing: 30) {
                if colorScheme == .dark {
                    GIFView(gifName: "ME")
                        .frame(width: 133, height: 133)
                        .padding(.top, 179)
                } else {
                    GIFView(gifName: "mELogo")
                        .frame(width: 133, height: 133)
                        .padding(.top, 179)
                }

                Text("Welcome Back")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                    .padding(.top, -40)

                InputField(
                    label: "Email",
                    icon: "personicon",
                    placeholder: "Enter Email",
                    text: viewStore.binding(
                        get: \.email,
                        send: AlreadyMeUserFeature.Action.emailChanged
                    ),
                    isSecure: false,
                    showPassword: .constant(false),
                    showValidation: viewStore.showValidationErrors,
                    validation: Validator.validateEmail
                )
                .keyboardType(.emailAddress)
                .focused($isTextFieldFocused)
                .padding(.horizontal)
                .padding(.top, 20)

                Button {
                    viewStore.send(.sendTapped)
                } label: {
                    HStack {
                        Spacer()
                        if viewStore.isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        } else {
                            Text("Continue")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                            Image("remix-icons")
                                .renderingMode(.template)
                                .foregroundColor(.white)
                        }
                        Spacer()
                    }
                    .padding()
                    .background(Theme.primary)
                    .cornerRadius(25)
                }
                .disabled(viewStore.isLoading)
                .padding(.top, 20)
                .padding(.horizontal)

                Button {
                    viewStore.send(.navigateBackToLoginTapped)
                } label: {
                    (
                        Text("Back to ")
                            .foregroundColor(.primary)
                        + Text("Login")
                            .foregroundColor(Theme.primary)
                    )
                    .font(.footnote)
                    .padding(.top, 20)
                }
                .disabled(viewStore.isLoading)

                Spacer()
            }
            .padding()
            .background(Color(.systemBackground))
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            .alert(
                isPresented: viewStore.binding(
                    get: \.showAlert,
                    send: { _ in .dismissAlert }
                )
            ) {
                Alert(
                    title: Text("Info"),
                    message: Text(viewStore.alertMessage ?? ""),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }

}

#Preview {
    AlreadyMeUserView(
        store: Store(
            initialState: AlreadyMeUserFeature.State(),
            reducer: {
                AlreadyMeUserFeature()
            }
        )
    )
}
