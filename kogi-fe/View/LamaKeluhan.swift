////
////  LamaKeluhan.swift
////  kogi-fe
////
////  Created by Jonathan Axel Benaya on 14/05/24.
////
//
//import SwiftUI
//
//struct LamaKeluhan: View {
//    
//    @Binding var path : NavigationPath
//    @ObservedObject var anamnesisViewModel: AnamnesisViewModel
//    
//    var body: some View {
//        VStack {
//            Text("Lama Keluhan")
//        }
//        .onAppear(perform: {
//            print(path.count)
//        })
//        .navigationBarBackButtonHidden(true)
//        .toolbar {
//            ToolbarItem(placement: .navigationBarLeading) {
//                Button(action: {
//                    path.removeLast()
//                }, label: {
//                    Image(systemName: "chevron.left")
//                })
//            }
//        }
//        
//    }
//}
//
//#Preview {
//    LamaKeluhan(path: .constant(NavigationPath()), anamnesisViewModel: AnamnesisViewModel())
//}
