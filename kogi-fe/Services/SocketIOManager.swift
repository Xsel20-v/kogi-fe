import Foundation
import SocketIO

class SocketIOManager: NSObject, ObservableObject {
    private var manager: SocketManager
    private var socket: SocketIOClient
    
    //        @Published var receivedMessage: String = ""
    @Published var chatRoomList: [ChatRoom] = []
    @Published var chatHistory: [ChatHistory] = []
    @Published var isConnected: Bool = false
    
    override init() {
        let serverURL = URL(string: "https://kogi-ws.onrender.com")!
        self.manager = SocketManager(socketURL: serverURL, config: [.log(true), .compress, .connectParams(["userID": "azel"])])
        self.socket = manager.defaultSocket
        
        super.init()
        
        configureSocketEvents()
    }
    
    func configureSocketEvents() {
        socket.on(clientEvent: .connect) {data, ack in
            print("Socket connected")
            self.isConnected = true
        }
        
        socket.on(clientEvent: .disconnect) {data, ack in
            print("Socket disconnected")
            self.isConnected = false
        }
        
        socket.on(clientEvent: .error) {data, ack in
            if let error = data.first as? String {
                print("Socket error: \(error)")
            }
        }
        
        socket.on("chat") { data, ack in
            if let message = data.first as? [String: Any] {
                if let messageID = message["messageID"] as? String,
                   let type = message["type"] as? String,
                   let roomID = message["roomID"] as? String,
                   let senderID = message["senderID"] as? String,
                   let timestamp = message["timestamp"] as? String,
                   let messageBody = message["body"] as? [String] {
                    let receivedMessage = Message(messageID: messageID, type: type, roomID: roomID, senderID: senderID, timestamp: timestamp, message: messageBody)
                }
            }
        }
        
        socket.on("getChatroom") { data, ack in
            if let chatRoomArray = data.first as? [[String: Any]] {
                var parsedMessages: [ChatRoom] = []
                
                for chatRoom in chatRoomArray {
                    if let roomID = chatRoom["roomID"] as? String,
                       let patientID = chatRoom["patientID"] as? String,
                       let coassID = chatRoom["coassID"] as? String,
                       let lastMessage = chatRoom["lastMessage"] as? String,
                       let receiver = chatRoom["receiver"] as? String,
                       let lastTimestamp = chatRoom["lastTimestamp"] as? String? ?? "null",
                       let profilePicture = chatRoom["profilePicture"] as? String? ?? "null" {
                        
                        let chatRooms = ChatRoom(roomID: roomID, patientID: patientID, cosssID: coassID, lastMessage: lastMessage, receiver: receiver, lastTimestamp: lastTimestamp, profilePicture: profilePicture)
                        parsedMessages.append(chatRooms)
                    }
                }
                self.chatRoomList = parsedMessages
                print(parsedMessages)
            }
        }
        
//
//                socket.on("getChatroom") { data, ack in
//                    print("Received chat room data: \(data)")
//                }
//        
//                socket.on("getChatHistory") { data, ack in
//                    print("Received chat history data: \(data)")
//                }
        
        socket.on("getChatHistory") { data, ack in
            if let chatHistoryArray = data.first as? [[String: Any]] {
                var parsedMessages: [ChatHistory] = []
                
                for chatHistory in chatHistoryArray {
                    if let messageID = chatHistory["messageID"] as? String,
                       let type = chatHistory["type"] as? String,
                       let roomID = chatHistory["roomID"] as? String,
                       let senderID = chatHistory["senderID"] as? String,
                       let timestamp = chatHistory["timestamp"] as? String,
                       let messageBody = chatHistory["body"] as? String {
                        
                        let message = ChatHistory(messageID: messageID,
                                              type: type,
                                              roomID: roomID,
                                              senderID: senderID,
                                              timestamp: timestamp,
                                              message: messageBody)
                        parsedMessages.append(message)
                    }
                }
                self.chatHistory = parsedMessages
                print(parsedMessages)
            }
        }
        
        
    }
    
    func getChatHistory() -> [ChatHistory]{
        return chatHistory
    }
    
    
    func connect() {
        print("Attempting to connect to socket...")
        socket.connect()
    }
    
    func disconnect() {
        print("Attempting to disconnect from socket...")
        socket.disconnect()
    }
    
    func sendMessage(_ type: String, _ roomID: String, _ message: [String]) {
        let data: [String: Any] = [
            "type": type,
            "roomID": roomID,
            "message": message
        ]
        socket.emit("chat", data)
    }
    
    func emitChatRoom(_ userID: String) {
        socket.emit("getChatroom", userID)
    }
    
    func emitChatHistory(_ roomID: String) {
        socket.emit("getChatHistory", roomID)
    }
    
}

extension SocketIOManager {
    func joinRoom(_ room: String) {
        socket.emit("join", room)
    }
    
    func leaveRoom(_ room: String) {
        socket.emit("leave", room)
    }
}
