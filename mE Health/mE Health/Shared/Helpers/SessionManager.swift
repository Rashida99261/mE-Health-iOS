//
//  SessionManager.swift
//  mE Health
//
//  Created by Rashida on 29/05/25.
//

import SwiftUI

class SessionManager {
    static let shared = SessionManager()

    private let userDefaults = UserDefaults.standard

    var isLoggedIn: Bool {
        userDefaults.bool(forKey: "isLoggedIn")
    }

    func saveLoginSession() {
        userDefaults.set(true, forKey: "isLoggedIn")
    }

    func clearSession() {
        userDefaults.removeObject(forKey: "isLoggedIn")
    }
}
