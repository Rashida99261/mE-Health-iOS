//
//  PatientProfileFeature.swift
//  mE Health
//
//  Created by Ishant on 13/06/25.
//

import ComposableArchitecture
import Foundation

struct PatientProfileFeature: Reducer {
    
    struct State: Equatable {
        var name: String = "John Doe"
        var addressLine: String = "23 New Drum Street, London, England, E1 7AY"
        var completion: Double = 0.1

        var phone: String = "+91 98547XXXXX"
        var email: String = "john@example.com"
        var addresses: [String] = ["New York , USA"]
        var anniversary: String? = ""
        var isMarried: Bool = false
        var gender: String = "Female"
        var dob: String = "1996-01-01"
        
    }
    
    enum Action: Equatable {
        case toggleMarried(Bool)
    }

    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
            
        case let .toggleMarried(value):
            state.isMarried = value
            return .none

        }
    }
        
}
