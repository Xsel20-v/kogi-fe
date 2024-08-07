//
//  ContentView.swift
//  kogi-fe
//
//  Created by Jonathan Axel Benaya on 07/05/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var tabSelection = 0
    @State var path = NavigationPath()
    @StateObject var treatmentViewModel = TreatmentViewModel()
//    @StateObject var patientViewModel = PatientViewModel()
    @StateObject var chatViewModel = ChatViewModel()
    @StateObject var socketIOManager = SocketIOManager()
    
    @ObservedObject var loginViewModel: LoginViewModel
    
    @AppStorage("hasTreatment") var hasTreatment = false
    @AppStorage("userID") var userID = "C1"
    @AppStorage("isEligible") var isEligible = false
    
    var body: some View {
        
        NavigationStack(path: $path) {
            TabView(selection: $tabSelection) {
                Perawatan(path: $path, treatmentViewModel: treatmentViewModel, loginViewModel: loginViewModel)
                    .tag(0)
                    .tabItem {
                        Label("Perawatan", systemImage: "heart.text.square")
                    }
                Pesan(path: $path, tabSelection: $tabSelection, socketIOManager: socketIOManager)
                    .tag(1)
                    .tabItem {
                        Label("Pesan", systemImage: "ellipsis.message")
                    }
                Pengaturan(path: $path, tabSelection: $tabSelection, loginViewModel: loginViewModel)
                    .tag(2)
                    .tabItem {
                        Label("Pengaturan", systemImage: "gearshape")
                    }
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationDestination(for: String.self) { value in
                switch (value) {
                case Constant.Categories.sakitGigi :
                    DeskripsiKeluhan(treatmentViewModel: treatmentViewModel, category: Constant.Categories.sakitGigi, path: $path)
                case Constant.Categories.karangGigi :
                    DeskripsiKeluhan(treatmentViewModel: treatmentViewModel, category: Constant.Categories.karangGigi, path: $path)
                case Constant.Categories.cabutGigi :
                    DeskripsiKeluhan(treatmentViewModel: treatmentViewModel, category: Constant.Categories.cabutGigi, path: $path)
                case Constant.Categories.gigiTiruan :
                    DeskripsiKeluhan(treatmentViewModel: treatmentViewModel, category: Constant.Categories.gigiTiruan, path: $path)
                case Constant.Categories.kawatLepasan :
                    DeskripsiKeluhan(treatmentViewModel: treatmentViewModel, category: Constant.Categories.kawatLepasan, path: $path)
                case Constant.Categories.gusiBengkak :
                    DeskripsiKeluhan(treatmentViewModel: treatmentViewModel, category: Constant.Categories.gusiBengkak, path: $path)
                case Constant.Categories.sariawan :
                    DeskripsiKeluhan(treatmentViewModel: treatmentViewModel, category: Constant.Categories.sariawan, path: $path)
                case "Lokasi Keluhan" :
                    LokasiKeluhan(path: $path, treatmentViewModel: treatmentViewModel)
                case "Keluhan Pilih Waktu" :
                    KeluhanPilihWaktu(path: $path, treatmentViewModel: treatmentViewModel)
                case "Ringkasan" :
                    Ringkasan(path: $path, treatmentViewModel: treatmentViewModel)
                case "Ijazah":
                    IjazahView(path: $path, tabSelection: $tabSelection, loginViewModel: loginViewModel)
                case "Ganti Sandi":
                    GantiSandiView(path: $path, tabSelection: $tabSelection, loginViewModel: loginViewModel)
                case "Chat Room":
                     ChatRoomView(path: $path, tabSelection: $tabSelection, treatmentViewModel: treatmentViewModel, socketIOManager: socketIOManager)
                case Constant.Categories.konservasiGigi :
                    CariPerawatanView(path: $path, treatmentViewModel: treatmentViewModel, category: Constant.Categories.sakitGigi)
                case Constant.Categories.periodonsia :
                    CariPerawatanView(path: $path, treatmentViewModel: treatmentViewModel, category: Constant.Categories.periodonsia)
                case Constant.Categories.bedahMulut :
                    CariPerawatanView(path: $path, treatmentViewModel: treatmentViewModel, category: Constant.Categories.cabutGigi)
                case Constant.Categories.pedodonsia :
                    CariPerawatanView(path: $path, treatmentViewModel: treatmentViewModel, category: Constant.Categories.pedodonsia)
                case Constant.Categories.penyakitMulut :
                    CariPerawatanView(path: $path, treatmentViewModel: treatmentViewModel, category: Constant.Categories.sariawan)
                case Constant.Categories.prostodonsia :
                    CariPerawatanView(path: $path, treatmentViewModel: treatmentViewModel, category: Constant.Categories.gigiTiruan)
                case Constant.Categories.orthodonsia:
                    CariPerawatanView(path: $path, treatmentViewModel: treatmentViewModel, category: Constant.Categories.kawatLepasan)
                case "Detail Perawatan Pending View" :
                    DetailPerawatanPendingView(path: $path, tabSelection: $tabSelection, socketIOManager: socketIOManager, treatment: treatmentViewModel.selectedTreatment ?? Constant.sampleTreatment)
                case "Detail Perawatan":
                    DetailPerawatanView(path: $path, tabSelection: $tabSelection, treatmentViewModel: treatmentViewModel, socketIOManager: socketIOManager)
                case "Riwayat Perawatan" :
                    RiwayatPerawatanView(path: $path, tabSelection: $tabSelection, treatmentViewModel: treatmentViewModel)
                case "OnGoing Treatment List" :
                    OnGoingTreatmentListView(path: $path, tabSelection: $tabSelection, treatmentViewModel: treatmentViewModel)                   
                case "FAQ View":
                    FAQView(path: $path, tabSelection: $tabSelection)
                default:
                    if value.hasPrefix("Detail Sesi") {
                        if let index = Int(value.components(separatedBy: " ").last ?? "") {
                            DetilSesiView(treatmentViewModel: treatmentViewModel, index: index)
                        } else {
                            DetilSesiView(treatmentViewModel: treatmentViewModel, index: 0)
                        }
                    } else if value.hasPrefix("Report Form"){
                        if let index = Int(value.components(separatedBy: " ").last ?? "") {
                            ReportFormView(path: $path, treatmentViewModel: treatmentViewModel, index: index)
                        } else {
                            DetilSesiView(treatmentViewModel: treatmentViewModel, index: 0)
                        }
                    } else {
                        DeskripsiKeluhan(treatmentViewModel: treatmentViewModel, category: Constant.Categories.sakitGigi, path: $path)
                    }
                }
            }
        }
        .onAppear {
            socketIOManager.connect()
        }
        
    }
}

#Preview {
    ContentView(treatmentViewModel: TreatmentViewModel(), socketIOManager: SocketIOManager(), loginViewModel: LoginViewModel())
}
