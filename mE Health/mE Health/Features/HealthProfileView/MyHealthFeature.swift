//
//  MyHealthFeature.swift
//  mE Health
//
//  Created by Ishant on 16/06/25.
//

import ComposableArchitecture
import SwiftUI

struct Tile: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let icon: String
    let countItem: String
    
}


struct MyHealthFeature: Reducer {
    
    struct State: Equatable {
        
        var tiles: [Tile] = [
            Tile(title: "Practitioner", icon: "bus.fill", countItem: "10"),
            Tile(title: "Appointment", icon: "doc.text.fill", countItem: "10"),
            Tile(title: "Allergy", icon: "pills.fill", countItem: "10"),
            Tile(title: "Lab", icon: "doc.plaintext", countItem: "10"),
            Tile(title: "Immunizations", icon: "syringe.fill", countItem: "10")
        ]
        var selectedIndex: Int = 0
        var selectedPractitioner: PractitionerData? = nil
        var selelctedAllergy: AllergyDummyData? = nil
    }

    enum Action: Equatable {
        case selectTile(Int)
        case practitionerTapped(PractitionerData)
        case dismissPractitionerDetail
        case allergyTapped(AllergyDummyData)
        case dismissAllergyDetail


        
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .selectTile(let index):
                state.selectedIndex = index
                return .none
                
            case .practitionerTapped(let practitioner):
                state.selectedPractitioner = practitioner
                return .none

            case .dismissPractitionerDetail:
                state.selectedPractitioner = nil
                return .none

            case .allergyTapped(let allergy):
                state.selelctedAllergy = allergy
                return .none
                
            case .dismissAllergyDetail:
                state.selelctedAllergy = nil
                return .none


            }
        }
    }
}
