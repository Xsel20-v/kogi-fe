//
//  CategoryButton.swift
//  kogi-fe
//
//  Created by Jonathan Axel Benaya on 08/05/24.
//

import SwiftUI

struct CategoryButton: View {
    var text: String
    var image: String
    var textColor: Color = Constant.Colors.baseColor
    var backgroundColor: Color = Constant.Colors.primaryColor
    
    var body: some View {
        VStack {
            Image(image)
                .resizable()
                .frame(width: 38, height: 41)
            Text(text)
                .bold()
                .font(.system(size: 10))
                .multilineTextAlignment(.center)
                .padding(.leading, 5)
                .padding(.trailing, 5)
        }
        .frame(width: 76, height: 92)
        .foregroundColor(textColor)
        .background(backgroundColor)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.7), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    CategoryButton(text: Constant.Categories.kawatLepasan, image: Constant.Images.sakitGigi, textColor: Constant.Colors.baseColor, backgroundColor: Constant.Colors.primaryColor)
}
