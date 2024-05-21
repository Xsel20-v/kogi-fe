//
//  ButtonComponent.swift
//  kogi-fe
//
//  Created by Azella Mutyara on 08/05/24.
//

import SwiftUI

struct ButtonComponent: View {
    
    enum ButtonColors {
        case blue, red, gray
    }
    
    var text : String
    var buttonColors: ButtonColors
    
    var body: some View {
        ZStack{
            Rectangle()
                .frame(width: 352, height: 50)
                .cornerRadius(20)
                .foregroundColor(buttonColor())
                .shadow(radius: 4, y: 4)
            
            Text(text)
                .foregroundStyle(Color.white)
                .font(.system(size: 17))
            
        }
    }
    
    func buttonColor() -> Color {
        switch buttonColors{
        case .blue:
            return Color("primaryColor")
            
        case .red:
            return Color("buttonRed")
            
        case .gray :
            return Color.gray
        }
        
    }
}

#Preview {
    ButtonComponent(text: "text", buttonColors: .blue)
}
