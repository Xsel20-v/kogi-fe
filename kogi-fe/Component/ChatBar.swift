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
    @Binding var isTreatmentSheetPresented: Bool
    @Binding var fetchedTreatment: FetchedTreatmentData?
    @State var showTreatmentAlert: Bool = false
    
    @ObservedObject var socketIOManager : SocketIOManager
    
    @AppStorage("isPatient") var isPatient = false
    @AppStorage("userID") var userID = "C1"
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                HStack {
                    TextField("Ketik pesan...", text: $messageText)
                        .padding(8)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal, 8)
                    
                    if !isPatient {
                        Button(action: {
                            if(fetchedTreatment?.problemCategory == nil){
                                showTreatmentAlert = true
                            } else {
                                isTreatmentSheetPresented = true
                            }
                        }) {
                            Image(systemName: "heart.text.square.fill")
                                .font(.title)
                                .foregroundColor(Constant.Colors.baseColor)
                        }
                    }
                    
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
                            sendMessage()
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
        .alert(isPresented: $showTreatmentAlert) {
            Alert(
                title: Text("Tidak ada permintaan perawatan"),
                message: Text(""),
                dismissButton: .cancel(Text("Ok")) {
                    showTreatmentAlert = false
                }
            )
        }

        //        .animation(.default, value: isTreatmentSheetPresented)
    }
    
    func sendMessage() {
        guard !messageText.isEmpty else { return }
        socketIOManager.sendMessage("text", socketIOManager.currentChatRoom.roomID, [messageText])
        messageText = ""
    }
    
    func getCurrentTimestamp() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return dateFormatter.string(from: Date())
    }
}

#Preview {
    ChatBar(isTreatmentSheetPresented: .constant(false), fetchedTreatment: .constant(nil), socketIOManager: SocketIOManager())
}

