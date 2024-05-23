//
//  Pesan.swift
//  kogi-fe
//
//  Created by Jonathan Axel Benaya on 07/05/24.
//

import SwiftUI

struct Pesan: View {
    @Binding var path : NavigationPath
    @Binding var tabSelection: Int
    
    var body: some View {
        ZStack {
            Color("primaryColor")
                    .ignoresSafeArea()
            VStack(alignment: .leading) {
                
                Text("Pesan")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                
                List {
                    Button {
                        path.append("Chat Room")
                    } label: {
                        MessageView(
                            imageName: "person.crop.circle.fill",
                            name: "Jonathan",
                            message: "Ya, saya tertarik. Gigi saya sangat sakit 😢",
                            time: "08.13"
                        )
                    }
                    Button {
                        path.append("Chat Room")
                    } label: {
                        MessageView(
                            imageName: "person.crop.circle.fill",
                            name: "Jonathan",
                            message: "Ya, saya tertarik. Gigi saya sangat sakit 😢",
                            time: "08.13"
                        )
                    }
                }
            }
        }
    }
}

struct MessageView: View {
    let imageName: String
    let name: String
    let message: String
    let time: String
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                .foregroundColor(.black)
            
            VStack(alignment: .leading) {
                HStack {
                    Text(name)
                        .font(.headline)
                        .foregroundColor(.black)
                    Spacer()
                    Text(time)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                HStack{
                    Text(message)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    Pesan(path: .constant(NavigationPath()), tabSelection: .constant(1))
}
