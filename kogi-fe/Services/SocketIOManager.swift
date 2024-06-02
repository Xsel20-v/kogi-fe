import Foundation
import SocketIO

class SocketIOManager: NSObject, ObservableObject {
    private var manager: SocketManager
    private var socket: SocketIOClient
    
    //    @Published var receivedMessage: String = ""
    
    override init() {
        // Update this URL to match your server configuration
        let serverURL = URL(string: "https://kogi-ws.onrender.com")!
        self.manager = SocketManager(socketURL: serverURL, config: [.log(true), .compress, .connectParams(["userID": "azel"])])
        self.socket = manager.defaultSocket
        
        super.init()
        
        configureSocketEvents()
    }
    
    func configureSocketEvents() {
        socket.on(clientEvent: .connect) {data, ack in
            print("Socket connected")
        }
        
        socket.on(clientEvent: .disconnect) {data, ack in
            print("Socket disconnected")
        }
        
        socket.on(clientEvent: .error) {data, ack in
            if let error = data.first as? String {
                print("Socket error: \(error)")
            }
        }
        
        socket.on("chat") { data, ack in
            if let message = data.first as? [String: Any] {
                if let reciever = message["destination"] as? String, let msg = message["message"] as? String {
                    print("Received message from \(reciever): \(msg)")
                }
            }
        }
        
        socket.on("getChatroom") { data, ack in
            if let chatRoom = data.first as? [String: Any] {
                if let reciever = chatRoom["roomID"] as? String,
                   let patientID = chatRoom["patientID"] as? String,
                   let coassID = chatRoom["coassID"] as? String,
                   let lastMessage = chatRoom["lastMessage"] as? String {
                    print("Received chat room data from \(reciever):\n \(patientID), \(coassID), \(lastMessage)")
                }
            }
        }
        
//        socket.on("getChatroom") { data, ack in
//            print("Received chat room data: \(data)")
//        }
        
        socket.on("getChatHistory") { data, ack in
            if let chatHistory = data.first as? [String: Any] {
                if let messageID = chatHistory["messageID"] as? String,
                   let senderID = chatHistory["senderID"] as? String,
                   let roomID = chatHistory["roomID"] as? String,
                   let timeStamp = chatHistory["timeStamp"] as? String,
                   let body = chatHistory["body"] as? String {
                    print("Received chat history:\nMessage ID: \(messageID)\nSender ID: \(senderID)\nRoom ID: \(roomID)\nTimestamp: \(timeStamp)\nBody: \(body)")
                }
            }
        }
    }
    
    
    func connect() {
        print("Attempting to connect to socket...")
        socket.connect()
    }
    
    func disconnect() {
        print("Attempting to disconnect from socket...")
        socket.disconnect()
    }
    
    func sendMessage(_ destination: String, _ message: String) {
        let data: [String: Any] = [
            "destination": destination,
            "message": message
        ]
        socket.emit("chat", data)
    }
    
    func emitChatRoom(_ userID: String) {
        socket.emit("getChatroom", userID)
    }
    
    func emitChatHistory(_ userID: String) {
        socket.emit("getChatHistory", userID)
    }

}

// You can extend functionality here as needed
extension SocketIOManager {
    func joinRoom(_ room: String) {
        socket.emit("join", room)
    }
    
    func leaveRoom(_ room: String) {
        socket.emit("leave", room)
    }
}
