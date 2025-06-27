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
            Tile(title: "Practitioner", icon: "practioner", countItem: "10"),
            Tile(title: "Appointment", icon: "appoinment", countItem: "10"),
            Tile(title: "Condition", icon: "conditions", countItem: "10"),
            Tile(title: "Lab", icon: "Labs", countItem: "10"),
            Tile(title: "Vital", icon: "vitals", countItem: "10"),
            Tile(title: "Medication", icon: "Savings", countItem: "10"),
            Tile(title: "Visits", icon: "Visits", countItem: "10"),
            Tile(title: "Procedure", icon: "Procedures", countItem: "10"),
            Tile(title: "Allergy", icon: "Allergy", countItem: "10"),
            Tile(title: "Immunizations", icon: "Immunization", countItem: "10"),
            Tile(title: "Billing", icon: "Billing", countItem: "10"),
            Tile(title: "Upload Documents", icon: "Upload", countItem: "10")
        ]
        var selectedIndex: Int = 0
        var selectedPractitioner: PractitionerData? = nil
        var selelctedAllergy: AllergyDummyData? = nil
        var selectedLab: LabDummyData? = nil
        var header: HeaderFeature.State = .init()
        var selelctedApooitment: AppointmentData? = nil
        var selctedProcedure: ProcedureDummyData? = nil
        var selctedVital: VitalDummyData? = nil
        
    }

    enum Action: Equatable {
        case backButtonTapped
        case selectTile(Int)
        case practitionerTapped(PractitionerData)
        case dismissPractitionerDetail
        case allergyTapped(AllergyDummyData)
        case dismissAllergyDetail
        case header(HeaderFeature.Action)
        case openLabDetail(LabDummyData)
        case closeLabDetail
        
        case openApoitmentDetial(AppointmentData)
        case closeApoitmentDetial
        
        case openProcedureDetail(ProcedureDummyData)
        case closeProcedureDEtail
        
        case openVitalDetail(VitalDummyData)
        case closeVitalDEtail


        
    }

    var body: some ReducerOf<Self> {
        
        Scope(state: \.header, action: /Action.header) {
               HeaderFeature()
           }

        Reduce { state, action in
            switch action {
                
            case .backButtonTapped:
                return .none
                
            case .selectTile(let index):
                state.selectedIndex = index
                let selectedTitle = state.tiles[index].title
                state.header.title = "List of \(selectedTitle)"

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
                
            case .openLabDetail(let lab):
                state.selectedLab = lab
                return .none
                
            case .closeLabDetail:
                state.selectedLab = nil
                return .none
                
            case .openApoitmentDetial(let appoitment):
                state.selelctedApooitment = appoitment
                return .none
                
            case .closeApoitmentDetial:
                state.selelctedApooitment = nil
                return .none
                
                
            case .openProcedureDetail(let data):
                state.selctedProcedure = data
                return .none
                
            case .closeProcedureDEtail:
                state.selctedProcedure = nil
                return .none
                
                
            case .openVitalDetail(let data):
                state.selctedVital = data
                return .none

                
            case .closeVitalDEtail:
                state.selctedVital = nil
                return .none


            case .header:
                return .none



            }
        }
    }
}
