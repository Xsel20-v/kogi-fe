//
//  ContainerDetilSesi.swift
//  kogi-fe
//
//  Created by Azella Mutyara on 09/05/24.
//

import SwiftUI

struct ContainerDetilSesi: View {
    var body: some View {
        
        GeometryReader { geometry in
            let containerWidth = geometry.size.width * 0.9 // 90% of the screen width
            let containerHeight = geometry.size.height * 0.15 // 15% of the screen height
            let imageOffset = containerWidth - 44 // Adjust the offset to be responsive
            
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: containerWidth, height: containerHeight)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    .shadow(radius: 4, y: 4)
                
                VStack(alignment: .leading) {
                    
                    ZStack(alignment: .leading){
                        Text("Sesi 1: ghjjjj")
                            .font(.system(size: 12, weight: .semibold))
                        
                        Image(systemName: "chevron.right")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 12)
                            .offset(x: 310)
                    }
                    
                    ZStack{
                        Rectangle()
                            .frame(width: containerWidth * 0.15, height: 12)
                            .cornerRadius(20)
                            .foregroundColor(Color("systemGreen"))
                        
                        Text("Done")
                            .font(.system(size: 8, weight: .bold))
                            .foregroundColor(.white)
                    }
                    
                    HStack {
                        Image(systemName: "mic.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 12, height: 12)
                            .foregroundColor(Color("primaryColor"))
                        
                        Text("RSGM UNPAD, Kota Bandung")
                            .font(.system(size: 12))
                    }
                    
                    HStack {
                        Image(systemName: "clock.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 12, height: 12)
                            .foregroundColor(Color("primaryColor"))
                        
                        Text("24 Jun 2024 (11.00)")
                            .font(.system(size: 12))
                    }
                }
                .padding(.leading, 20)
            }
        }
    }
}

#Preview {
    ContainerDetilSesi()
}
