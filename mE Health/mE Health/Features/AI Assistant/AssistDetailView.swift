//
//  AssistDetailView.swift
//  mE Health
//
//  Created by Rashida on 26/06/25.
//

import SwiftUI
import ComposableArchitecture

struct Condition: Identifiable {
    let id: UUID
    let name: String
    let code: String
    let date: Date
    let time: String
    let dateRange: String
}

// Insight.swift
import Foundation

struct Insight: Identifiable {
    let id: UUID
    let text: String
    let confidence: Double
    let source: String
    let createdAt: Date
}

struct AssistDetailView: View {
    @State private var startDate: Date? = nil
    @State private var endDate: Date? = nil
    @State private var isStartDatePickerPresented = false
    @State private var isEndDatePickerPresented = false
    @State private var isLoading = false
    @State private var showListView = false
    
    @State private var selectedDate = Date()
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = ChronicConditionDetectorViewModel()
    
    @StateObject private var allergyVM = ReadDataallergyIntolerances()
    
    let assisData : [AssistListData] = [
        
        AssistListData(dateRange: "2000-2020", category: "Chronic Conditions", time: "23-06-2025 12:19PM"),
        AssistListData(dateRange: "2000-2020", category: "Chronic Conditions", time: "23-06-2025 12:19PM"),
        AssistListData(dateRange: "2000-2020", category: "Chronic Conditions", time: "23-06-2025 12:19PM"),
        AssistListData(dateRange: "2000-2020", category: "Chronic Conditions", time: "23-06-2025 12:19PM"),
        AssistListData(dateRange: "2000-2020", category: "Chronic Conditions", time: "23-06-2025 12:19PM")
    ]


    var body: some View {
        VStack(alignment: .leading,spacing: 20) {
            // MARK: - Start Date Card
            
            Text(txtCondition)
                .font(.custom("Montserrat-SemiBold", size: 16))
                .padding(.horizontal)
                
            HStack(spacing:12) {
                
                Button(action: {
                    isStartDatePickerPresented = true
                }) {
                    DateCardView(title: "Start Date", date: formattedDate(startDate))
                }
                .sheet(isPresented: $isStartDatePickerPresented) {
                    DatePickerModalView(
                        title: "Start Date",
                        isPresented: $isStartDatePickerPresented,
                        selectedDate: Binding(
                            get: { startDate ?? Date() },
                            set: { startDate = $0 }
                        ),
                        minimumDate: nil
                    )
                 }

                // MARK: - End Date Card
                Button(action: {
                    if startDate != nil {
                        isEndDatePickerPresented = true
                    }
                }) {
                    DateCardView(title: "End Date", date: formattedDate(endDate))
                }
                .disabled(startDate == nil)
                .opacity(startDate == nil ? 0.5 : 1.0) // Optional visual cue
                .sheet(isPresented: $isEndDatePickerPresented) {
                    if let safeStartDate = startDate {
                        DatePickerModalView(
                            title: "End Date",
                            isPresented: $isEndDatePickerPresented,
                            selectedDate: Binding(
                                get: { endDate ?? safeStartDate },
                                set: {
                                    // Validation: Only set if >= startDate
                                    if $0 >= safeStartDate {
                                        endDate = $0
                                    }
                                }
                            ),
                            minimumDate: safeStartDate
                        )
                    }
                }

            }
            .padding(.horizontal)
            
            // MARK: - Apply Button
            if !showListView {
                Button(action: {
                    isLoading = true

                    // Simulate loading
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        isLoading = false
                        showListView = true
                       viewModel.fetchConditions()
                        
                    }
                }) {
                    Text(isLoading ? "Loading..." : "Apply")
                        .font(.custom("Montserrat-SemiBold", size: 17))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(isApplyEnabled ? Color(hex: Constants.API.PrimaryColorHex) : Color(hex: "AAAEB3"))
                        .foregroundColor(.white)
                        .cornerRadius(32)
                        .padding(.horizontal)
                }
                .disabled(!isApplyEnabled || isLoading)
                .padding(.top, 20)
            }

            // MARK: - List View
            if showListView {
                List {
                    ForEach(viewModel.conditions) { assist in
                        AssistListCardView(assistData: assist) {
                                
                        }
                    }
                    
                }
                .listStyle(.plain)
            }
            
//            if showListView {
//                List {
//                    ForEach(assisData) { assist in
//                        AssistListCardView(assistData: assist) {
//                                
//                        }
//                    }
//                    
//                }
//                .listStyle(.plain)
//            }

            Spacer()
        }
        .padding()
        .background(Color.white)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                CustomBackButton {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }

    }

    private var isApplyEnabled: Bool {
        startDate != nil && endDate != nil
    }

    private func formattedDate(_ date: Date?) -> String {
        guard let date = date else { return "MM-DD-YYYY" }
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}
    


    
struct AssistDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AssistDetailView()
    }
}
// PromptBuilder.swift
import Foundation

struct PromptBuilder {
    static func buildPrompt(from conditions: [Condition]) -> String {
        var prompt = "Patient history:\n"
        for condition in conditions {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            let dateStr = formatter.string(from: condition.date)
            prompt += "- \(condition.name) (\(condition.code)) on \(dateStr)\n"
        }
        prompt += "\nSuggest any chronic condition patterns based on the above."
        return prompt
    }
}

// LLMManager.swift
import Foundation

class LLMManager {
    func getAdvice(prompt: String, completion: @escaping (Result<Insight, Error>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            let confidence = Double.random(in: 0.6...0.95)
            let source = confidence < 0.8 ? "Claude" : "Llama"
            let advice = Insight(
                id: UUID(),
                text: "Possible hypertension pattern identified.",
                confidence: confidence,
                source: source,
                createdAt: Date()
            )
            completion(.success(advice))
        }
    }
}

// ViewModel.swift
import Foundation
import Combine

class ChronicConditionDetectorViewModel: ObservableObject {
    @Published var conditions: [Condition] = []
    @Published var insights: [Insight] = []
    @Published var startDate = Calendar.current.date(byAdding: .year, value: -1, to: Date()) ?? Date()
    @Published var endDate = Date()

    private let llmManager = LLMManager()
    private var cancellables = Set<AnyCancellable>()

    func fetchConditions() {
      self.conditions = MockData.conditions.filter {
            print("Checking \($0.name) — \($0.date)")
            return $0.date >= startDate && $0.date <= endDate
        }

    }
    


    func generateInsights() {
        let prompt = PromptBuilder.buildPrompt(from: conditions)
        llmManager.getAdvice(prompt: prompt) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let insight):
                    self.insights.append(insight)
                case .failure(let error):
                    print("LLM error: \(error.localizedDescription)")
                }
            }
        }
    }
}


// MockData.swift
import Foundation

struct MockData {
    static let conditions: [Condition] = [
        Condition(id: UUID(), name: "Seasonal allergic rhinitis", code: "I10", date: Date().addingTimeInterval(-86400 * 300),time: "07-01-2021", dateRange: "2021-2022"),
        Condition(id: UUID(), name: "Pneumonia, unspecified", code: "S83.241A", date: Date().addingTimeInterval(-86400 * 200),time: "08-01-2021", dateRange: "2021-2022"),
        Condition(id: UUID(), name: "Essential hypertension", code: "R07.9", date: Date().addingTimeInterval(-86400 * 1),time: "06-15-2021", dateRange: "2021-2022"),
        Condition(id: UUID(), name: "X-ray", code: "R07.9", date: Date().addingTimeInterval(-86400 * 400),time: "2021-03-15 ", dateRange: "2021-2022"),
        Condition(id: UUID(), name: "Magnetic Resonance Imaging", code: "R07.9", date: Date().addingTimeInterval(-86400 * 500),time: "02-10-2022", dateRange: "2021-2022"),
        Condition(id: UUID(), name: "Lipid panel", code: "R07.9", date: Date().addingTimeInterval(-86400 * 600),time: "06-16-2022", dateRange: "2021-2022"),
        Condition(id: UUID(), name: "Complete blood count", code: "R07.9", date: Date().addingTimeInterval(-86400 * 700),time: "06-15-2021", dateRange: "2021-2022"),
        Condition(id: UUID(), name: "Lipid panel", code: "R07.9", date: Date().addingTimeInterval(-86400 * 800),time: "06-15-2021", dateRange: "2021-2022")
        
    ]
}
