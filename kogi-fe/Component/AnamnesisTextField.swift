//
//  AnamnesisTextField.swift
//  kogi-fe
//
//  Created by Azella Mutyara on 10/05/24.
//

import SwiftUI

struct AnamnesisTextField: View {
    
    @State private var deskripsiKeluhan: String = ""
    
    var body: some View {
        ZStack {
            
            Rectangle()
                .frame(width: 352, height: 141)
                .cornerRadius(20)
                .foregroundColor(.white)
                .shadow(radius: 4)
            
            VStack {
                ScrollView {
                    TextField("Tuliskan keluhan anda...", text: $deskripsiKeluhan)
                        .frame(width: 352, height: 141)
                        .cornerRadius(20)
                        .multilineTextAlignment(.leading)
                        .padding(10)
                }
                .frame(width: 352, height: 141)
                .clipped()
                
//                Text("\(deskripsiKeluhan)")
//                    .padding()
            }
            .padding()
        }
    }
}

#Preview {
    AnamnesisTextField()
}
