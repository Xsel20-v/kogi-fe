//
//  RiwayatPerawatanView.swift
//  kogi-fe
//
//  Created by Azella Mutyara on 24/05/24.
//

import SwiftUI

struct RiwayatPerawatanView: View {
    
    @Binding var path : NavigationPath
    @Binding var tabSelection: Int
    
    var body: some View {
        ZStack {
            Color(Constant.Colors.baseColor)
                .ignoresSafeArea()
            VStack {
                HeaderViewWithTitle(title: "Riwayat Perawatan")
                    .padding(.top, -60)
                
                ScrollView {
                    ForEach(0..<2) { _ in
                        // container done + ditambah buat profilenya diganti sesuai department
                    }
                }
            }
        }
    }
}

#Preview {
    RiwayatPerawatanView(path: .constant(NavigationPath()), tabSelection: .constant(0))
}
