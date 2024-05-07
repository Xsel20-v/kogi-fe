//
//  ContentView.swift
//  kogi-fe
//
//  Created by Jonathan Axel Benaya on 07/05/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var tabSelection = 0
    
    var body: some View {
        TabView(selection: $tabSelection) {
            Perawatan()
                .badge(0)
                .tabItem {
                    Label("Perawatan", systemImage: "heart.text.square")
                }
            Pesan()
                .badge(1)
                .tabItem {
                    Label("Pesan", systemImage: "ellipsis.message")
                }
            Pengaturan()
                .badge(2)
                .tabItem {
                    Label("Pengaturan", systemImage: "gearshape")
                }
        }
    }
}

#Preview {
    ContentView()
}
