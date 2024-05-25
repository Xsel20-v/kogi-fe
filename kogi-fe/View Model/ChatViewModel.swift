////
////  ChatViewModel.swift
////  kogi-fe
////
////  Created by Jonathan Axel Benaya on 23/05/24.
////
//
//import Foundation
//
//
//class ChatViewModel: ObservableObject {
//    private let socketHelper = SocketHelper.shared
//
//    @Published var messages: [ChatMessage] = []
//
//    func connect() {
//        socketHelper.establishConnection()
//        socketHelper.receiveMessage { [weak self] message in
//            DispatchQueue.main.async {
//                self?.messages.append(message)
//            }
//        }
//    }
//
//    func disconnect() {
//        socketHelper.closeConnection()
//    }
//
//    func sendMessage(body: String, sender: String) {
//        let message = ChatMessage(body: body, sender: sender, timestamp: Date.now.currentDateString())
//        socketHelper.sendMessage(message: message)
//    }
//}
//
