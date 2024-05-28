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
        
            let containerWidth = CGFloat(354)
            let containerHeight = CGFloat(109)
            let imageIconFrame = CGFloat(15)
            let statusContainerWidth = CGFloat(45)
            
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: containerWidth, height: containerHeight)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    .shadow(radius: 4, y: 4)
                
                VStack(alignment: .leading) {
                    
                    HStack(){
                        Text("Sesi 1")
                            .font(.system(size: 12, weight: .semibold))
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: imageIconFrame)
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
                .padding()
            }
            .frame(width: containerWidth, height: containerHeight)
        
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
