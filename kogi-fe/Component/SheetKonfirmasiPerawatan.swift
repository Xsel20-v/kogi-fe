//
//  SheetKonfirmasiPerawatan.swift
//  kogi-fe
//
//  Created by Jonathan Axel Benaya on 28/05/24.
//

import SwiftUI

struct SheetKonfirmasiPerawatan: View {
    
    //passing data tanggal dan problem category dari chat room view
    //data yang dipasing hasil ngambil dari treatmentViewModel dari view sebelumnya
    
    @ObservedObject var treatmentViewModel: TreatmentViewModel
    @Binding var tanggal: Date
    @Binding var problemCategory: String
    @Binding var selectedOption: String
    let options = [
        Constant.Categories.cabutGigi,
        Constant.Categories.gigiTiruan,
        Constant.Categories.gusiBengkak,
        Constant.Categories.kawatLepasan,
        Constant.Categories.sakitGigi,
        Constant.Categories.sariawan,
        Constant.Categories.karangGigi
    ]
    
    var body: some View {
        VStack {
            Image("swipeDownIndicator")
                .padding(.bottom, 20)
            DatePicker("Tanggal & Waktu", selection: $tanggal)
                .padding(.bottom, 20)
            HStack {
                Text("Kategori")
                Spacer()
                Picker("Select an option", selection: $selectedOption) {
                    ForEach(options, id: \.self) { option in
                        Text(option).tag(option)
                    }
                }
                .pickerStyle(MenuPickerStyle())
            }
            .padding(.bottom, 20)
            Button(action: {
                //send message in type of "treatment
                
            }, label: {
                ButtonComponent(text: "Kirim Konfirmasi", buttonColors: .blue)
            })
            .padding(.bottom, 20)

        }
    }
}

#Preview {
    SheetKonfirmasiPerawatan(treatmentViewModel: TreatmentViewModel(), tanggal: .constant(Date.now), problemCategory: .constant("Sakit Gigi"), selectedOption: .constant("Option 1"))
}
