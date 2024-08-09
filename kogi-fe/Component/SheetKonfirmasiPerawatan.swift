//
//  SheetKonfirmasiPerawatan.swift
//  kogi-fe
//
//  Created by Jonathan Axel Benaya on 28/05/24.
//

import SwiftUI
import Foundation

struct SheetKonfirmasiPerawatan: View {
    
    //passing data tanggal dan problem category dari chat room view
    //data yang dipasing hasil ngambil dari treatmentViewModel dari view sebelumnya
    
    @ObservedObject var treatmentViewModel : TreatmentViewModel
    @State var tanggal: Date
    @State var problemCategory: String
    @State var selectedOption: String
    @Binding var isTreatmentSheetPresented : Bool
    @ObservedObject var socketIOManager : SocketIOManager
    
    let options = [
        Constant.Categories.cabutGigi,
        Constant.Categories.gigiTiruan,
        Constant.Categories.gusiBengkak,
        Constant.Categories.kawatLepasan,
        Constant.Categories.sakitGigi,
        Constant.Categories.sariawan,
        Constant.Categories.karangGigi
    ]
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
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
                let tanggalString = dateFormatter.string(from: tanggal)
                print(tanggalString)
                socketIOManager.sendMessage("treatment", socketIOManager.currentChatRoom.roomID, [tanggalString, selectedOption, treatmentViewModel.fetchedTreatmentData?.treatmentID ?? "null"])
//                print("INI WOYYYY \(treatmentViewModel.fetchedTreatmentData?.treatmentID ?? "null")")
                isTreatmentSheetPresented = false
            }) {
                ButtonComponent(text: "Kirim Konfirmasi", buttonColors: .blue)
            }
            .padding(.bottom, 20)
            
        }
        .padding()
    }
}

#Preview {
    SheetKonfirmasiPerawatan(treatmentViewModel: TreatmentViewModel(), tanggal: Date(), problemCategory: "Sakit Gigi", selectedOption: "Option 1", isTreatmentSheetPresented: .constant(true), socketIOManager: SocketIOManager())
}
