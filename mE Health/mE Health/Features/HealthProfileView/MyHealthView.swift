//
//  MyHealthView.swift
//  mE Health
//
//  Created by Ishant on 16/06/25.
//

import SwiftUI
import ComposableArchitecture

struct MyHealthView: View {
    let store: StoreOf<MyHealthFeature>
    @Environment(\.presentationMode) var presentationMode
    @State private var showAppoitmentOverlay = false
    
    @StateObject private var viewModel = ReadDatapractitioner()
    @StateObject private var appoitmentVM = ReadDataappointment()
    @StateObject private var procedureVM = ReadDataprocedure()
    @StateObject private var allergyVM = ReadDataallergyIntolerances()
    @StateObject private var immuneVM = ReadDataimmunization()
    @StateObject private var vitalVM = ReadDataobservation()
    @StateObject private var imagingVM = ReadDatimaging_study()
    @StateObject private var conditionVM = ReadDatcondition()
    @StateObject private var labVM = ReadDatdiagnostic_report()
    @StateObject private var billingVM = ReadDatclaim()
    
    @State private var isClinicListActive = false

    

    let visitData : [VisitDummyData] = [
        VisitDummyData(name: "Allergy follow-up, prescribed cetirizine", recordDate: "Date: 01/07/2021", status: .finish),
        VisitDummyData(name: "Pneumonia evaluation, ordered chest X-ray, prescribed amoxicilli", recordDate: "Date: 01/09/2021", status: .finish),
        VisitDummyData(name: "Chest X-ray for pneumonia evaluation", recordDate: "Date: 01/09/2021", status: .finish),
        VisitDummyData(name: "Cardiology follow-up, adjusted lisinopril, ordered lipid panel", recordDate: "Date: 01/10/2021", status: .finish),
       VisitDummyData(name: "Abdominal discomfort evaluation, ordered ultrasound", recordDate: "Date: 01/11/2021", status: .finish),
        VisitDummyData(name: "Abdominal ultrasound, diagnosed gallstones", recordDate: "Date: 15/11/2021", status: .finish),
        VisitDummyData(name: "Orthopedic consult for knee pain, ordered MRI", recordDate: "Date: 10/10/2021", status: .finish),
        VisitDummyData(name: "Knee MRI, confirmed meniscal tear", recordDate: "Date: 20/10/2021", status: .finish),
        
        VisitDummyData(name: "Abdominal discomfort evaluation, ordered ultrasound", recordDate: "Date: 01/11/2021", status: .finish),
         VisitDummyData(name: "Abdominal ultrasound, diagnosed gallstones", recordDate: "Date: 15/11/2021", status: .finish),
         VisitDummyData(name: "Orthopedic consult for knee pain, ordered MRI", recordDate: "Date: 10/10/2021", status: .finish),
         VisitDummyData(name: "Knee MRI, confirmed meniscal tear", recordDate: "Date: 20/10/2021", status: .finish),
        VisitDummyData(name: "Arthroscopic meniscectomy for right knee meniscal tear", recordDate: "Date: 15/02/2023", status: .finish),
         VisitDummyData(name: "Post-surgical follow-up, prescribed physical therapy", recordDate: "Date: 15/03/2023", status: .finish),
         VisitDummyData(name: "Revision arthroscopic meniscectomy for incomplete healing", recordDate: "Date: 15/11/2023", status: .finish),
         VisitDummyData(name: "Follow-up knee MRI, identified scar tissue", recordDate: "Date: 15/10/2024", status: .finish),
        VisitDummyData(name: "Arthroscopic debridement for scar tissue removal", recordDate: "Date: 15/11/2024", status: .finish),
         VisitDummyData(name: "Post-surgical follow-up, prescribed physical therapy", recordDate: "Date: 15/03/2025", status: .finish),
         VisitDummyData(name: "Vaccination visit, administered COVID-19 2nd dose", recordDate: "Date: 05/08/2022", status: .finish),
         VisitDummyData(name: "Annual well visit, diagnosed hypertension, hyperlipidemia, ordered labs", recordDate: "Date: 15/06/2021", status: .finish),
        VisitDummyData(name: "Annual well visit, reviewed conditions, ordered labs", recordDate: "Date: 15/06/2022", status: .finish),
        VisitDummyData(name: "Annual well visit, reviewed conditions, ordered labs", recordDate: "Date: 15/06/2023", status: .finish),
        VisitDummyData(name: "Annual well visit, reviewed conditions, ordered labs", recordDate: "Date: 15/06/2024", status: .finish),
        VisitDummyData(name: "Annual well visit, review conditions, order labs", recordDate: "Date: 15/06/2025", status: .finish)
        
    ]
    


    let medicationData : [MedicationDummyData] = [
        MedicationDummyData(name: "Cetirizine 10 mg", recordDate: "Authored: 01/07/2021", status: .active),
        MedicationDummyData(name: "Lisinopril 10 mg", recordDate: "Authored: 15/06/2021", status: .active)
    ]

    let filedata : [FilesDummyData] = [
        FilesDummyData(name: "Blood Test-01.pdf", specialty: "Appointment", date: "3 June 2025"),
        FilesDummyData(name: "Report4.mp4", specialty: "Labs", date: "3 days ago"),
        FilesDummyData(name: "Blood Test-01.pdf", specialty: "Appointment", date: "3 June 2025")
    ]
    
    @State private var selectedTab: DashboardTab = .menu
    @State private var showMenu: Bool = false
    @State private var selectedMenuTab: SideMenuTab = .persona
    @State private var navigateToSettings = false
    @State private var navigateToDashboard = false
    @State private var navigateToPersona = false
    

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            
            MainLayout(
                selectedTab: $selectedTab,
                showMenu: $showMenu,
                selectedMenuTab: selectedMenuTab,
                onMenuItemTap: { tab in
                    selectedMenuTab = tab
                    showMenu = false
                    // Optional: route or update state
                    if tab == .dashboard {
                        navigateToDashboard = true
                    }
                    else if tab == .settings {
                        navigateToSettings = true
                    }
                    else if tab == .persona {
                        navigateToPersona = true
                    }
                }
            )
            {
            
            VStack(alignment: .leading, spacing: 12) {
                Text("My Health")
                    .font(.custom("Montserrat-Bold", size: 32))
                    .padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(viewStore.tiles.indices, id: \.self) { index in
                            let tile = viewStore.tiles[index]
                            MyHealthTileView(
                                icon: tile.icon,
                                title: tile.title,
                                countItem : getCount(for: tile.title),
                                isSelected: viewStore.selectedIndex == index
                            )
                            .onTapGesture {
                                viewStore.send(.selectTile(index), animation: .easeInOut(duration: 0.3))
                            }
                        }
                    }
                    .frame(height:180)
                    .padding(.horizontal)
                }
                
                HeaderView(
                    store: store.scope(state: \.header, action: MyHealthFeature.Action.header)
                )
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        
                        let selectedTileTitle = viewStore.tiles[viewStore.selectedIndex].title
                        switch selectedTileTitle {
                        case "Practitioners":
                            PractitionerSectionView(
                                practitioners: viewModel.practitioners,
                                onCardTap: { practitioner in
                                    viewStore.send(.practitionerTapped(practitioner))
                                }
                            )
                            
                        case "Appointments":
                            AppoitmentSectionView(
                                appoitmentarray: appoitmentVM.appoitments,
                                onCardTap:{ appoitmnet in
                                    viewStore.send(.openApoitmentDetial(appoitmnet))
                                },
                                onReadMoreTap: { appoitmnet in
                                    showAppoitmentOverlay = true
                                }
                            )
                            
                        case "Conditions":
                            ConditionSectionView(conditions: conditionVM.conditionArray, onCardTap: { condition in
                                viewStore.send(.openConditionDetail(condition))
                            })
                            
                        case "Labs":
                            LabSectionView(labs: labVM.labs, startDate: "06-01-2025", endDate: "06-01-2025", onCardTap: { lab in
                                viewStore.send(.openLabDetail(lab))
                            })
                            
                        case "Vitals":
                            VitalsSectionView(vitals: vitalVM.vitalArray) { vital in
                                viewStore.send(.openVitalDetail(vital))
                            }
                            
                        case "Medications":
                            MedicationSectionView(medications: medicationData) { medication in
                                viewStore.send(.openMedDetail(medication))
                            }
                            
                        case "Visits":
                            VisitsSectionView(visit: visitData, onCardTap: { visit in
                                viewStore.send(.openVisitsDetail(visit))
                                
                            })
                            
                        case "Procedures":
                            ProcedureSectionView(procedure: procedureVM.procedures, onCardTap: { data in
                                viewStore.send(.openProcedureDetail(data))
                            })
                            
                        case "Allergies":
                            AllergySectionView(allergies: allergyVM.allergy, startDate: "06-01-2025", endDate: "06-01-2025", onCardTap: { allergy in
                                viewStore.send(.allergyTapped(allergy))
                            })
                            
                        case "Immunizations":
                            ImmuneSectionView(immune: immuneVM.immune, startDate: "06-01-2025", endDate: "06-01-2025", onCardTap: { immune in
                                
                                viewStore.send(.openImmuneDetail(immune))
                                
                            })
                            
                            
                        case "Billing":
                            BillingSectionView(items: billingVM.claim, onCardTap:{ billing in
                                viewStore.send(.openBillingDetail(billing))
                            })
                            
                        case "Records Vault":
                            FilesSectionView(filesArray: filedata) { files in
                                
                            }
                            
                        case "Imaging":
                            ImagingSectionView(arrayImaging: imagingVM.imagingarray, onCardTap: { data in
                                viewStore.send(.openImagingDetail(data))
                            })
                            
                            
                        default:
                            EmptyView()
                        }
                        
                    }
                    .padding([.top,.bottom], 16)
                }
                .padding(.top, 8)
                .padding(.bottom, 40)
                
                navigationLinks()
            }
            .padding(.top, 8)
            .navigationDestination(
                isPresented: viewStore.binding(
                    get: { $0.selectedPractitioner != nil },
                    send: .dismissPractitionerDetail
                )
            ) {
                if let selected = viewStore.selectedPractitioner {
                    PractitionerDetailView(practitioner: selected)
                }
            }
            
            .navigationDestination(
                isPresented: viewStore.binding(
                    get: { $0.selelctedApooitment != nil },
                    send: .closeApoitmentDetial
                )
            ) {
                if let selected = viewStore.selelctedApooitment {
                    AppoitmentDetailView(appoitment: selected)
                }
            }
            
            .navigationDestination(
                isPresented: viewStore.binding(
                    get: { $0.selectCondition != nil },
                    send: .closeConditionDetail
                )
            ) {
                if let selected = viewStore.selectCondition {
                    ConditionDetailView(condition: selected)
                }
            }
            
            
            .navigationDestination(
                isPresented: viewStore.binding(
                    get: { $0.selectVisit != nil },
                    send: .closeVisitDetail
                )
            ) {
                if let selected = viewStore.selectVisit {
                    VisitsDetailView(visit: selected)
                }
            }
            
            .navigationDestination(
                isPresented: viewStore.binding(
                    get: { $0.selctedProcedure != nil },
                    send: .closeProcedureDEtail
                )
            ) {
                if let selected = viewStore.selctedProcedure {
                    ProcedureDetailView(data: selected)
                }
            }
            
            .navigationDestination(
                isPresented: viewStore.binding(
                    get: { $0.selectImaging != nil },
                    send: .closeImagingDetail
                )
            ) {
                if let selected = viewStore.selectImaging {
                    ImagingDetailView(imaging: selected)
                }
            }
            
            .navigationDestination(
                isPresented: viewStore.binding(
                    get: { $0.selctedVital != nil },
                    send: .closeVitalDEtail
                )
            ) {
                if let selected = viewStore.selctedVital {
                    VitalDetailView(vital: selected)
                }
            }
            
            .navigationDestination(
                isPresented: viewStore.binding(
                    get: { $0.selectBilling != nil },
                    send: .closeBillingDetail
                )
            ) {
                if let selected = viewStore.selectBilling {
                    BillingDetailView(billing: selected)
                }
            }
            
            .navigationDestination(
                isPresented: viewStore.binding(
                    get: { $0.selectMed != nil },
                    send: .closeMedDetail
                )
            ) {
                if let selected = viewStore.selectMed {
                    MedicationDetailView()
                }
            }
            
            .navigationDestination(
                isPresented: viewStore.binding(
                    get: { $0.selectImune != nil },
                    send: .closeImmuneDetail
                )
            ) {
                if let selected = viewStore.selectImune {
                    ImmunizationDetailView(immune: selected)
                }
            }
            
            .navigationDestination(
                isPresented: viewStore.binding(
                    get: { $0.selelctedAllergy != nil },
                    send: .dismissAllergyDetail
                )
            ) {
                if let selected = viewStore.selelctedAllergy {
                    AllergyDetailView(allergy: selected)
                }
            }
            
            .navigationDestination(
                isPresented: viewStore.binding(
                    get: { $0.selectedLab != nil },
                    send: .closeLabDetail
                )
            ) {
                if let selected = viewStore.selectedLab {
                    LabDetailView(lab: selected)
                }
            }
            
            
            .background(Color(UIColor.systemGray6))
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    CustomBackButton {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                       
                       
                    }) {
                        Image(systemName: "gearshape.fill")
                            .foregroundColor(Color(hex: "FF6605"))
                    }
                }
            }
            .sheet(
                isPresented: viewStore.binding(
                    get: \.header.isFilterPresented,
                    send: MyHealthFeature.Action.header(.dismissSheet)
                )
            ) {
                FilterPopupView(
                    store: store.scope(state: \.header, action: MyHealthFeature.Action.header)
                )
                .presentationDragIndicator(.visible)
            }
        }
            .overlay(
                Group {
                    if showAppoitmentOverlay {
                        Color.black.opacity(0.4)
                            .edgesIgnoringSafeArea(.all)
                            .onTapGesture {
                                showAppoitmentOverlay = false
                            }
                            .overlay(
                                ZStack {
                                    // Dimmed Background
                                    Color.black.opacity(0.4)
                                        .ignoresSafeArea()
                                        .transition(.opacity)

                                    // Centered Modal with padding
                                    VStack(spacing: 16) {
                                        Text("""
                                        Based on the data provided, here is some advice on savings ratio for your finance profile:

                                        1. Understand Your Financial Goals:
                                        Start by identifying your short-term and long-term financial goals. Whether it's saving for a vacation, emergency fund, retirement, or any other goal, having clarity on what you are saving for will help determine your savings ratio.

                                        2. *Assess Your Current Financial Situation:* Review your income, expenses, assets, liabilities, and spending habits. Understanding your cash flow will give you a clear...
                                        """)
                                        .font(.custom("Montserrat-Semibold", size: 14))
                                        .foregroundColor(.black)
                                        .multilineTextAlignment(.center)
                                        .padding(.horizontal)
                                        .padding(.top, 24)

                                        Divider()

                                        Button(action: {
                                            withAnimation {
                                                showAppoitmentOverlay = false
                                            }
                                        }) {
                                            Text("OK")
                                                .font(.custom("Montserrat-Bold", size: 20))
                                                .foregroundColor(.blue)
                                                .frame(maxWidth: .infinity)
                                                .padding(.bottom, 12)
                                        }
                                    }
                                    .padding(.vertical, 16)
                                    .background(Color.white)
                                    .cornerRadius(20)
                                    .shadow(radius: 10)
                                    .padding(.horizontal, 24) // ✅ This is now applied directly to the card
                                    .transition(.scale)
                                }
                                .zIndex(10)
//                                    .frame(maxWidth: .infinity)
//                                    .padding()
                            )
                            .transition(.opacity)
                            .animation(.easeInOut(duration: 0.3), value: showAppoitmentOverlay)
                    }
                }
            )
        }
    }
    
    @ViewBuilder
    func navigationLinks() -> some View {
        
        // ✅ Add this
              NavigationLink(
                  destination: SettingView(),
                  isActive: $navigateToSettings
              ) {
                  EmptyView()
              }
        
        NavigationLink(
            destination: DashboardView(
                store: Store(
                    initialState: DashboardFeature.State(),
                    reducer: { DashboardFeature() }
                )
            ),
            isActive: $navigateToDashboard
        ) {
            EmptyView()
        }

        NavigationLink(
            destination: PersonaView(
                store: Store(
                    initialState: PersonaFeature.State(),
                    reducer: { PersonaFeature() }
                )
            ),
            isActive: $navigateToPersona
        ) {
            EmptyView()
        }

    }
    
    private var filterOverlay: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            Group {
                if viewStore.header.isFilterPresented {
                    FilterPopupView(
                        store: store.scope(state: \.header, action: MyHealthFeature.Action.header)
                    )
                } else {
                    EmptyView()
                }
            }
        }
    }
    
    func getCount(for title: String) -> String {
        switch title {
        case "Practitioners":
            return "\(viewModel.practitioners.count)"
        case "Appointments":
            return "\(appoitmentVM.appoitments.count)"
        case "Visits":
            return "\(visitData.count)" // Replace with actual count
        case "Conditions":
            return "\(conditionVM.conditionArray.count)"
        case "Labs":
            return "\(labVM.labs.count)"
        case "Vitals":
            return "\(vitalVM.vitalArray.count)"
        case "Medications":
            return "\(medicationData.count)" // Replace with actual count
        case "Imaging":
            return "\(imagingVM.imagingarray.count)"
        case "Procedures":
            return "\(procedureVM.procedures.count)"
        case "Allergies":
            return "\(allergyVM.allergy.count)"
        case "Immunizations":
            return "\(immuneVM.immune.count)"
        case "Billing":
            return "\(billingVM.claim.count)"
        case "Records Vault":
            return "\(filedata.count)"
        default:
            return "-"
        }
    }



}



struct MyHealthTileView: View {
    let icon: String
    let title: String
    let countItem : String
    let isSelected: Bool

    var body: some View {
        VStack(spacing: 12) {
            
            Text(title)
                .font(.custom("Montserrat-Bold", size: 9))
                .foregroundColor(.black)
            
            Image(icon)
                .resizable()
                .scaledToFit()
                .frame(width: 22, height: 22)
                .foregroundColor(Color(hex: "FF6605"))

            Text(countItem)
                .font(.custom("Montserrat-Bold", size: 9))
                .foregroundColor(.black)
            

            // Selection Indicator Line
            if isSelected {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color(hex: "FF6605"))
                    .frame(width:58)
                    .frame(height: 6)
                    .padding(.horizontal, 8)
            }
            else {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color(hex: "6E6B78"))
                    .frame(width:58)
                    .frame(height: 6)
                    .padding(.horizontal, 8)
            }

            
            
        }
        .frame(width: 102, height: isSelected ? 168 : 133)
        .background(Color.white)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(isSelected ? Color(hex: "FF6605") : Color.clear, lineWidth: 2)
        )
        .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
        .animation(.easeInOut(duration: 0.3), value: isSelected)
    }
}


#Preview {
    MyHealthView(
        store: Store(
            initialState: MyHealthFeature.State(),
            reducer: {
                MyHealthFeature()
            }
        )
    )
}

struct SearchView: View { var body: some View { Text("Search View") } }
struct DatePickerView: View { var body: some View { Text("Date Picker View") } }
struct UploadView: View { var body: some View { Text("Upload View") } }
