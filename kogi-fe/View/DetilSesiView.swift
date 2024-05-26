//
//  DetilSesiView.swift
//  kogi-fe
//
//  Created by Azella Mutyara on 23/05/24.
//

import SwiftUI

struct DetilSesiView: View {
    
    @State var fotoAwal : [Data]? = nil
    @State var fotoAkhir : [Data]? = nil
    
    var body: some View {
        ZStack {
            Color(Constant.Colors.baseColor)
                .ignoresSafeArea()
            VStack {
                HeaderViewComponent()
                    .padding(.top, -60)
                
                Spacer()
                
                ScrollView{
                    VStack(spacing: 10){
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .foregroundColor(Color.white)
                            
                            VStack(alignment:.leading) {
                                Text("Sesi 1: \nPembersihan Karang Gigi & Penambalan")
                                    .font(.system(size: 18, weight: .bold))
                                
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
                            .padding(.horizontal, 20)
                            .padding(.vertical, 15)
                        }
                        
                        ZStack(alignment:.leading) {
                            Rectangle()
                                .foregroundColor(Color.white)
                            
                            VStack(alignment:.leading) {
                                HStack{
                                    Image(systemName: "note.text")
                                    Text("Catatan Koas")
                                }
                                .fontWeight(.semibold)
                                
                                Text("deskripsi catatan")
                                    .padding(.top, 5)
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 15)
                        }
                        
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .foregroundColor(Color.white)
                            
                            VStack(alignment: .leading) {
                                HStack{
                                    Image(systemName: "photo.on.rectangle")
                                    Text("Foto Kondisi Awal")
                                }
                                .fontWeight(.semibold)
                                
                                HStack {
                                    if (fotoAwal != nil) {
                                        
                                    } else {
                                        Text("Foto tidak tersedia...")
                                            .frame(height: 70)
                                    }
                                }
                                .padding(.top, 5)
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 15)
                        }
                        
                        ZStack(alignment: .leading){
                            Rectangle()
                                .foregroundColor(Color.white)
                            
                            VStack(alignment: .leading) {
                                    HStack{
                                        Image(systemName: "photo.fill.on.rectangle.fill")
                                        Text("Foto Kondisi Akhir")
                                    }
                                    .fontWeight(.semibold)
                                    
                                    HStack {
                                        if (fotoAkhir != nil) {
                                            
                                        } else {
                                            Text("Foto tidak tersedia...")
                                                .frame(height: 70)
                                        }
                                        
                                    }
                                    .padding(.top, 5)
                                }
                                .padding(.horizontal, 20)
                                .padding(.vertical, 15)
                        }
                    }
                }
            }
        }

    }
}

#Preview {
    DetilSesiView()
}
