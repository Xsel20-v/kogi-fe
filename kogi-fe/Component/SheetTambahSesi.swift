//
//  SheetTambahSesi.swift
//  kogi-fe
//
//  Created by Jonathan Axel Benaya on 28/05/24.
//

import SwiftUI

struct SheetTambahSesi: View {
    
    @State private var tanggal = Date.now
    
    var body: some View {
        VStack {
            Image("swipeDownIndicator")
                .padding(.bottom, 20)
            DatePicker("Tanggal & Waktu", selection: $tanggal)
                .padding(.bottom, 20)
            Button(action: {
                //add new session
                
            }, label: {
                ButtonComponent(text: "Buat Sesi", buttonColors: .blue)
            })
            .padding(.bottom, 20)
        }
    }
}

#Preview {
    SheetTambahSesi()
}
