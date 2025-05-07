//
//  SplashScreen.swift
//  mE Health
//
//  Created by Rashida on 8/05/25.
//

import SwiftUI
import ComposableArchitecture

struct SplashScreen: View {
    @State private var navigateToLogin = false
    @Environment(\.colorScheme) var colorScheme
    // Create the TCA store here
      private let loginStore = Store(initialState: LoginFeature.State()) {
          LoginFeature()
      }
    var body: some View {
        ZStack {
            Color(.systemBackground).ignoresSafeArea()

            VStack(spacing: 1) {
                if colorScheme == .dark {
                    GIFView(gifName: "ME")
                            .frame(width: 212, height: 212)
                        } else {
                        GIFView(gifName: "mELogo")
                                .frame(width: 212, height: 212)
                        }
                Text("mE Health")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .frame(width: 212, height: 46)
                    .padding(.top,-20)
            }
        }
        .ignoresSafeArea()
        .navigationDestination(isPresented: $navigateToLogin) {
            LoginView(store: loginStore)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 6.4) {
                navigateToLogin = true
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        // hide navigation button
    }
}

#Preview {
    SplashScreen()
}
