//
//  DetilSesiView.swift
//  kogi-fe
//
//  Created by Azella Mutyara on 23/05/24.
//

import SwiftUI

struct DetilSesiView: View {
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
                                
                                HStack{
                                    Image(systemName: "mappin")
                                    Text("RSGM UNPAD, Kota Bandung")
                                }
                                HStack{
                                    Image(systemName: "clock.fill")
                                    Text("24 Jun 2024 (11.00)")
                                }
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 15)
                        }
                        
                        ZStack{
                            Rectangle()
                                .foregroundColor(Color.white)
                            
                            VStack{
                                
                            }
                        }
                        
                        ZStack{
                            Rectangle()
                                .foregroundColor(Color.white)
                        }
                        
                        ZStack{
                            Rectangle()
                                .foregroundColor(Color.white)
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
