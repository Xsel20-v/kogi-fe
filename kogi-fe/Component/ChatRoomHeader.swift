//
//  ChatRoomHeader.swift
//  kogi-fe
//
//  Created by Jonathan Axel Benaya on 02/06/24.
//

import SwiftUI

struct ChatRoomHeader: View {
    
    @Binding var name: String
    @Binding var imageBase64: String
    
    private var image: Image {
        if let dataImage = Data(base64Encoded: imageBase64) {
            if let uiImage = UIImage(data: dataImage) {
                return Image(uiImage: uiImage)
            }
        }
        return Image(systemName: "person.circle")
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Rectangle()
                    .frame(width: geometry.size.width, height: 150)
                    .foregroundColor(Constant.Colors.primaryColor)
                VStack () {
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50)
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        .padding(.bottom, 10)
                    Text(name)
                        .foregroundStyle(.white)
                }
                .offset(y: 25)
            }
        }
    }
}

#Preview {
    ChatRoomHeader(name: .constant("Reisan"), imageBase64: .constant("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"))
}