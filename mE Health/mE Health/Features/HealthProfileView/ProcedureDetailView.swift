
import SwiftUI
import ComposableArchitecture

struct ProcedureDetailView: View {
    
    let data: ProcedureDummyData
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
            ZStack {
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(spacing: 24) {
                        
                        // Title
                        Text("Details")
                            .font(.custom("Montserrat-Bold", size: 32))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                        
                        VStack(alignment: .leading, spacing: 12) {
                            
                            HStack(spacing: 8) {
                                Text("Appendectomy")
                                    .font(.custom("Montserrat-Bold", size: 17))
                                    .foregroundColor(.black)
                                
                                Spacer()
                                
                                Text("Completed")
                                    .font(.caption)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 4)
                                    .background(Color.green.opacity(0.2))
                                    .foregroundColor(.green)
                                    .clipShape(Capsule())
                                
                            }

                            
                            Text("03/15/2024")
                                .font(.custom("Montserrat-SemiBold", size: 13))

                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 2)
                        .padding(.horizontal)

                        
                        
                        // Allergy Detail Card
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Procedure Details")
                                .font(.custom("Montserrat-Bold", size: 17))

                            HStack {
                                Text("Procedure ID")
                                .font(.custom("Montserrat-Regular", size: 14))
                                Spacer()
                                Text("#PRO-2023-091")
                                .font(.custom("Montserrat-SemiBold", size: 13))
                            }

                            HStack {
                                Text("Reason")
                                .font(.custom("Montserrat-Regular", size: 14))
                                Spacer()
                                Text("Acute Appendicitis")
                                .font(.custom("Montserrat-SemiBold", size: 13))
                            }

                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 2)
                        .padding(.horizontal)
                        
                        

                        VStack(alignment: .leading, spacing: 12) {
                            
                            HStack(spacing: 8) {
                                Text("Visits")
                                    .font(.custom("Montserrat-Bold", size: 17))
                                    .foregroundColor(.black)
                                
                                Spacer()
                                
                                Text("Completed")
                                    .font(.caption)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 4)
                                    .background(Color.green.opacity(0.2))
                                    .foregroundColor(.green)
                                    .clipShape(Capsule())
                                
                            }

                            
                            Text("Recorded Date: 06/11/2025")
                                .font(.custom("Montserrat-SemiBold", size: 13))

                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 2)
                        .padding(.horizontal)
                        
                        Spacer()

                        // Bottom Buttons
                        ActionButtonsView()
                        
                        Button(action: {
                            
                        }) {
                            Text("Add Follow-Up")
                                .font(.custom("Montserrat-SemiBold", size: 16))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .frame(height:45)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(Color(hex: "FF6605"))
                                .cornerRadius(32)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.horizontal,12)


                        
                        Spacer()

                    }
                }
                .padding(.top)
                .background(Color.white.ignoresSafeArea())
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        CustomBackButton {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
            }
    }
}


#Preview {
    ProcedureDetailView(data: ProcedureDummyData(name: "", recordDate: "", status: .completed))
}



