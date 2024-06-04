import SwiftUI
import Combine

class ChatViewModel: ObservableObject {
    @Published var chatRoomList: [ChatRoom] = []
    @Published var chatHistory: [ChatHistory] = []
    @Published var isConnected: Bool = false 
    
    
    private var socketManager = SocketIOManager()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        socketManager.$chatRoomList
            .assign(to: \.chatRoomList, on: self)
            .store(in: &cancellables)
        
        socketManager.$chatHistory
            .assign(to: \.chatHistory, on: self)
            .store(in: &cancellables)
        
        socketManager.connect()// Connect to socket when initializing the view model
        
        // Load chat rooms after connection
        loadChatRooms(userID: "P1")
        print("masuk init")
    }
    
    func loadChatRooms(userID: String) {
        if socketManager.isConnected {
            socketManager.emitChatRoom(userID)
        }
    }
    
    func loadChatHistory(roomID: String) {
        if socketManager.isConnected {
            socketManager.emitChatHistory(roomID)
        }
    }
    
    func sendMessage(type: String, roomID: String, message: [String]) {
        socketManager.sendMessage(type, roomID, message)
    }
}
