//import Foundation
//import SocketIO
//
//class SocketHelper {
//    static let shared = SocketHelper()
//    private var manager: SocketManager
//    private var socket: SocketIOClient
//
//    private init() {
//        guard let url = URL(string: "wss://kogi-api.onrender.com/") else {
//            fatalError("Invalid URL")
//        }
//        manager = SocketManager(socketURL: url, config: [.log(true), .compress])
//        socket = manager.defaultSocket
//    }
//
//    func establishConnection() {
//        socket.connect()
//    }
//
//    func closeConnection() {
//        socket.disconnect()
//    }
//
//    func sendMessage(message: ChatMessage) {
//        let messageData: [String: Any] = [
//            "body": message.body
////            "sender": message.sender,
////            "timestamp": message.timestamp
//        ]
//        socket.emit("message", messageData)
//    }
//
//    func receiveMessage(completion: @escaping (ChatMessage) -> Void) {
//        socket.on("message") { (dataArray, ack) in
//            if let data = dataArray[0] as? [String: Any],
//               let body = data["content"] as? String,
//               let sender = data["sender"] as? String,
//               let timestamp = data["timestamp"] as? String {
//                let message = ChatMessage(id: "azel", body: body)
//                completion(message)
//            }
//        }
//    }
//}
