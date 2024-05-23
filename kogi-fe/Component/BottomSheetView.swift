//
//  BottomSheetView.swift
//  kogi-fe
//
//  Created by Azella Mutyara on 22/05/24.
//

import SwiftUI

struct BottomSheetView<Content: View>: View {
    @Binding var isPresented: Bool
    let maxHeight: CGFloat
    let content: Content
    @State private var translation: CGFloat = 0
    
    init(isPresented: Binding<Bool>, maxHeight: CGFloat, @ViewBuilder content: () -> Content) {
        self._isPresented = isPresented
        self.maxHeight = maxHeight
        self.content = content()
    }
    
    private var offset: CGFloat {
        isPresented ? 0 : maxHeight
    }
    
    var body: some View {
        GeometryReader { geometry in
            if isPresented {
                VStack {
                    Spacer()
                    VStack {
                        content
                    }
                    .frame(width: geometry.size.width, height: min(geometry.size.height, maxHeight))
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(radius: 20)
                    .offset(y: offset + translation)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                translation = value.translation.height
                            }
                            .onEnded { value in
                                if value.translation.height > 100 {
                                    isPresented = false
                                }
                                translation = 0
                            }
                    )
                    .transition(.move(edge: .bottom))
                    .animation(.default)
                }
                .background(
                    Color.black.opacity(0.4)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            isPresented = false
                        }
                )
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}
