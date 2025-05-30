//
//  mE_HealthApp.swift
//  mE Health
//
//  Created by Rashida on 6/05/25.
//

import SwiftUI
import ComposableArchitecture

@main
struct mE_HealthApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                SplashScreen(
                    store: Store(
                        initialState: AppFeature.State(),
                        reducer: {
                            AppFeature()
                        }
                    )
                )
            }

        }
    }
}

