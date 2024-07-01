//
//  ReportFormView.swift
//  kogi-fe
//
//  Created by Azella Mutyara on 01/07/24.
//

import SwiftUI

struct ReportFormView: View {
    @State var catatan : String = ""
    
    var body: some View {
        ZStack{
            Color(Constant.Colors.baseColor)
                .ignoresSafeArea()
            VStack {
                HeaderViewComponent()
                    .padding(.top, -60)
                
                Spacer()
                
                ScrollView{
                    VStack(alignment: .leading, spacing: 20){
                        
                        VStack(alignment:.leading) {
                            Text("Sesi 1: \nPembersihan Karang Gigi & Penambalan")
                                .font(.system(size: 14, weight: .bold))
                            
                            HStack{
                                Image(systemName: "mappin")
                                    .foregroundColor(Constant.Colors.primaryColor)
                                Text("RSGM UNPAD, Kota Bandung")
                            }
                            
                            HStack{
                                Image(systemName: "clock.fill")
                                    .foregroundColor(Constant.Colors.primaryColor)
                                
                                Text("24 Jun 2024 (11.00)")
                            }
                        }
                        .font(.system(size: 14))
                        
                        Divider()
                        
                        VStack(alignment: .leading) {
                            HStack{
                                Text("Catatan KOAS")
                                Text("*")
                                    .foregroundColor(.red)
                            }
                            .font(.system(size: 14))
                            .bold()
                            
                            ScrollView {
                                TextEditor(text: $catatan)
                                    .font(.system(size: 14))
                                    .padding()
                                    .cornerRadius(20)
                                    .frame(width: 360, height: 221)
                                    .overlay(alignment: .topLeading) {
                                        if catatan.isEmpty {
                                            Text("Tuliskan Catatan Perawatan...")
                                                .font(.system(size: 14))
                                                .foregroundColor(.gray)
                                                .padding()
                                                .padding(.top, 7)
                                                .padding(.leading, 2)
                                        }
                                    }
                            }
                            .background(Color.white)
                            .cornerRadius(20)
                            .shadow(radius: 0.6)
                        }
                        
                        
                        VStack(alignment: .leading) {
                            HStack{
                                Image(systemName: "photo.on.rectangle")
                                Text("Foto Kondisi Awal")
                            }
                            .fontWeight(.semibold)
                            
                            ImagePicker(placeholder: "Masukkan Foto Kondisi Awal")
                        }
                        
                        
                        
                        VStack(alignment: .leading) {
                            HStack{
                                Image(systemName: "photo.fill.on.rectangle.fill")
                                Text("Foto Kondisi Akhir")
                            }
                            .fontWeight(.semibold)
                            
                            
                            ImagePicker(placeholder: "Masukkan Foto Kondisi Akhir")
                        }
                        
                    }
                    .padding()
                }
                
                ButtonComponent(text: "Selesaikan Sesi", buttonColors: .blue)
            }
        }
        .font(.system(size: 14))
    }
}

#Preview {
    ReportFormView()
}
