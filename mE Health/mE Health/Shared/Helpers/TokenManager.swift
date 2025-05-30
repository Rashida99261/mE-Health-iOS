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
    private static let refreshService = "com.yourapp.fhir.refresh"
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

    // MARK: - Refresh Token

    static func saveRefreshToken(_ token: String) -> Bool {
        saveToKeychain(service: refreshService, account: refreshAccount, value: token)
    }

    static func fetchRefreshToken() -> String? {
        fetchFromKeychain(service: refreshService, account: refreshAccount)
    }

    static func deleteRefreshToken() {
        deleteFromKeychain(service: refreshService, account: refreshAccount)
    }
    
    // MARK: - Expiry Time (Unix timestamp in seconds)

       static func saveExpiryTimestamp(_ timestamp: TimeInterval) -> Bool {
           let stringValue = String(timestamp)
           return saveToKeychain(service: expiryService, account: expiryAccount, value: stringValue)
       }

       static func fetchExpiryTimestamp() -> TimeInterval? {
           guard let value = fetchFromKeychain(service: expiryService, account: expiryAccount),
                 let timestamp = TimeInterval(value) else { return nil }
           return timestamp
       }

       static func deleteExpiryTimestamp() {
           deleteFromKeychain(service: expiryService, account: expiryAccount)
       }

       // MARK: - Check Token Expiry

       static func isAccessTokenValid() -> Bool {
           guard let expiry = fetchExpiryTimestamp() else { return false }
           return Date().timeIntervalSince1970 < expiry - 60 // 1 min buffer
       }

       /// Get valid access token (returns nil if expired)
       static func getValidAccessToken() -> String? {
           guard isAccessTokenValid(), let token = fetchAccessToken() else {
               return nil
           }
           return token
       }


    
    


    // MARK: - Simulated Token Refresh

    static func tryRefreshToken(completion: @escaping (Bool) -> Void) {
        
        guard let refreshToken = fetchRefreshToken() else {
            completion(false)
            return
        }
        Task {
            let success = await refreshFhirToken(
                refreshToken: refreshToken,
                clientId: "48d8181f-c51b-4f8b-82ee-5cf3f82a81b8",
                tokenEndpoint: URL(string: "https://fhir.epic.com/interconnect-fhir-oauth/oauth2/token")!
            )
            completion(success)
        }
    }
    
    /// Refresh the FHIR access token using the refresh token
    private static func refreshFhirToken(
        refreshToken: String,
        clientId: String,
        tokenEndpoint: URL
    ) async -> Bool {
        var request = URLRequest(url: tokenEndpoint)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        let body = [
            "grant_type=refresh_token",
            "refresh_token=\(refreshToken)",
            "client_id=\(clientId)"
        ]
        request.httpBody = body.joined(separator: "&").data(using: .utf8)

        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                print("❌ Token refresh failed: \(String(data: data, encoding: .utf8) ?? "")")
                return false
            }

            let tokenResponse = try JSONDecoder().decode(FHIRTokenResponse.self, from: data)
            saveAccessToken(tokenResponse.access_token)

            if let newRefresh = tokenResponse.refresh_token {
                saveRefreshToken(newRefresh)
            }

            let newExpiryDate = Date().addingTimeInterval(TimeInterval(tokenResponse.expires_in))
            let success = saveAccessToken(tokenResponse.access_token)
                && saveExpiryTimestamp(newExpiryDate.timeIntervalSince1970)


            print("✅ Access token refreshed successfully")
            return success

        } catch {
            print("❌ Error during token refresh:", error.localizedDescription)
            return false
        }
    }

    static func callProtectedAPI(apiURL: URL) async {
        guard let accessToken = await getValidAccessToken() else {
            print("❌ No valid access token available.")
            return
        }

        var request = URLRequest(url: apiURL)
        request.httpMethod = "GET"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")

        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                print("❌ API call failed with status code: \((response as? HTTPURLResponse)?.statusCode ?? -1)")
                return
            }

            print("✅ API response:", String(data: data, encoding: .utf8) ?? "Empty")
        } catch {
            print("❌ Error calling protected API:", error.localizedDescription)
        }
    }



    // MARK: - Full Logout

    static func clearAll() {
        deleteAccessToken()
        deleteRefreshToken()
        deleteExpiryTimestamp()
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
