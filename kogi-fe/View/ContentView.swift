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
    @StateObject var treatmentVM = TreatmentViewModel()
    @StateObject var anamnesisViewModel = AnamnesisViewModel()
    
    var body: some View {
        
        NavigationStack(path: $path) {
            TabView(selection: $tabSelection) {
                Perawatan(treatmentVM: treatmentVM, path: $path)
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
                    DeskripsiKeluhan(anamnesisViewModel: anamnesisViewModel, category: Constant.Categories.sakitGigi, path: $path)
                case Constant.Categories.karangGigi :
                    DeskripsiKeluhan(anamnesisViewModel: anamnesisViewModel, category: Constant.Categories.karangGigi, path: $path)
                case Constant.Categories.cabutGigi :
                    DeskripsiKeluhan(anamnesisViewModel: anamnesisViewModel, category: Constant.Categories.cabutGigi, path: $path)
                case Constant.Categories.gigiTiruan :
                    DeskripsiKeluhan(anamnesisViewModel: anamnesisViewModel, category: Constant.Categories.gigiTiruan, path: $path)
                case Constant.Categories.kawatLepasan :
                    DeskripsiKeluhan(anamnesisViewModel: anamnesisViewModel, category: Constant.Categories.kawatLepasan, path: $path)
                case Constant.Categories.gusiBengkak :
                    DeskripsiKeluhan(anamnesisViewModel: anamnesisViewModel, category: Constant.Categories.gusiBengkak, path: $path)
                case Constant.Categories.sariawan :
                    DeskripsiKeluhan(anamnesisViewModel: anamnesisViewModel, category: Constant.Categories.sariawan, path: $path)
                case "Lokasi Keluhan" :
                    LokasiKeluhan(path: $path, anamnesisViewModel: anamnesisViewModel)
                case "Keluhan Pilih Waktu" :
                    KeluhanPilihWaktu(path: $path, anamnesisViewModel: anamnesisViewModel)
                case "Ringkasan" :
                    Ringkasan(path: $path, treatmentViewModel: treatmentVM, anamnesisViewModel: anamnesisViewModel)
//                case "Lama Keluhan" :
//                    LamaKeluhan(path: $path, anamnesisViewModel: anamnesisViewModel)
                default:
                    DeskripsiKeluhan(anamnesisViewModel: anamnesisViewModel, category: Constant.Categories.sakitGigi, path: $path)
                }
            }
        }
        
    }
}

#Preview {
    ContentView(anamnesisViewModel: AnamnesisViewModel())
}
