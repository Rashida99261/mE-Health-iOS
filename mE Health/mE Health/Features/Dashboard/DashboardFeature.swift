import ComposableArchitecture
import Foundation




struct DashboardFeature: Reducer {
    
    enum NavigationDestination: Equatable {
        case login
    }

    struct State: Equatable {
        var isLoading: Bool = false
        var showErrorAlert = false
        var errorMessage = ""
        var selectedTab: DashboardTab = .menu
        var selectedMenuTab : SideMenuTab = .dashboard
        var showMenu: Bool = false
        var personaState: PersonaFeature.State? = nil
        var navigationDestination: NavigationDestination? = nil
        var dashboardListState: DashboardListFeature.State? = nil
        var showDashboardList: Bool = false
    }

    enum Action: Equatable {
        case onAppear
        case logoutTapped
        case tabSelected(DashboardTab)
        case tabMenuItemSelected(SideMenuTab)
        case toggleMenu(Bool)
        case personaAction(PersonaFeature.Action)
        case navigationDestinationChanged(DashboardFeature.NavigationDestination?)
        case showDashboardList(Bool)
    }
    
    @Dependency(\.fhirClient) var fhirClient
    @Dependency(\.coreDataClient) var coreDataClient

    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
            
        case .onAppear:
            state.isLoading = true
            state.personaState = nil
            state.navigationDestination = nil
            return .none
            
        case .logoutTapped:
            return .none
            
        case .tabSelected(let tab):
            state.selectedTab = tab
//            if tab == .dashboard {
//                state.dashboardListState = DashboardListFeature.State()
//            }
            return .none
            
        case let .toggleMenu(isOpen):
            state.showMenu = isOpen
            return .none
            
        case .tabMenuItemSelected(let item):
            if item == .persona {
                state.personaState = PersonaFeature.State()
            }
            if item == .logout {
                SessionManager.shared.clearSession() // Make sure you have a method like this
                state.navigationDestination = .login
            }
            return .none
            
        case .personaAction(.navigateBackToHomeTapped):
            print("open")
            state.personaState = nil
            state.navigationDestination = nil
            return .none
            
        case .navigationDestinationChanged(let destination):
            state.navigationDestination = destination
            return .none

        case .personaAction(.itemTapped(_)):
            return .none
            
        case let .showDashboardList(show):
            state.showDashboardList = show
            return .none

        }
                
    }
    
    
    var body: some ReducerOf<Self> {
        Reduce(self.reduce)
            .ifLet(\.personaState, action: /Action.personaAction) {
                PersonaFeature()
            }

    }
    
   
}


