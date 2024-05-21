//
//  ContainerPerawatan.swift
//  kogi-fe
//
//  Created by Azella Mutyara on 08/05/24.
//

import SwiftUI

struct ContainerPerawatan: View {
    
    enum Status {
        case pending, ongoing, done
    }
    
    var status: Status
    
    var width : CGFloat = 356
    var height : CGFloat = 180
    var cornerRadius : CGFloat = 20
    var height2: CGFloat = 40
    var shadowRadius : CGFloat = 4
    var shadowY : CGFloat = 4
    var color1 : Color = .white
    
    var category: String
    var nama : String
    var departemen: String
    var jumlahSesi: String
    
    var body: some View {
        ZStack{
            Rectangle()
                .frame(width: width, height: height)
                .cornerRadius(cornerRadius)
                .foregroundColor(color1)
                .shadow(radius: shadowRadius, y: shadowY)
                .overlay(
                    GeometryReader { geometry in
                        Path { path in
                            path.move(to: CGPoint(x: 0, y: 38))
                            path.addLine(to: CGPoint(x: geometry.size.width, y: 38))
                        }
                        .stroke(Color.gray, lineWidth: 1)
                    }
                )
            
            Rectangle()
                .frame(width: width, height: height2)
                .cornerRadius(cornerRadius)
                .offset(y: height/2 - height2/2)
                .foregroundColor(statusColor())
            
            Rectangle()
                .frame(width: width, height: height2/2)
                .offset(y: height/2 - height2/2 - height2/4)
                .foregroundColor(statusColor())
            
            VStack(alignment: .leading) {
                ZStack(alignment: .leading) {
                    Text(category)
                        .font(.system(size: 16, weight: .semibold))
//                        .padding(.trailing, width/1.5)
                    
                    Image(systemName: "chevron.right")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 16)
                        .offset(x: 315)
                }
                .padding(.top, -25)
                
                ZStack(alignment: .leading) {
                    Circle()
                        .frame(width: 73)
                    
                    VStack(alignment: .leading) {
                        Text(nama)
                            .font(.system(size: 16, weight: .semibold))
                        Text(departemen)
                            .font(.system(size: 12))
                            .italic()
                    }
                    .offset(x: 85)
                }
                .padding(.top, 5)
                
                HStack{
                    
                    Image(systemName: "mic.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 16, height: 16)
                        .foregroundColor(Color("primaryColor"))
                    
                    Text("RSGM UNPAD, Kota Bandung")
                        .font(.system(size: 12))
                        .padding(.leading, -5)
                    
                    
                    Image(systemName: "clock.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 16, height: 16)
                        .foregroundColor(Color("primaryColor"))
                    
                    Text("24 Jun 2024 (11.00)")
                        .font(.system(size: 12))
                        .padding(.leading, -5)
                }
                .offset(y: height/2 - 65)
                
            }
        }
    }
    
    func statusColor() -> Color {
        switch status {
        case .pending:
            return Color.yellow
        case .ongoing:
            return Color.green
        case .done:
            return Color("primaryColor")
        }
    }
}

#Preview {
    ContainerPerawatan(status: .pending, category: "Sakit Gigi", nama: "Azella Gania Mutyara", departemen: "Departemen Konservasi Gigi", jumlahSesi: "2")
}


