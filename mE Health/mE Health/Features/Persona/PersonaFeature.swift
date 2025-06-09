//
//  PersonaFeature.swift
//  mE Health
//
//  Created by Rashida on 8/06/25.
//

import ComposableArchitecture
import SwiftUI

struct PersonaFeature: Reducer {
    struct State: Equatable {
        var selectedItem: PersonaItem? = nil
        var items: [PersonaItem] = PersonaItem.sampleItems
        var navigateBackToHome: Bool = false
    }

    enum Action: Equatable {
        case itemTapped(PersonaItem)
        case navigateBackToHomeTapped
        
    }

    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case let .itemTapped(item):
            state.selectedItem = item
            return .none
            
        case .navigateBackToHomeTapped:
            return .none
        }
    }
}

struct PersonaItem: Equatable, Identifiable {
    let id = UUID()
    let iconName: String
    let title: String

    static let sampleItems: [PersonaItem] = [
        .init(iconName: "PersonalCare", title: "Persona"),
//        .init(iconName: "familycare", title: "Family"),
//        .init(iconName: "SocialAccount", title: "My Network"),
//        .init(iconName: "Finance", title: "Financial Profile"),
        .init(iconName: "Health", title: "My Health"),
//        .init(iconName: "carProfile", title: "Car profile"),
//        .init(iconName: "home_p", title: "Home Profile"),
//        .init(iconName: "Vacations", title: "Vacation Profile"),
//        .init(iconName: "dailyroutine", title: "Daily Routine")
    ]
}
