//
//  IjazahView.swift
//  kogi-fe
//
//  Created by Azella Mutyara on 22/05/24.
//

import SwiftUI

struct IjazahView: View {
    @Binding var path: NavigationPath
    @Binding var tabSelection: Int
    
    @State private var selectedImage: String?
    
    var body: some View {
        ZStack {
            Color(Constant.Colors.baseColor)
                .ignoresSafeArea()
            VStack {
                HeaderViewWithTitle(title: "Ijazah")
                    .padding(.top, -100)
                
                Spacer()
                
                Image("kogiLogo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 350, height: 700)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .frame(maxHeight: .infinity)
            }
        }
    }
}

#Preview {
    IjazahView(path: .constant(NavigationPath()), tabSelection: .constant(2))
}
