//
//  ContainerPerawatan.swift
//  kogi-fe
//
//  Created by Azella Mutyara on 08/05/24.
//

//NOTE: PASSING PARAMETER BELUM!!!!!

import SwiftUI

struct ContainerPerawatan: View {
    
    enum Status {
        case pending, ongoing, done
    }
    
    var status: Status
    
    var shadowRadius : CGFloat = 4
    var shadowY : CGFloat = 4
    var color1 : Color = .white
    
    var category: String
    var nama : String
    var departemen: String
    var jumlahSesi: String
    
    var body: some View {
        GeometryReader { geometry in
            
            let width : CGFloat = geometry.size.width * 0.9
            let height : CGFloat = geometry.size.height * 0.235
            let height2: CGFloat = geometry.size.height * 0.052
            let cornerRadius : CGFloat = 20
            
            let chevronRightOffset = geometry.size.width * 0.8
            let padding25 = geometry.size.height * 0.033
            
            
            let fontSize16 = geometry.size.width * 0.04
            let fontSize12 = geometry.size.width * 0.03
            
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
                            .font(.system(size: fontSize16, weight: .semibold))
                        
                        Image(systemName: "chevron.right")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: fontSize16)
                            .offset(x: chevronRightOffset)
                    }
                    .padding(.top, -padding25)
                    
                    ZStack(alignment: .leading) {
                        Circle()
                            .frame(width: geometry.size.width * 0.187)
                        
                        VStack(alignment: .leading) {
                            Text(nama)
                                .font(.system(size: fontSize16, weight: .semibold))
                            Text(departemen)
                                .font(.system(size: fontSize12))
                                .italic()
                            
                            if status == .done {
                                Text("\(jumlahSesi) Sesi")
                                    .font(.system(size: fontSize12, weight: .thin))
                                    .italic()
                            }
                        }
                        .offset(x: geometry.size.width * 0.22)
                    }
                    .padding(.top, geometry.size.height * 0.0065)
                    
                    HStack{
                        
                        Image(systemName: "mic.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: fontSize16, height: fontSize16)
                            .foregroundColor(foregroundIcon())
                        
                        Text("RSGM UNPAD, Kota Bandung")
                            .font(.system(size: fontSize12))
                            .padding(.leading, geometry.size.height * -0.0065)
                            .foregroundColor(foregroundLocationAndDate())
                        
                        
                        Image(systemName: "clock.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: fontSize16, height: fontSize16)
                            .foregroundColor(foregroundIcon())
                        
                        Text("24 Jun 2024 (11.00)")
                            .font(.system(size: fontSize12))
                            .padding(.leading, geometry.size.height * -0.0065)
                            .foregroundColor(foregroundLocationAndDate())
                    }
                    .offset(y: geometry.size.width * 0.06)
                    
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
    }
    
    func statusColor() -> Color {
        switch status {
        case .pending:
            return Color("systemYellow")
        case .ongoing:
            return Color("systemGreen")
        case .done:
            return Color("primaryColor")
        }
    }
    
    func foregroundLocationAndDate() -> Color {
        switch status {
        case .done:
            return Color.white
        default:
            return Color.black
        }
    }
    
    func foregroundIcon() -> Color {
        switch status {
        case .done:
            return Color.white
        default:
            return Color("primaryColor")
        }
    }
}

#Preview {
    ContainerPerawatan(status: .ongoing, category: "Sakit Gigi", nama: "Azella Gania Mutyara", departemen: "Departemen Konservasi Gigi", jumlahSesi: "2")
}


