//
//  HeaderViewAnamnesis.swift
//  kogi-fe
//
//  Created by Jonathan Axel Benaya on 14/05/24.
//

import SwiftUI

struct HeaderViewAnamnesis : View {
    
    var category: String
    var blueRectangleWidth: CGFloat = UIScreen.main.bounds.width
    var blueRectangleHeight: CGFloat = 98
    
    var body: some View{
        ZStack {
            Rectangle()
                .fill(Constant.Colors.primaryColor)
                .frame(width: blueRectangleWidth, height: blueRectangleHeight)
            Text(category)
                .foregroundColor(Constant.Colors.baseColor)
                .padding(.top, 50)
        }
    }
}

#Preview {
    HeaderViewAnamnesis(category: "Sakit Gigi")
}
