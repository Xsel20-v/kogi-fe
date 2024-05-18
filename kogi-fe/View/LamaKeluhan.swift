//
//  LamaKeluhan.swift
//  kogi-fe
//
//  Created by Jonathan Axel Benaya on 14/05/24.
//

import SwiftUI

struct LamaKeluhan: View {
    
    
    var body: some View {
        VStack {
            Text("Lama Keluhan")
        }
        .onAppear(perform: {
            print("Lama Keluhan")
        })
        
    }
}

#Preview {
    LamaKeluhan()
}
