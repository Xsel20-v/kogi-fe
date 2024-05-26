//
//  HeaderViewWithTitle.swift
//  kogi-fe
//
//  Created by Azella Mutyara on 24/05/24.
//

import SwiftUI

struct HeaderViewWithTitle : View {
    
    var title: String
    var blueRectangleWidth: CGFloat = UIScreen.main.bounds.width
    var blueRectangleHeight: CGFloat = 98
    
    var body: some View{
        ZStack {
            Rectangle()
                .fill(Constant.Colors.primaryColor)
                .frame(width: blueRectangleWidth, height: blueRectangleHeight)
            Text(title)
                .font(.system(size: 18))
                .foregroundColor(Constant.Colors.baseColor)
                .fontWeight(.semibold)
                .padding(.top, 50)
        }
    }
}

#Preview {
    HeaderViewWithTitle(title: "Cari Perawatan")
}
