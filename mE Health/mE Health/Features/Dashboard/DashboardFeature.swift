import ComposableArchitecture
import Foundation




import ComposableArchitecture
import Foundation

enum PersonaDestination: Equatable {
    case patientProfile
    case myHealth
}


struct DashboardFeature: Reducer {
    
    enum NavigationDestination: Equatable {
        case login
    }


    struct State: Equatable {
        var isLoading: Bool = false
        var showErrorAlert = false
        var errorMessage = ""
        var selectedTab: DashboardTab = .menu
        var selectedMenuTab: SideMenuTab = .dashboard
        var showMenu: Bool = false
        
        var personaState: PersonaFeature.State? = nil
        var personaSelectedDestination: PersonaDestination? = nil
        
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
        case setPersonaSelectedDestination(PersonaDestination?)
        
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
            state.personaSelectedDestination = nil
            return .none

        case .logoutTapped:
            return .none

        case .tabSelected(let tab):
            state.selectedTab = tab
            return .none

        case let .toggleMenu(isOpen):
            state.showMenu = isOpen
            return .none

        case .tabMenuItemSelected(let item):
            switch item {
            case .persona:
                state.personaState = PersonaFeature.State()
            case .logout:
                SessionManager.shared.clearSession()
                state.navigationDestination = .login
            default:
                break
            }
            return .none

        case .personaAction(.navigateBackToHomeTapped):
            state.personaState = nil
            state.navigationDestination = nil
            return .none

        case .personaAction(.itemTapped(let destination)):
            // Forward selected destination to Dashboard
            state.personaSelectedDestination = destination
            return .none

        case .setPersonaSelectedDestination(let destination):
            state.personaSelectedDestination = destination
            return .none

        case .navigationDestinationChanged(let destination):
            state.navigationDestination = destination
            return .none

        case let .showDashboardList(show):
            state.showDashboardList = show
            return .none

        case .personaAction(.patientProfile), .personaAction(.dismissPatientProfile), .personaAction(.dismissNavigation):
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



