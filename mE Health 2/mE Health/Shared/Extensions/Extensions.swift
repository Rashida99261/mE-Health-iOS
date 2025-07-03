import SwiftUI
extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")  // Skip `#` if present

        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)

        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >> 8) & 0xFF) / 255.0
        let b = Double(rgb & 0xFF) / 255.0

        self.init(red: r, green: g, blue: b)
    }
}

extension Color {
    static var backGroundColorN: Color { Color(UIColor(red: 0.96, green: 0.96, blue: 0.99, alpha: 1.00)) }
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

