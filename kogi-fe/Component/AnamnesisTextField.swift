//
//  AnamnesisTextField.swift
//  kogi-fe
//
//  Created by Azella Mutyara on 09/05/24.
//

import SwiftUI

struct AnamnesisTextField: View {
    
    @State private var text: String = ""
    
    var body: some View {
        ZStack {
            
            Rectangle()
                .foregroundColor(.blue)
            
            ScrollView {
                VStack(alignment: .leading) {
                    TextField("Enter text", text: $text)
                        .frame(width: 352, height: 141) // Adjust size
                        .padding()
                        .background(Color.white) // Set background color
                        .cornerRadius(20) // Set corner radius
                        .padding()
                    
                    Text("You entered: \(text)")
                        .padding()
                }
            }
        }
    }
}

#Preview {
    AnamnesisTextField()
}
