//
//  ChatRoomView.swift
//  kogi-fe
//
//  Created by Azella Mutyara on 23/05/24.
//

import SwiftUI
import Combine

struct ChatRoomView: View {
    @Binding var path: NavigationPath
    @Binding var tabSelection: Int
    @StateObject var treatmentViewModel = TreatmentViewModel()
    @ObservedObject var socketIOManager = SocketIOManager()
    @ObservedObject var chatRoomViewModel = ChatRoomViewModel()
    //    var lastDateShown: String = ""
    @State private var currentRoomID: String = "R1"
    
    @State private var shouldScrollToBottom: Bool = true
    
    @State private var messages: [Message] = [] // Define a model for Message if you haven't already
    
    var body: some View {
        ZStack {
            
            Rectangle()
                .frame(height: 40)
                .foregroundColor(Color("primaryColor"))
                .offset(y: 395)
            
            VStack {
                Spacer()
                
                ScrollViewReader { scrollViewProxy in
                    ScrollView {
                        
                        ForEach(socketIOManager.getChatHistory(), id: \.id) { history in
                            
//                            if chatRoomViewModel.shouldShowDateHeader(history.timestamp) {
//                                Text(chatRoomViewModel.getFormattedDate(history.timestamp))
//                                    .foregroundColor(.gray)
//                                    .padding(.vertical, 5)
//                            }
                            
                            MessageCell(type: history.type, message: history.message[0], timeStamp: history.timestamp, isMyMessage: history.senderID != "C1")
                        }
                        
                    }
                    .onChange(of: socketIOManager.chatHistory) { _ in
                        shouldScrollToBottom = true
                        DispatchQueue.main.async {
                            scrollToBottom(scrollViewProxy)
                        }
                    }
                }
                .frame(height: 650)
                .offset(y: 20)
                
                ChatBar(socketIOManager: socketIOManager)
            }
        }
        .onAppear {
            socketIOManager.connect()
        }
        .onChange(of: socketIOManager.isConnected) { isConnected in
            if isConnected {
                socketIOManager.emitChatHistory("R1")
            }
        }
    }
    
    func scrollToBottom(_ scrollViewProxy: ScrollViewProxy) {
        withAnimation {
            if let lastMessageID = socketIOManager.chatHistory.last?.id {
                scrollViewProxy.scrollTo(lastMessageID, anchor: .bottom)
            }
        }
    }
    
    //    func getFormattedDate(_ timestamp: String) -> String? {
    //        let dateFormatter = DateFormatter()
    //        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    //
    //        guard let messageDate = dateFormatter.date(from: timestamp) else {
    //            return nil // Return nil if parsing fails
    //        }
    //
    //        let currentDate = Date()
    //        let calendar = Calendar.current
    //
    //        if calendar.isDate(messageDate, inSameDayAs: currentDate) {
    //            return "Today"
    //        } else if calendar.isDate(messageDate, inSameDayAs: calendar.date(byAdding: .day, value: -1, to: currentDate)!) {
    //            return "Yesterday"
    //        } else {
    //            let displayFormatter = DateFormatter()
    //            displayFormatter.dateFormat = "dd MMM YY"
    //            return displayFormatter.string(from: messageDate)
    //        }
    //    }
    
    
}

#Preview {
    ChatRoomView(path: .constant(NavigationPath()), tabSelection: .constant(1))
}
