//
//  DeskripsiKeluhan.swift
//  kogi-fe
//
//  Created by Jonathan Axel Benaya on 09/05/24.
//

import SwiftUI

struct DeskripsiKeluhan: View {
    
    var category: String
    
    var body: some View {
        Text(category)
    }
}

#Preview {
    DeskripsiKeluhan(category: "Sakit Gigi")
}
