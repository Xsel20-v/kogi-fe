//
//  ContainerCariPerawatan.swift
//  kogi-fe
//
//  Created by Azella Mutyara on 24/05/24.
//

import SwiftUI

struct ContainerCariPerawatan: View {
    var body: some View {
        
        ZStack(alignment: .leading) {
            Rectangle()
                .frame(width: 360, height: 180)
                .foregroundColor(.white)
                .cornerRadius(20)
                .shadow(radius: 4, y: 4)
                .overlay(
                    GeometryReader { geometry in
                        Path { path in
                            path.move(to: CGPoint(x: 0, y: 45))
                            path.addLine(to: CGPoint(x: geometry.size.width, y: 45))
                        }
                        .stroke(Color.gray, lineWidth: 1)
                    }
                )
            
            VStack(alignment: .leading, spacing: -10) {
                HStack {
                    Text("Taring Gigi")
                        .fontWeight(.semibold)
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                .padding()
                
                HStack(spacing: 15) {
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
                .padding()
                .offset(y: 5)
                HStack {
                    Image(systemName: "clock.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 16, height: 16)
                        .foregroundColor(Color("primaryColor"))
                    
                    Text("24 Jun 2024 (11.00)")
                        .font(.system(size: 12))
                }
                .padding()
            }
        }
        .frame(width: 360, height: 180)
    }
}

#Preview {
    ContainerCariPerawatan()
}
