//
//  CariPerawatanView.swift
//  kogi-fe
//
//  Created by Azella Mutyara on 24/05/24.
//

import SwiftUI

struct CariPerawatanView: View {
    
    @State private var searchText = ""
    @State var isFilterSheetPresented = false
    
    var body: some View {
        ZStack {
            Color(Constant.Colors.baseColor)
                .ignoresSafeArea()
            VStack {
                HeaderViewWithTitle(title: "Cari Perawatan")
                    .padding(.top, -60)
                
                HStack {
                    SearchBar(text: $searchText)
                    
                    Spacer()
                    
                    Button(action: {
                        isFilterSheetPresented.toggle()
                    }) {
                        Image(systemName: "line.horizontal.3.decrease.circle")
                            .font(.system(size: 25))
                            .foregroundColor(.gray)
                    }
                    .padding(.trailing)
                }
                
                HStack{
                    Text("Recommended Perawatan")
                        .font(.headline)
                        .padding([.top, .horizontal])
                    
                    Spacer()
                }
                    
                ScrollView {
                    ForEach(0..<2) { _ in
                        ContainerCariPerawatan()
                            .padding(.vertical, 10)
                    }
                }
            }
            
            BottomSheetView(isPresented: $isFilterSheetPresented, maxHeight: 500) {
                FilterSheet()
            }
        }
    }
}

#Preview {
    CariPerawatanView()
}
