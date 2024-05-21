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
//    @StateObject var treatmentViewModel = TreatmentViewModel()
//    
//    var body: some View {
//        VStack {
//            
//            if category == Constant.Categories.sakitGigi || category == Constant.Categories.gigiTiruan || category == Constant.Categories.cabutGigi {
//                
//                switch(treatmentViewModel.currentPage) {
//                case 0 :
//                    LokasiKeluhan(category: category, treatmentViewModel: treatmentViewModel)
//                case 1 :
//                    LamaKeluhan(treatmentViewModel: treatmentViewModel)
//                case 2 :
//                    KeluhanPilihWaktu()
//                default:
//                    LokasiKeluhan(category: category, treatmentViewModel: treatmentViewModel)
//                }
//                
//            } else {
//                switch(treatmentViewModel.currentPage) {
//                case 0 :
//                    LokasiKeluhan(category: category, treatmentViewModel: treatmentViewModel)
//                case 1 :
//                    LamaKeluhan(treatmentViewModel: treatmentViewModel)
//                case 2 :
//                    KeluhanPilihWaktu()
//                default:
//                    LokasiKeluhan(category: category, treatmentViewModel: treatmentViewModel)
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
