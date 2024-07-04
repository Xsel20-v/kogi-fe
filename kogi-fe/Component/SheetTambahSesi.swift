//
//  SheetTambahSesi.swift
//  kogi-fe
//
//  Created by Jonathan Axel Benaya on 28/05/24.
//

import SwiftUI

struct SheetTambahSesi: View {
    
    @State private var tanggal = Date.now
    @Binding var showSheet: Bool
    @Binding var hasSession: Bool
    @ObservedObject var treatmentViewModel: TreatmentViewModel
    
    let minimumDate = Date.now
    
    var body: some View {
        VStack {
            Image("swipeDownIndicator")
                .padding(.bottom, 20)
            DatePicker("Tanggal & Waktu", selection: $tanggal, in: minimumDate...)
                .padding(.bottom, 20)
            Button(action: {
                Task {
                    await treatmentViewModel.createSession(date: tanggal.currentDateString())
                    hasSession = await treatmentViewModel.getSessionList()
                }
                showSheet = false
            }, label: {
                ButtonComponent(text: "Buat Sesi", buttonColors: .blue)
            })
            .padding(.bottom, 20)
        }
        .padding()
    }
}

#Preview {
    SheetTambahSesi(showSheet: .constant(true), hasSession: .constant(true), treatmentViewModel: TreatmentViewModel())
}
