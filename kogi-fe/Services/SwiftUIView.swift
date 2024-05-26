//
//  SwiftUIView.swift
//  kogi-fe
//
//  Created by Azella Mutyara on 24/05/24.
//

//import SwiftUI

//struct SwiftUIView: View {
//    @StateObject private var webSocketManager = WebSocketManager()
//    @State private var messageToSend = ""
//    @State private var chatMessages: [ChatMessage] = []
//    @State private var testing = ""
//    
//    var body: some View {
//        VStack {
//            Text("Received Messages:")
//            
//            List(chatMessages) { message in
//                Text(message.body)
//            }
//            .padding()
//            
//            
//            TextField("Message to send", text: $messageToSend)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding()
//            
//            HStack {
//                Button("Connect") {
//                    webSocketManager.connect()
//                }
//                .padding()
//                
//                Button("Send") {
//                    let message = "[\"azella\",\"testttt\"]"
//                    webSocketManager.sendMessage(message)
//                }
//                .padding()
//                
//                Button("Disconnect") {
//                    webSocketManager.disconnect()
//                }
//                .padding()
//            }
//        }
//        .padding()
//        .onReceive(webSocketManager.$receivedMessage) { receivedMessage in
//            
//            if let data = receivedMessage.data(using: .utf8),
//               let jsonArray = try? JSONSerialization.jsonObject(with: data, options: []) as? [String] {
//                
//                guard jsonArray.count >= 2 else {
//                    print("Received message format is invalid")
//                    return
//                }
//                
//                let id = jsonArray[0]
//                let body = jsonArray[1]
//                
//                let chatMessage = ChatMessage(id: id, body: body)
//                chatMessages.append(chatMessage)
//                print("\(chatMessages)")
//            } else {
//                print("Received message format is invalid")
//            }
//        }
//    }
//}

import SwiftUI
import Combine

struct SwiftUIView: View {
    @StateObject private var socketIOManager = SocketIOManager()
    @State private var messageToSend = ""
    @State private var chatMessages: [ChatMessage] = []
    
    var body: some View {
        VStack {
            Text("Received Messages:")
            
            List(chatMessages) { message in
//                Text(message.body)
            }
            .padding()
            
            TextField("Message to send", text: $messageToSend)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            HStack {
                Button("Connect") {
                    socketIOManager.connect()
                }
                .padding()
                
                Button("Send") {
                    let message = "[\"azella\",\"testttt\"]"
                    socketIOManager.sendMessage("azel", message)
                }
                .padding()
                
                Button("Disconnect") {
                    socketIOManager.disconnect()
                }
                .padding()
            }
        }
        .padding()
//        .onReceive(socketIOManager.$receivedMessage) { receivedMessage in
//            
//            if let data = receivedMessage.data(using: .utf8){
////               let jsonArray = try? JSONSerialization.jsonObject(with: data, options: []) as? [String] {
//                
////                guard jsonArray.count >= 2 else {
////                    print("Received message format is invalid")
////                    return
////                }
//                
////                let id = jsonArray[0]
////                let body = jsonArray[1]
////                
////                let chatMessage = ChatMessage(id: id, body: body)
////                chatMessages.append(chatMessage)
//                print("\(data)")
//            } else {
//                print("Received message format is invalid")
//            }
//        }
    }
}

#Preview {
    SwiftUIView()
}


