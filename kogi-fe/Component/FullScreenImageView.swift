//
//  FullScreenImageView.swift
//  kogi-fe
//
//  Created by Azella Mutyara on 25/05/24.
//

import SwiftUI

import SwiftUI

struct FullScreenImageView: View {
    @Binding var isPresented: Bool
//    var imageName: String

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Color.white.edgesIgnoringSafeArea(.all)
            
//            ZoomableScrollView {
                Image("kogiLogo")
                    .resizable()
                    .scaledToFit()
//            }

            Button(action: {
                isPresented.toggle()
            }) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.gray)
                    .padding()
            }
        }
    }
}


//#Preview {
//    @State var test : Bool = true
//    FullScreenImageView(isPresented: $test)
//}
