//
//  PersonaFeature.swift
//  mE Health
//
//  Created by //# Author(s): Ishant  on 8/06/25.
//

import ComposableArchitecture
import SwiftUI


struct PersonaFeature: Reducer {
    struct State: Equatable {
        var selectedItem: PersonaItem? = nil
        var items: [PersonaItem] = PersonaItem.sampleItems
        var navigateBackToHome: Bool = false
        var patientProfile: PatientProfileFeature.State? = nil
        var selectedDestination: PersonaDestination?
    }

    enum Action: Equatable {
        case itemTapped(PersonaDestination)
        case dismissNavigation

        case navigateBackToHomeTapped
        case patientProfile(PatientProfileFeature.Action)
        case dismissPatientProfile
        
    }

    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .itemTapped(let destination):
            state.selectedDestination = destination
            return .none

        case .navigateBackToHomeTapped:
            return .none
            
        case .patientProfile:
            return .none
            
        case .dismissPatientProfile:
            state.patientProfile = nil
            return .none

        case .dismissNavigation:
            state.selectedDestination = nil
            return .send(.navigateBackToHomeTapped)

        }
    }
    
}

struct PersonaItem: Equatable, Identifiable {
    let id = UUID()
    let iconName: String
    let title: String
    let destination: PersonaDestination

    static let sampleItems: [PersonaItem] = [
        .init(iconName: "PersonalCare", title: "Persona", destination: .patientProfile),
//        .init(iconName: "familycare", title: "Family"),
//        .init(iconName: "SocialAccount", title: "My Network"),
//        .init(iconName: "Finance", title: "Financial Profile"),
        .init(iconName: "Health", title: "My Health", destination: .myHealth),
//        .init(iconName: "carProfile", title: "Car profile"),
//        .init(iconName: "home_p", title: "Home Profile"),
//        .init(iconName: "Vacations", title: "Vacation Profile"),
//        .init(iconName: "dailyroutine", title: "Daily Routine")
    ]
}
