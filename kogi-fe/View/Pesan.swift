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
    
//    @StateObject var chatViewModel = ChatViewModel()
    @ObservedObject var socketIOManager : SocketIOManager
    @State private var isConnected = false
    
    @AppStorage("userID") var userID = "C1"
    
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
                
                List(socketIOManager.chatRoomList) { room in
                    Button {
                        socketIOManager.currentChatRoom = ChatRoom(roomID: room.roomID, patientID: room.patientID, cosssID: room.cosssID, lastMessage: room.lastMessage, receiver: room.receiver, lastTimestamp: room.lastTimestamp, profilePicture: room.profilePicture)
                        print(socketIOManager.currentChatRoom)
                        path.append("Chat Room")
                    } label: {
                        MessageView(
                            imageName: room.profilePicture,
                            name: room.receiver,
                            message: room.lastMessage,
                            time: room.lastTimestamp
                        )
                    }
                }
            }
        }
        .onAppear {
            socketIOManager.connect()
        }
        .onChange(of: socketIOManager.isConnected) {
            socketIOManager.emitChatRoom(userID)
//                    chatViewModel.loadChatRooms(userID: "P1")
        }
    }
}

struct MessageView: View {
    var imageName: String
    let name: String
    let message: String
    let time: String
    
    private var image: Image {
        if let dataImage = Data(base64Encoded: imageName) {
            if let uiImage = UIImage(data: dataImage) {
                return Image(uiImage: uiImage)
            }
        }
        return Image(systemName: "person.circle")
    }
    
    var body: some View {
        HStack {
            
            if imageName == "null" {
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                    .foregroundColor(.gray)
            } else {
                image
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                    .foregroundColor(.gray)
            }
            
            VStack(alignment: .leading) {
                HStack {
                    Text(name)
                        .font(.headline)
                        .foregroundColor(.black)
                        .lineLimit(1)
                        .truncationMode(.tail)
                    Spacer()
                    Text(time)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                HStack{
                    Text(message)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .lineLimit(1)
                        .truncationMode(.tail)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
            }
            .padding(.leading, 7)
        }
        .padding(.vertical, 8)
        
    }
}

#Preview {
    Pesan(path: .constant(NavigationPath()), tabSelection: .constant(1), socketIOManager: SocketIOManager())
}
