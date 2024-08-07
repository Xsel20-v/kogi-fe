//
//  FilterSheet.swift
//  kogi-fe
//
//  Created by Azella Mutyara on 22/05/24.
//

import SwiftUI

struct FilterSheet: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedDate = Date()
    @State private var startTime = Date()
    @State private var endTime = Date()
    @State private var selectedCaseVariants: Set<String> = []
    @ObservedObject var treatmentViewModel: TreatmentViewModel
    
    @Binding var dataIsRetrieved: Bool
    var category: String
    let minimumDate = Date.now
    
    @Binding var isPresented: Bool
    
    let caseVariants = ["Seri Atas", "Seri Bawah", "Taring Atas", "Taring Bawah", "Geraham Depan Atas", "Geraham Depan Bawah", "Geraham Belakang Atas", "Geraham Belakang Bawah"]
    
    var body: some View {
        VStack {
            VStack {
                Image("swipeDownIndicator")
                Text("Filter")
                    .font(.title)
                    .bold()
                    .offset(x: -150)
            }
            .padding()
            
            ScrollView {
                
                VStack(alignment: .leading) {
                    
                    HStack {
                        Text("Tanggal")
                            .font(.system(size: 16, weight: .semibold))
                        
                        Spacer()
                        DatePicker("", selection: $selectedDate, displayedComponents: .date)
                            .datePickerStyle(CompactDatePickerStyle())
                           
                    }
                    .padding()
                    .padding(.bottom, -5)
                    
                    HStack {
                        Text("Rentang Waktu")
                            .font(.system(size: 16, weight: .semibold))
                        
                        Spacer()
                        
                        HStack {
                            DatePicker("", selection: $startTime, in: minimumDate..., displayedComponents: .hourAndMinute)
                                .labelsHidden()
                            Text("-")
                            DatePicker("", selection: $endTime, in: minimumDate..., displayedComponents: .hourAndMinute)
                                .labelsHidden()
                        }
                    }
                    .padding()
                    .padding(.bottom, -5)
                    
                    if category != "Sariawan" && category != "Gusi Bengkak" && category != "Kawat Lepasan" {
                        VStack(alignment: .leading) {
                            Text("Varian Kasus")
                                .font(.system(size: 16, weight: .semibold))
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 2), spacing: 10) {
                                ForEach(caseVariants, id: \.self) { variant in
                                    Button(action: {
                                        if selectedCaseVariants.contains(variant) {
                                            selectedCaseVariants.remove(variant)
                                        } else {
                                            selectedCaseVariants.insert(variant)
                                        }
                                        print(selectedCaseVariants)
                                    }) {
                                        Text(variant)
                                            .frame(maxWidth: .infinity, maxHeight: 40)
                                            .font(.system(size: 16))
                                            .padding(7)
                                            .background(selectedCaseVariants.contains(variant) ? Color("primaryColor") : Color.gray)
                                            .foregroundColor(.white)
                                            .cornerRadius(20)
                                    }
                                }
                            }
                        }
                        .padding()
                    }
                    
                    
                }
                
            }
            
            Button(action: {
//                print(selectedDate.toString())
//                print(startTime.timeToString())
//                print(endTime.timeToString())
//                print(selectedCaseVariants)
                isPresented = false
                Task {
                    dataIsRetrieved = await treatmentViewModel.getTreatmentUsingFilter(category: category, date: selectedDate.toString(), start: startTime.timeToString(), end: endTime.timeToString(), variants: [String](selectedCaseVariants))
                    
                    if !dataIsRetrieved {
                        treatmentViewModel.treatmentList?.removeAll()
                    }
                }
                
            }) {
                ButtonComponent(text: "Terapkan Filter", buttonColors: .blue)
                    .padding()
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: 500)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 20)
    }
}


struct SheetView: View {
    @State private var isFilterSheetPresented = false
    
    var body: some View {
        ZStack {
            VStack {
                Button(action: {
                    isFilterSheetPresented.toggle()
                }) {
                    Text("Show Filter")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .blur(radius: isFilterSheetPresented ? 5 : 0)
            
            BottomSheetView(isPresented: $isFilterSheetPresented, maxHeight: 500) {
                FilterSheet(treatmentViewModel: TreatmentViewModel(), dataIsRetrieved: .constant(false), category: "Sakit Gigi", isPresented: .constant(true))
            }
        }
        .animation(.default, value: isFilterSheetPresented)
    }
    
}


#Preview {
    FilterSheet(treatmentViewModel: TreatmentViewModel(), dataIsRetrieved: .constant(false), category: "Sakit Gigi", isPresented: .constant(true))
}
