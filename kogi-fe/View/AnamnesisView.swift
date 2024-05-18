////
////  AnamnesisView.swift
////  kogi-fe
////
////  Created by Jonathan Axel Benaya on 16/05/24.
////
//
//import SwiftUI
//
//struct AnamnesisView: View {
//    
//    var category: String
//    
//    @StateObject var anamnesisViewModel = AnamnesisViewModel()
//    
//    var body: some View {
//        VStack {
//            
//            if category == Constant.Categories.sakitGigi || category == Constant.Categories.gigiTiruan || category == Constant.Categories.cabutGigi {
//                
//                switch(anamnesisViewModel.currentPage) {
//                case 0 :
//                    LokasiKeluhan(category: category, anamnesisViewModel: anamnesisViewModel)
//                case 1 :
//                    LamaKeluhan(anamnesisViewModel: anamnesisViewModel)
//                case 2 :
//                    KeluhanPilihWaktu()
//                default:
//                    LokasiKeluhan(category: category, anamnesisViewModel: anamnesisViewModel)
//                }
//                
//            } else {
//                switch(anamnesisViewModel.currentPage) {
//                case 0 :
//                    LokasiKeluhan(category: category, anamnesisViewModel: anamnesisViewModel)
//                case 1 :
//                    LamaKeluhan(anamnesisViewModel: anamnesisViewModel)
//                case 2 :
//                    KeluhanPilihWaktu()
//                default:
//                    LokasiKeluhan(category: category, anamnesisViewModel: anamnesisViewModel)
//            }
//            
//            Spacer()
//        }
//        .ignoresSafeArea()
//        
//    }
//}
//
//#Preview {
//    AnamnesisView(category: "Sakit Gigi")
//}
