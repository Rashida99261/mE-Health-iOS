//
//  HeaderFeature.swift
//  mE Health
//
//  Created by Rashida on 20/06/25.
//

import ComposableArchitecture
import Foundation


enum HeaderActionIcon: CaseIterable, Identifiable {
    case search, date, upload, filter

    var id: Self { self }

    var iconName: String {
        switch self {
        case .search: return "magnifyingglass"
        case .date: return "calendar"
        case .upload: return "square.and.arrow.up"
        case .filter: return "line.3.horizontal.decrease.circle"
        }
    }
}

enum FilterType: String, CaseIterable, Identifiable, Equatable {
    case all = "All"
    case today = "Today"
    case book = "Book"
    case cancelled = "Cancelled"

    var id: String { self.rawValue }
}



struct HeaderFeature: Reducer {
    struct State: Equatable {
        var title: String = "List of Practitioners"
        var isSearchVisible = false
        var searchText: String = ""
        var isDatePickerPresented = false
        var isUploadPresented = false
        var isFilterPresented = false
        var selectedFilters: [FilterType] = []
    }
    

    enum Action: Equatable {
        case iconTapped(HeaderIcon)
        case dismissSheet
        case searchTextChanged(String)
        case hideSearch

        case toggleFilter(FilterType)
        case applyFilters
        case clearFilters
        case removeFilter(FilterType)
        
        case removeDate

    }

    enum HeaderIcon: CaseIterable, Identifiable, Equatable {
        case date,search, upload, filter

        var id: Self { self }

        var iconName: String {
            switch self {
            case .date: return "datepicker"
            case .search: return "Search"
            case .upload: return "file_upload"
            case .filter: return "filter"
            }
        }
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .iconTapped(let icon):
                switch icon {
                case .search:
                    state.isSearchVisible.toggle()
                case .date: state.isDatePickerPresented = true
                case .upload: state.isUploadPresented = true
                case .filter: state.isFilterPresented = true
                }
                return .none

            case .dismissSheet:
                state.isUploadPresented = false
                state.isFilterPresented = false
                return .none
                
            case .searchTextChanged(let text):
                state.searchText = text
                return .none

            case .hideSearch:
                state.isSearchVisible = false
                state.searchText = ""
                return .none
                
            case .removeDate:
                state.isDatePickerPresented = false
                return .none
                
                
            case .toggleFilter(let filter):
                if state.selectedFilters.contains(filter) {
                    state.selectedFilters.removeAll(where: { $0 == filter })
                } else {
                    state.selectedFilters.append(filter)
                }
                return .none

            case .applyFilters:
                state.isFilterPresented = false
                return .none

            case .clearFilters:
                state.selectedFilters.removeAll()
                return .none
                
            case .removeFilter(let filter):
                if state.selectedFilters.contains(filter) {
                    state.selectedFilters.removeAll(where: { $0 == filter })
                }
                return .none
            }
        }
    }
}

