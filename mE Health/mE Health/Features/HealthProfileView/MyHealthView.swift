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
        PractitionerData(name: "Dr. Emily Carter, MD", specialty: "Family Medicine", phone: "+1-978-683-4000", email: "carter@lawrencegeneral.org"),
        PractitionerData(name: "Dr. Rajesh Patel, MD", specialty: "Allergy and Immunology", phone: "+1-978-683-4000", email: "rajesh.patel@lawrencegeneral.org"),
        PractitionerData(name: "Dr. Susan Lee, MD, MD", specialty: "Pulmonary Medicine", phone: "+1-978-683-4000", email: "susan.lee@lawrencegeneral.org"),
        PractitionerData(name: "Dr. Michael Nguyen, MD", specialty: "Cardiology", phone: "+1-617-726-2000", email: "michael.nguyen@mgh.harvard.edu"),
        PractitionerData(name: "Dr. Laura Kim, MD", specialty: "Diagnostic Radiology", phone: "+1-978-683-4000", email: "laura.kim@lawrencegeneral.org"),
        
        PractitionerData(name: "Dr. James O’Connor, MD", specialty: "Orthopedic Surgery", phone: "+1-617-726-2000", email: "james.oconnor@mgh.harvard.edu"),
        PractitionerData(name: "Dr. Richard Allara, MD", specialty: "Family Medicine", phone: "+1-978-783-5000", email: "richard.allara@middletonfamily.org")]
    
    var sampleAppoitmnt : [AppointmentData] = [
        AppointmentData(drName: "Dr. David Joe", hospitalName: "Hospital name", dateTime: "11 Jun 2025,03:30 PM - 4:00 PM", description: "Based on your recent activity and climate, here’s personalized guidance on your daily water intake to stay hydrated and healthy.",status: .booked),
        AppointmentData(drName: "Dr. David Joe", hospitalName: "Hospital name", dateTime: "11 Jun 2025,03:30 PM - 4:00 PM", description: "Based on your recent activity and climate, here’s personalized guidance on your daily water intake to stay hydrated and healthy.",status: .completed),
        AppointmentData(drName: "Dr. David Joe", hospitalName: "Hospital name", dateTime: "11 Jun 2025,03:30 PM - 4:00 PM", description: "Based on your recent activity and climate, here’s personalized guidance on your daily water intake to stay hydrated and healthy.",status: .cancel)]
    
    var sampleAleData : [AllergyDummyData] = [
        AllergyDummyData(name: "Pollen allergy", recordDate: "Recorded Date: 2021-07-01"),

        ]
        
    var sampleLabData : [LabDummyData] = [
            LabDummyData(name: "Complete Blood Count", recordDate: "Recorded Date: 05/06/2025",isActive:true),
            LabDummyData(name: "Lipid Panel", recordDate: "Recorded Date: 12/06/2025",isActive:false),
            LabDummyData(name: "Lipid Panel", recordDate: "Recorded Date: 12/06/2025",isActive:true)
    ]
    
    var sampleImmubeData : [ImmuneDummyData] = [
        ImmuneDummyData(name: "Influenza vaccine", recordDate: "Occurrence Date: 01/07/2021", location: "Location: N/A", isCompleted: true),
        ImmuneDummyData(name: "COVID-19 vaccine, mRNA, Pfizer, 1st dose", recordDate: "Occurrence Date: 01/07/2021", location: "Location: N/A", isCompleted: true),
        ImmuneDummyData(name: "COVID-19 vaccine, mRNA, Pfizer, 2nd dose", recordDate: "Occurrence Date: 05/08/2022", location: "Location: N/A", isCompleted: true),
        
        ImmuneDummyData(name: "Tdap vaccine", recordDate: "Occurrence Date: 15/10/2022", location: "Location: N/A", isCompleted: true),
        ImmuneDummyData(name: "Shingles vaccine, recombinant, 1st dose", recordDate: "Occurrence Date: 15/06/2023", location: "Location: N/A", isCompleted: true),
        ImmuneDummyData(name: "Shingles vaccine, recombinant, 2nd dose", recordDate: "Occurrence Date: 10/09/2023", location: "Location: N/A", isCompleted: true),
        ImmuneDummyData(name: "Pneumococcal conjugate vaccine, PCV20", recordDate: "Occurrence Date: 15/06/2024", location: "Location: N/A", isCompleted: true)
    ]
    
    let billingItems: [BillingItem] = [
        BillingItem(title: "Blue Cross Blue Shield", date: "15/06/2021", amount: "$150", status: .planned),
        BillingItem(title: "Blue Cross Blue Shield", date: "01/07/2021", amount: "$100", status: .planned),
        
        BillingItem(title: "Blue Cross Blue Shield", date: "01/09/2021", amount: "$1000", status: .planned),
        BillingItem(title: "Blue Cross Blue Shield", date: "15/09/2021", amount: "$200", status: .planned),
        
        BillingItem(title: "Blue Cross Blue Shield", date: "15/02/2023", amount: "$3000", status: .planned),
        BillingItem(title: "Blue Cross Blue Shield", date: "15/06/2022", amount: "$150", status: .planned),
        BillingItem(title: "Blue Cross Blue Shield", date: "15/06/2023", amount: "$150", status: .planned),
        BillingItem(title: "Blue Cross Blue Shield", date: "15/06/2024", amount: "$150", status: .planned),
        
        BillingItem(title: "Blue Cross Blue Shield", date: "15/02/2023", amount: "$3000", status: .planned),
        BillingItem(title: "Blue Cross Blue Shield", date: "15/06/2022", amount: "$4000", status: .planned),
        BillingItem(title: "Blue Cross Blue Shield", date: "15/06/2023", amount: "$200", status: .planned),
        BillingItem(title: "Blue Cross Blue Shield", date: "15/06/2024", amount: "$5000", status: .planned)
    ]
    
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
    
    let procedureData : [ProcedureDummyData] = [
        ProcedureDummyData(name: "Arthroscopic meniscectomy", recordDate: "02/15/2023", status: .completed),
        ProcedureDummyData(name: "Revision arthroscopic meniscectomy", recordDate: "11/15/2023", status: .completed),
        ProcedureDummyData(name: "Arthroscopic debridement", recordDate: "11/15/2024", status: .completed),
       
    ]
    
    let conditionData : [ConditionDummyData] = [
        ConditionDummyData(name: "Seasonal allergic rhinitis", date: "July 1, 2021", status: .active),
        ConditionDummyData(name: "Pneumonia, unspecified", date: "Aug 1, 2021", status: .active),
        ConditionDummyData(name: "Essential hypertension", date: "June 12, 2024", status: .active)
    ]

    let vitalData : [VitalDummyData] = [
        VitalDummyData(name: "Blood pressure panel", date: "01/07/2021", mg: "90/140 mmHg"),
        VitalDummyData(name: "Heart Rate", date: "06/11/2025", mg: "72 bmp"),
        
        VitalDummyData(name: "Blood pressure panel", date: "15/06/2021", mg: "90/140 mmHg"),
        VitalDummyData(name: "Heart Rate", date: "15/06/2021", mg: "72 bmp")
    ]

    let medicationData : [MedicationDummyData] = [
        MedicationDummyData(name: "Lisinopril 10mg", recordDate: "Authored: 01/07/2021", status: .active),
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
                    ConditionSectionView(conditions: conditionData, onCardTap: { condition in
                        viewStore.send(.openConditionDetail(condition))
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
                        viewStore.send(.openMedDetail(medication))
                    }
                    
                case "Visits":
                    VisitsSectionView(visit: visitData, onCardTap: { visit in
                        viewStore.send(.openVisitsDetail(visit))
                        
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
                    ImmuneSectionView(immune: sampleImmubeData, startDate: "06-01-2025", endDate: "06-01-2025", onCardTap: { immune in
                       
                        viewStore.send(.openImmuneDetail(immune))
                        
                    })
                    
                    
                case "Billing":
                    BillingSectionView(items: billingItems, onCardTap:{ billing in
                        viewStore.send(.openBillingDetail(billing))
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
                    get: { $0.selectCondition != nil },
                    send: .closeConditionDetail
                )
            ) {
                if let selected = viewStore.selectCondition {
                    ConditionDetailView()
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
                    ImmunizationDetailView()
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
