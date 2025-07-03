//
//  Constants.swift
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
//# ============================================================================= on 2/06/25.
//

// Resources/Constants.swift

import Foundation

enum Constants {
    enum API {
       
        static let appBaseUrl = "https://dev-admin.meinstein.ai"
        static let clientID = "8f61aa69-40a1-45f7-8de0-055fad83cdad"
        static let redirectURI = "smartFhirAuthApp://callback"
        static let tokenEndpoint = "https://fhir.epic.com/interconnect-fhir-oauth/oauth2/token"
        static let aud = "https://fhir.epic.com/interconnect-fhir-oauth/api/FHIR/R4"
        static let callbackScheme = "smartFhirAuthApp"
        static let isLoggedIn = "isLoggedIn"
        static let FHIRbaseURL: String = "https://fhir.epic.com/interconnect-fhir-oauth/api/FHIR/R4"
        static let PrimaryColorHex = "FF6605"
        static let loginApi = appBaseUrl + "/user/login/"
        static let getProfileApi = appBaseUrl + "/user/get-profile/"
    }

    enum Strings {
        static let errorMessage = "Something went wrong."
        static let appTitle = "mE Health"
    }

}
