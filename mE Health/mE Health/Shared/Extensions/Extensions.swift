//
//  Extensions.swift
//  mE Health
//
//  Created by Rashida on 7/05/25.
//

import SwiftUI
extension Color {
    /// Create from hex string like "FF5500" or "#FF5500"
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: .alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255,
                            (int >> 8) * 17,
                            (int >> 4 & 0xF) * 17,
                            (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255,
                            int >> 16,
                            int >> 8 & 0xFF,
                            int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24,
                            int >> 16 & 0xFF,
                            int >> 8 & 0xFF,
                            int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )

    }
}

struct Validator {
    static func validateEmail(_ input: String) -> String? {
        if input.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return "Required"
        } else if !NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: input) {
            return "Please enter a valid email address"
        }
        return nil
    }

    static func validatePassword(_ input: String) -> String? {
        if input.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return "Required"
        } else if input.count < 8 {
            return "Password must be at least 8 characters"
        }
        return nil
    }
}

