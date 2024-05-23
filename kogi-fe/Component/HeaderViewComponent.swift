//
//  HeaderViewComponent.swift
//  kogi-fe
//
//  Created by Azella Mutyara on 23/05/24.
//

import SwiftUI

struct HeaderViewComponent : View {
    
    var blueRectangleWidth: CGFloat = UIScreen.main.bounds.width
    var blueRectangleHeight: CGFloat = 98
    
    var body: some View{
        ZStack {
            Rectangle()
                .fill(Constant.Colors.primaryColor)
                .frame(width: blueRectangleWidth, height: blueRectangleHeight)
        }
    }
}

#Preview {
    HeaderViewComponent()
}
