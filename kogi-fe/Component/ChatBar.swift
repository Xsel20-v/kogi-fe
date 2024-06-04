//
//  ChatBar.swift
//  kogi-fe
//
//  Created by Jonathan Axel Benaya on 27/05/24.
//
import SwiftUI

struct ChatBar: View {
    @State private var messageText: String = ""
    @State private var showAlert: Bool = false
    
    @ObservedObject var socketIOManager : SocketIOManager

    var body: some View {
        VStack {
            Spacer()
            HStack {
                TextField("Ketik pesan...", text: $messageText)
                    .padding(8)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal, 8)

                if messageText.isEmpty {
                    Button(action: {
                        print("fitur masih dikembangkan")
                        showAlert.toggle()
                    }) {
                        Image(systemName: "camera.fill")
                            .font(.title)
                            .foregroundColor(Constant.Colors.baseColor)
                    }

                    Button(action: {
                        print("fitur masih dikembangkan")
                        showAlert.toggle()
                    }) {
                        Image(systemName: "photo.on.rectangle.fill")
                            .font(.title)
                            .foregroundColor(Constant.Colors.baseColor)
                    }
                } else {
                    Button(action: {
                        let timestamp = getCurrentTimestamp()
                        socketIOManager.sendMessage("text", "R1", [messageText])
                        let newMessage = ChatHistory(messageID: "", type: "text", roomID: "R1", senderID: "C1", timestamp: timestamp, message: [messageText])
                        socketIOManager.chatHistory.append(newMessage)
                        messageText = ""
                    }) {
                        Image(systemName: "paperplane.fill")
                            .font(.title)
                            .foregroundColor(Constant.Colors.baseColor)
                    }
                }
            }
            .frame(minHeight: 74)
            .background(Color(Constant.Colors.primaryColor))
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Fitur Belum Tersedia"),
                      message: Text("Maaf, fitur ini masih dalam pengembangan dan akan segera tersedia."),
                      dismissButton: .default(Text("Tutup")) {
                          self.showAlert = false
                      })
            }
        }
        .animation(.easeOut(duration: 0.16))
    }

    func getCurrentTimestamp() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return dateFormatter.string(from: Date())
    }
}

#Preview {
    ChatBar(socketIOManager: SocketIOManager())
}

