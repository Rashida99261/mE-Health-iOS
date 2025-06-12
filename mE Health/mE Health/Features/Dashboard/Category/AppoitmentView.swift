import SwiftUI
import ComposableArchitecture

struct AppoitmentView: View {
    
    let store: StoreOf<AllergyFeature>
    
    var body: some View {
        
        WithViewStore(store, observe: { $0 }) { viewStore in
            NavigationView {
                ScrollView {
                    if viewStore.isLoading {
                        ProgressView("Loading AppoitmentView Data...")
                    } else {
                        
                        let resourceObj = viewStore.allergyModel?.entry?.first?.resource
                        let clinalStatus = resourceObj?.clinicalStatus?.text ?? "Unknown"  //
                        let allergyId = resourceObj?.id ?? ""
                        let RecordedDate = resourceObj?.recordedDate ?? ""
                        
                        VStack(alignment: .leading, spacing: 16) {
                            Text("AppoitmentView Data")
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding(.bottom, 8)
                            
                            conditionRow(title: "appointmentId:", value: allergyId, icon: "lungs.fill")
                            conditionRow(title: "startTime:", value: "", icon: "calendar.badge.clock")
                            conditionRow(title: "endTime:", value: "", icon: "waveform.path.ecg")
                            conditionRow(title: "status:", value: clinalStatus, icon: "calendar")
                            conditionRow(title: "description:", value: "", icon: "calendar")
                            conditionRow(title: "reasonCode:", value: "", icon: "calendar")

                            Spacer()
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color(.systemBackground))
                                .shadow(color: .gray.opacity(0.2), radius: 10, x: 0, y: 5)
                        )
                        .padding()
                    }
                }
                .navigationTitle("AppoitmentView")
            }
            .onAppear {
                viewStore.send(.loadAllergy)
            }

        }
    }

    @ViewBuilder
    private func conditionRow(title: String, value: String, icon: String) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 24, height: 24)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Text(value)
                    .font(.body)
                    .fontWeight(.medium)
            }
        }
        .padding(.vertical, 4)
    }
}



