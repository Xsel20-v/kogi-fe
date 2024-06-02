//
//  ChatRoomView.swift
//  kogi-fe
//
//  Created by Azella Mutyara on 23/05/24.
//

import SwiftUI

struct ChatRoomView: View {
    @Binding var path: NavigationPath
    @Binding var tabSelection: Int
    @StateObject var treatmentViewModel = TreatmentViewModel()
    @ObservedObject var socketIOManager = SocketIOManager()
    var lastDateShown: String = ""
    
    @State private var messages: [Message] = [] // Define a model for Message if you haven't already
    
    var body: some View {
        ZStack {
            VStack {
                ScrollView {
                    VStack {
                        
                        ForEach(socketIOManager.getChatHistory(), id: \.id) { history in
                            
                            let dayShown = getFormattedDate(from: history.timestamp)
                            if dayShown != lastDateShown {
//                                Text(dayShown)
//                                    .font(.headline)
//                                    .padding(.top)
//                                lastDateShown = dayShown
                            }
                            
                            MessageCell(type: history.type, message: history.message, timeStamp: history.timestamp, isMyMessage: history.senderID != "C1")
                        }
                        
                    }
                }
                
                //                Spacer()
                
                ZStack {
                    ChatBar()
                }
                
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
    
    func getFormattedDate(from timestamp: String) -> String {
        guard let messageDate = ISO8601DateFormatter().date(from: timestamp) else {
            return timestamp
        }
        
        let currentDate = Date()
        let calendar = Calendar.current
        
        if calendar.isDate(messageDate, inSameDayAs: currentDate) {
            return "Today"
        } else if calendar.isDate(messageDate, inSameDayAs: calendar.date(byAdding: .day, value: -1, to: currentDate)!) {
            return "Yesterday"
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM"
            return dateFormatter.string(from: messageDate)
        }
    }
}

#Preview {
    ChatRoomView(path: .constant(NavigationPath()), tabSelection: .constant(1))
}
