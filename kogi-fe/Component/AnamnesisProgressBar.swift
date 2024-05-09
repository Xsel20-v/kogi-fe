//
//  AnamnesisProgressBar.swift
//  kogi-fe
//
//  Created by Azella Mutyara on 09/05/24.
//

import SwiftUI

struct AnamnesisProgressBar: View {
    
    var width : CGFloat = 359
    var progress : Int
    var totalQuestions: Int
    
    var body: some View {
        
        ZStack{
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: width, height: 21)
                    .cornerRadius(20)
                    .foregroundColor(Color("systemGray"))
                
                Rectangle()
                    .frame(width: width*CGFloat(progress)/CGFloat(totalQuestions), height: 21)
                    .cornerRadius(20)
                    .foregroundColor(Color("primaryColor"))
            }
            
            Text("\(progress)/\(totalQuestions)")
                .foregroundStyle(Color.white)
                .font(.system(size: 16, weight: .semibold))
            
        }
    }
}

#Preview {
    AnamnesisProgressBar(progress: 1, totalQuestions: 3)
}
