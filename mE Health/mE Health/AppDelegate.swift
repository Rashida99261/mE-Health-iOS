//
//  AppDelegate.swift
//  mE Health
//
//  Created by Rashida on 28/05/25.
//

import UIKit
import CoreData


class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        return true
    }

    // Save support
    func applicationWillTerminate(_ application: UIApplication) {
        try? PersistenceController.shared.context.save()
    }
}
