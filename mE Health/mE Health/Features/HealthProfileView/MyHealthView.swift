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
    
    var samplePractioner : [PractitionerData] = [
        PractitionerData(name: "Dr. Ashley David", specialty: "Gynecologist", phone: "(212) 555-1234", email: "info@totalcaremaintenance.com"),
        PractitionerData(name: "Dr. Ashley David", specialty: "Gynecologist", phone: "(212) 555-1234", email: "info@totalcaremaintenance.com")]
    
    var sampleAppoitmnt : [AppointmentData] = [
        AppointmentData(drName: "Dr. David Joe", hospitalName: "Hospital name", dateTime: "11 Jun 2025,03:30 PM - 4:00 PM", description: "Based on your recent activity and climate, here’s personalized guidance on your daily water intake to stay hydrated and healthy."),
        AppointmentData(drName: "Dr. David Joe", hospitalName: "Hospital name", dateTime: "11 Jun 2025,03:30 PM - 4:00 PM", description: "Based on your recent activity and climate, here’s personalized guidance on your daily water intake to stay hydrated and healthy."),
        AppointmentData(drName: "Dr. David Joe", hospitalName: "Hospital name", dateTime: "11 Jun 2025,03:30 PM - 4:00 PM", description: "Based on your recent activity and climate, here’s personalized guidance on your daily water intake to stay hydrated and healthy.")]
    
    var sampleAleData : [AllergyDummyData] = [
        AllergyDummyData(name: "Peanut Allergy", recordDate: "Recorded Date: 05/06/2025"),
        AllergyDummyData(name: "Dust Allergy", recordDate: "Recorded Date: 05/06/2025"),
        AllergyDummyData(name: "Penicillin Allergy", recordDate: "Recorded Date: 05/06/2025")
        ]
        
    var sampleLabData : [LabDummyData] = [
            LabDummyData(name: "Complete Blood Count", recordDate: "Recorded Date: 05/06/2025",isActive:true),
            LabDummyData(name: "Lipid Panel", recordDate: "Recorded Date: 12/06/2025",isActive:false),
            LabDummyData(name: "Lipid Panel", recordDate: "Recorded Date: 12/06/2025",isActive:true)
    ]
    
    var sampleImmubeData : [ImmuneDummyData] = [
        ImmuneDummyData(name: "COVID-19 Vaccine", recordDate: "Occurrence Date: N/A", location: "Location: N/A", isCompleted: false),
        ImmuneDummyData(name: "COVID-19 Vaccine", recordDate: "Occurrence Date: N/A", location: "Location: N/A", isCompleted: true),
        ImmuneDummyData(name: "COVID-19 Vaccine", recordDate: "Occurrence Date: N/A", location: "Location: N/A", isCompleted: true)
    ]
    
    let billingItems: [BillingItem] = [
        BillingItem(title: "Clinic Name", date: "19/05/2025", amount: "$8.40", status: .planned),
        BillingItem(title: "Hospital Bills", date: "19/05/2025", amount: "$15.99", status: .planned)
    ]
    
    let visitData : [VisitDummyData] = [
        VisitDummyData(name: "Annual Physical", recordDate: "Date: 05/06/2025", status: .planned),
        VisitDummyData(name: "Dental Checkup", recordDate: "Date: 05/06/2025", status: .cancel),
        VisitDummyData(name: "Follow-up Visit", recordDate: "Date: 05/06/2025", status: .schedule),
        VisitDummyData(name: "Laboratory Visit", recordDate: "Date: 05/06/2025", status: .finish)
    ]
    
    let procedureData : [ProcedureDummyData] = [
        ProcedureDummyData(name: "Appendectomy", recordDate: "03/15/2024", status: .completed),
        ProcedureDummyData(name: "Cardiac Catheterization", recordDate: "03/15/2024", status: .progress),
        ProcedureDummyData(name: "Colonoscopy", recordDate: "03/15/2024", status: .completed),
        ProcedureDummyData(name: "Hip Replacement", recordDate: "03/15/2024", status: .completed),
        ProcedureDummyData(name: "Cardiac Catheterization", recordDate: "03/15/2024", status: .progress)
    ]
    
    let conditionData : [ConditionDummyData] = [
        ConditionDummyData(name: "Blood Pressure", date: "June 12, 2024", status: .active),
        ConditionDummyData(name: "Hypertension", date: "June 12, 2024", status: .active),
        ConditionDummyData(name: "Seasonal Allergies", date: "June 12, 2024", status: .resolved)
    ]

    let vitalData : [VitalDummyData] = [
        VitalDummyData(name: "Blood Pressure", date: "06//11/2025", mg: "120/80 mmHg"),
        VitalDummyData(name: "Heart Rate", date: "06//11/2025", mg: "72 bmp")
    ]

    let medicationData : [MedicationDummyData] = [
        MedicationDummyData(name: "Lisinopril 10mg", recordDate: "Authored: 05/06/2025", status: .active),
        MedicationDummyData(name: "Lisinopril 10mg", recordDate: "Authored: 05/06/2025", status: .active)
    ]

    let filedata : [FilesDummyData] = [
        FilesDummyData(name: "Blood Test-01.pdf", specialty: "Appointment", date: "3 June 2025"),
        FilesDummyData(name: "Report4.mp4", specialty: "Labs", date: "3 days ago"),
        FilesDummyData(name: "Blood Test-01.pdf", specialty: "Appointment", date: "3 June 2025")
    ]


    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
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
                                countItem : tile.countItem,
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

                
                Divider()
                
                
                let selectedTileTitle = viewStore.tiles[viewStore.selectedIndex].title
                switch selectedTileTitle {
                case "Practitioner":
                    PractitionerSectionView(
                        practitioners: samplePractioner, // Replace with state-driven data
                        startDate: "06-01-2025",
                        endDate: "06-16-2025",
                        onCardTap: { practitioner in
                            viewStore.send(.practitionerTapped(practitioner))
                        }
                    )

                case "Appointment":
                    AppoitmentSectionView(
                        practitioners: sampleAppoitmnt,
                        onCardTap:{ appoitmnet in
                            viewStore.send(.openApoitmentDetial(appoitmnet))
                        },
                        onReadMoreTap: { appoitmnet in
                            showAppoitmentOverlay = true
                        }
                    )
                    
                case "Condition":
                    ConditionSectionView(conditions: conditionData, onCardTap: { appoitmnet in
                                        
                        })

                case "Lab":
                    LabSectionView(labs: sampleLabData, startDate: "06-01-2025", endDate: "06-01-2025", onCardTap: { lab in
                        viewStore.send(.openLabDetail(lab))
                    })
                    
                case "Vital":
                    VitalsSectionView(vitals: vitalData) { vital in
                        viewStore.send(.openVitalDetail(vital))
                    }
                    
                case "Medication":
                    MedicationSectionView(medications: medicationData) { medication in
                        
                    }
                    
                case "Visits":
                    VisitsSectionView(visit: visitData, onCardTap: { visit in
                    })
                    
                case "Procedure":
                    ProcedureSectionView(procedure: procedureData, onCardTap: { data in
                        viewStore.send(.openProcedureDetail(data))
                    })
                    
                case "Allergy":
                    AllergySectionView(allergies: sampleAleData, startDate: "06-01-2025", endDate: "06-01-2025", onCardTap: { allergy in
                        viewStore.send(.allergyTapped(allergy))
                    })

                case "Immunizations":
                    ImmuneSectionView(immune: sampleImmubeData, startDate: "06-01-2025", endDate: "06-01-2025", onCardTap: { lab in
                    })
                    
                    
                case "Billing":
                    BillingSectionView(items: billingItems, onCardTap:{ lab in
                    })
                    
               case "Upload Documents":
                    FilesSectionView(filesArray: filedata) { files in
                        
                    }
                    
                    
                default:
                    EmptyView()
                }

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
                    get: { $0.selctedVital != nil },
                    send: .closeVitalDEtail
                )
            ) {
                if let selected = viewStore.selctedVital {
                    VitalDetailView()
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
                    LabDetailView()
                }
            }

            .background(Color.white)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    CustomBackButton {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                         Button(action: {
                             // Handle settings
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
struct FilterView: View { var body: some View { Text("Filter View") } }
