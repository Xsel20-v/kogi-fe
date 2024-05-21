//
//  ContainerRingkasan.swift
//  kogi-fe
//
//  Created by Azella Mutyara on 09/05/24.
//

import SwiftUI

struct ContainerRingkasan: View {
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 352, height: 453)
                .cornerRadius(20)
                .foregroundColor(.white)
                .shadow(radius: 3)
            
            ScrollView {
                
                Text("Sakit Gigi")
                    .font(.system(size: 16, weight: .bold))
                    .padding(.bottom, 10)
                
                VStack(alignment: .leading, spacing: 20) {
                    ZStack(alignment: .leading) {
                        Text("Tanggal Pengajuan")
                            .font(.system(size: 14, weight: .semibold))
                            .padding(.trailing, 40)
                        Text(": ")
                            .font(.system(size: 14, weight: .semibold))
                            .offset(x: 175)
                        Text("Jun 20, 2023")
                            .font(.system(size: 14))
                            .offset(x: 185)
                    }
                    
                    ZStack(alignment: .leading) {
                        Text("Waktu Pengajuan")
                            .font(.system(size: 14, weight: .semibold))
                            .padding(.trailing, 51)
                        Text(": ")
                            .font(.system(size: 14, weight: .semibold))
                            .offset(x: 175)
                        Text("9:41 AM")
                            .font(.system(size: 14))
                            .offset(x: 185)
                    }
                    
                    ZStack(alignment: .leading) {
                        Text("Posisi Keluhan")
                            .font(.system(size: 14, weight: .semibold))
                            .padding(.trailing, 70)
                        Text(": ")
                            .font(.system(size: 14, weight: .semibold))
                            .offset(x: 175)
                        Text("Taring atas, Geraham atas, Taring bawah, Geraham bawah")
                            .font(.system(size: 14))
                            .offset(x: 185)
                            .frame(maxWidth: 110)
                            .multilineTextAlignment(.leading)
                    }
                    
                    ZStack(alignment: .leading) {
                        Text("Rentang Waktu")
                            .font(.system(size: 14, weight: .semibold))
                            .padding(.trailing, 65)
                        Text(": ")
                            .font(.system(size: 14, weight: .semibold))
                            .offset(x: 175)
                        Text("3 Hari")
                            .font(.system(size: 14))
                            .offset(x: 185)
                    }
                    
                    Text("Deskripsi Keluhan")
                        .font(.system(size: 14, weight: .semibold))
                    
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris eget urna vitae lectus gravida ultricies ac sed urna. Proin rutrum enim id porttitor feugiat. Nulla quis mauris quis arcu consequat fermentum vitae ac dui. Nullam quis enim purus.")
                        .font(.system(size: 14))
                        .padding(.top, -10)
                    
                    Text("Foto Kondisi Awal")
                        .font(.system(size: 14, weight: .semibold))
                    
                    ScrollView (.horizontal){
                        HStack {
                            Image(systemName: "photo")
                                .resizable()
                                .frame(width: 80, height: 80)
                            
                            Image(systemName: "photo")
                                .resizable()
                                .frame(width: 80, height: 80)
                            
                            Image(systemName: "photo")
                                .resizable()
                                .frame(width: 80, height: 80)
                            
                            Image(systemName: "photo")
                                .resizable()
                                .frame(width: 80, height: 80)
                        }
                    }
                    .padding(.top, -10)
                }
            }
            .frame(width: 320, height: 430)
            .clipped()
        }
    }
}

#Preview {
    ContainerRingkasan()
}
