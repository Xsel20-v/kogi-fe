//
//  Perawatan.swift
//  kogi-fe
//
//  Created by Jonathan Axel Benaya on 07/05/24.
//

import SwiftUI

struct Perawatan: View {
    
    private var name : String = "Dicky"
    var body: some View {
        VStack {
            ZStack (alignment : .topLeading) {
                Image(Constant.Images.homeBackground)
                    .resizable()
                    .frame(width: 393, height: 277.69)
                
                HStack {
                    VStack (alignment: .leading) {
                        Text("Halo, " + name + "!")
                            .bold()
                        Text("Bagaimana kondisi gigi kamu?")
                            .opacity(0.6)
                    }
                    
                    Spacer()
                    
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Image(systemName: "clock.fill")
                    })
                }
                .foregroundColor(Constant.Colors.baseColor)
                .padding(.top, 70)
                .padding(.leading, 30)
                .padding(.trailing, 30)
                    
                    
            }
            Spacer()
            
        }
        .ignoresSafeArea()
    }
}

#Preview {
    Perawatan()
}
