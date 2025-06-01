//
//  TokenManager.swift
//  mE Health
//
//  Created by Rashida on 22/05/25.
//

import Foundation
import Security

final class TokenManager {

    private static let accessService = "com.yourapp.fhir.access"
    private static let expiryService = "com.yourapp.fhir.expiry"

    private static let accessAccount = "accessToken"
    private static let refreshAccount = "refreshToken"
    private static let expiryAccount = "tokenExpiry"

    // MARK: - Access Token

    static func saveAccessToken(_ token: String) -> Bool {
        saveToKeychain(service: accessService, account: accessAccount, value: token)
    }

    static func fetchAccessToken() -> String? {
        fetchFromKeychain(service: accessService, account: accessAccount)
    }

    static func deleteAccessToken() {
        deleteFromKeychain(service: accessService, account: accessAccount)
    }
    

    // MARK: - Full Logout

    static func clearAll() {
        deleteAccessToken()
    }

    // MARK: - Private Helpers

    private static func saveToKeychain(service: String, account: String, value: String) -> Bool {
        guard let data = value.data(using: .utf8) else { return false }

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account
        ]
        SecItemDelete(query as CFDictionary)

        let attributes: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecValueData as String: data
        ]
        return SecItemAdd(attributes as CFDictionary, nil) == errSecSuccess
    }

    private static func fetchFromKeychain(service: String, account: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var item: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &item)

        guard status == errSecSuccess,
              let data = item as? Data,
              let result = String(data: data, encoding: .utf8)
        else {
            return nil
        }

        return result
    }

    private static func deleteFromKeychain(service: String, account: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account
        ]
        SecItemDelete(query as CFDictionary)
    }
}


// MARK: - Token Response Model

private struct FHIRTokenResponse: Decodable {
    let access_token: String
    let expires_in: Int
    let token_type: String
    let scope: String?
    let refresh_token: String?
}
