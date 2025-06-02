//
//  mE_HealthApp.swift
//  mE Health
//
//  # =============================================================================
//# mEinstein - CONFIDENTIAL
//#
//# Copyright ©️ 2025 mEinstein Inc. All Rights Reserved.
//#
//# NOTICE: All information contained herein is and remains the property of
//# mEinstein Inc. The intellectual and technical concepts contained herein are
//# proprietary to mEinstein Inc. and may be covered by U.S. and foreign patents,
//# patents in process, and are protected by trade secret or copyright law.
//#
//# Dissemination of this information, or reproduction of this material,
//# is strictly forbidden unless prior written permission is obtained from
//# mEinstein Inc.
//#
//# Author(s): Ishant 
//# ============================================================================= on 6/05/25.
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

