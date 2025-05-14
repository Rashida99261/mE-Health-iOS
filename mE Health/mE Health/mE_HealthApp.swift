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
    
    @Dependency(\.authService) var authService
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                SplashScreen()
            }
            .onOpenURL { url in
                            print("Incoming URL: \(url)")
                            _ = authService.resume(url)
            }
        }
    }
}
