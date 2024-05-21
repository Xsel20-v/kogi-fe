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
    
    var body: some View {
        
        NavigationStack(path: $path) {
            TabView(selection: $tabSelection) {
                Perawatan(path: $path, treatmentViewModel: treatmentViewModel)
                    .badge(0)
                    .tabItem {
                        Label("Perawatan", systemImage: "heart.text.square")
                    }
                Pesan()
                    .badge(1)
                    .tabItem {
                        Label("Pesan", systemImage: "ellipsis.message")
                    }
                Pengaturan()
                    .badge(2)
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
//                case "Lama Keluhan" :
//                    LamaKeluhan(path: $path, treatmentViewModel: treatmentViewModel)
                default:
                    DeskripsiKeluhan(treatmentViewModel: treatmentViewModel, category: Constant.Categories.sakitGigi, path: $path)
                }
            }
        }
        
    }
}

#Preview {
    ContentView(treatmentViewModel: TreatmentViewModel())
}
