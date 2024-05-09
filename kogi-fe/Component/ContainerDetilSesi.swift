//
//  ContainerDetilSesi.swift
//  kogi-fe
//
//  Created by Azella Mutyara on 09/05/24.
//

import SwiftUI

struct ContainerDetilSesi: View {
    
    enum Status {
        case done, ongoing
    }
    
    var status: Status = .done
    
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .frame(width: 354, height: 109)
                .foregroundColor(.white)
                .cornerRadius(20)
                .shadow(radius: 4, y: 4)
            
            VStack(alignment: .leading) {
                
                HStack{
                    Text("Sesi 1: ghjjjj")
                        .font(.system(size: 12, weight: .semibold))
                    
                    Image(systemName: "chevron.right")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 12)
                }
                .padding(.top, 5)
                
                ZStack{
                    Rectangle()
                        .frame(width: 60, height: 12)
                        .cornerRadius(20)
                        .foregroundColor(statusColor())
                    
                    Text(statusText())                        .font(.system(size: 8, weight: .bold))
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
    
    func statusColor() -> Color {
        switch status {
        case .done:
            return Color("systemGreen")
            
        case .ongoing:
            return Color("systemYellow")
        }
    }
    
    func statusText() -> String {
        switch status {
        case .done:
            return "Done"
            
        case .ongoing:
            return "Ongoing"
        }
    }
}

#Preview {
    ContainerDetilSesi()
}
