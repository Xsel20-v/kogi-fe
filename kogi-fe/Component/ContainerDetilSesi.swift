//
//  ContainerDetilSesi.swift
//  kogi-fe
//
//  Created by Azella Mutyara on 09/05/24.
//

//NOTE: PASSING PARAMETER BELUM!!!!!

import SwiftUI

struct ContainerDetilSesi: View {
    
    enum Status {
        case ongoing, done
    }
    
    var status: Status
    var date: String
    
    var body: some View {
        
        GeometryReader { geometry in
            let containerWidth = geometry.size.width * 0.9 /* 354 pixels in iphone 15 pro*/
            let containerHeight = geometry.size.height * 0.13 /* 109 pixels in iphone 15 pro*/
            let imageIconFrame = geometry.size.height * 0.014
            let chevronRightOffset = geometry.size.width * 0.79
            let statusContainerWidth = geometry.size.width * 0.15
            
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
                            .frame(height: imageIconFrame)
                            .offset(x: chevronRightOffset)
                    }
                    
                    ZStack{
                        Rectangle()
                            .frame(width: statusContainerWidth, height: imageIconFrame)
                            .cornerRadius(20)
                            .foregroundColor(statusColor())
                        
                        Text(statusText())
                            .font(.system(size: 8, weight: .bold))
                            .foregroundColor(.white)
                    }
                    
                    HStack {
                        Image(systemName: "mic.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: imageIconFrame, height: imageIconFrame)
                            .foregroundColor(Color("primaryColor"))
                        
                        Text("RSGM UNPAD, Kota Bandung")
                            .font(.system(size: 12))
                    }
                    
                    HStack {
                        Image(systemName: "clock.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: imageIconFrame, height: imageIconFrame)
                            .foregroundColor(Color("primaryColor"))
                        
                        Text(date)
                            .font(.system(size: 12))
                    }
                }
                .padding(.leading, 20)
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
    }
    
    func statusColor() -> Color {
        switch status {
        case .ongoing:
            return Color("systemYellow")
        case .done:
            return Color("systemGreen")
        }
    }
    
    func statusText() -> String {
        switch status {
        case .ongoing:
            return "Ongoing"
        case .done:
            return "Done"
        }
    }
}

#Preview {
    ContainerDetilSesi(status: .done, date: "24 Jun 2024 (11.00)")
}
