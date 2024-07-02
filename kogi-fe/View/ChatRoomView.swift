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
    @ObservedObject var treatmentViewModel : TreatmentViewModel
    @State private var fetchedTreatment: FetchedTreatmentData? = nil
    @ObservedObject var socketIOManager : SocketIOManager
    
    @State var historyTimestamps: [String] = []
    
    @State private var shouldScrollToBottom: Bool = true
    @State private var keyboardHeight: CGFloat = 0
    @State var isTreatmentSheetPresented : Bool = false
    
    @State var index = 0
    
    @AppStorage("userID") var userID = "C7"
    
    var body: some View {
        ZStack {
            VStack {
                // Header
                ChatRoomHeader(name: socketIOManager.currentChatRoom.receiver, imageBase64: socketIOManager.currentChatRoom.profilePicture)
                    .padding(.top, -90)
                
                ScrollViewReader { scrollViewProxy in
                    ScrollView {
                        ForEach(socketIOManager.getChatHistory().indices, id: \.self) { index in
                            let history = socketIOManager.getChatHistory()[index]
                            
                            VStack {
                                if !history.timestamp.isEmpty && index < historyTimestamps.count {
                                    Text(historyTimestamps[index])
                                        .foregroundColor(.gray)
                                }
                                if history.type == "treatment" {
                                    ContainerKonfirmasiPerawatan(treatmentViewModel: treatmentViewModel, message: history)
                                        .padding(.bottom, 20)
                                } else {
                                    MessageCell(type: history.type, message: history.message[0], timeStamp: history.timestamp, isMyMessage: history.senderID != userID)
                                }
                            }
                        }
                    }
                    .onChange(of: socketIOManager.chatHistory) { _ in
                        
                        updateHistoryTimestamps()
                        shouldScrollToBottom = true
                        DispatchQueue.main.async {
                            scrollToBottom(scrollViewProxy)
                        }
                    }
                    .onChange(of: keyboardHeight) { _ in
                        shouldScrollToBottom = true
                        DispatchQueue.main.async {
                            scrollToBottom(scrollViewProxy)
                        }
                    }
                    .onAppear {
                        DispatchQueue.main.async {
                            scrollToBottom(scrollViewProxy)
                        }
                    }
                    .onTapGesture {
                        hideKeyboard()
                    }
                }
                .frame(height: 595 - keyboardHeight)
                .background(Color.clear)
                .onReceive(Publishers.keyboardHeight) { keyboardHeight in
                    self.keyboardHeight = keyboardHeight - 27
                }
                .padding(.vertical, -5)
                
                ChatBar(isTreatmentSheetPresented: $isTreatmentSheetPresented, fetchedTreatment: $fetchedTreatment, socketIOManager: socketIOManager)
                    .background(Color("PrimaryColor"))
                
            }
            
            BottomSheetView(isPresented: $isTreatmentSheetPresented, maxHeight: 250) {
                SheetKonfirmasiPerawatan(treatmentViewModel: treatmentViewModel, tanggal: convertToDate(fetchedTreatment?.requestedDate ?? "2024-06-04T21:39:50") ?? Date(), problemCategory: fetchedTreatment?.problemCategory ?? "", selectedOption: fetchedTreatment?.problemCategory ?? "", isTreatmentSheetPresented: $isTreatmentSheetPresented, socketIOManager: socketIOManager)
                    .transition(.move(edge: .bottom))
                    .zIndex(1)
            }
            
        }
        .onAppear {
            socketIOManager.emitChatHistory(socketIOManager.currentChatRoom.roomID)
            socketIOManager.connect()
            fetchTreatmentData()
            updateHistoryTimestamps()
        }
        .onChange(of: socketIOManager.isConnected) { isConnected in
            if isConnected {
                socketIOManager.emitChatHistory(socketIOManager.currentChatRoom.roomID)
            }
        }
        .animation(.default, value: isTreatmentSheetPresented)
    }
    
    func scrollToBottom(_ scrollViewProxy: ScrollViewProxy) {
           withAnimation {
               if shouldScrollToBottom {
                   scrollViewProxy.scrollTo(socketIOManager.getChatHistory().count - 1, anchor: .bottom)
                   shouldScrollToBottom = false
               }
           }
       }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func fetchTreatmentData() {
        Task {
            if await treatmentViewModel.getTreatmentDataByStatus(userID: socketIOManager.currentChatRoom.patientID, status: "pending", isSingle: true) {
                self.fetchedTreatment = treatmentViewModel.fetchedTreatmentData
                print(fetchedTreatment)
            } else {
                print("Cannot get treatment data in chat room")
            }
        }
    }
    
    func convertToDate(_ dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return dateFormatter.date(from: dateString)
    }
    
    func getFormattedDate(_ timestamp: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        guard let messageDate = dateFormatter.date(from: timestamp) else {
            return nil // Return nil if parsing fails
        }
        
        let currentDate = Date()
        let calendar = Calendar.current
        
        if calendar.isDate(messageDate, inSameDayAs: currentDate) {
            return "Today"
        } else if calendar.isDate(messageDate, inSameDayAs: calendar.date(byAdding: .day, value: -1, to: currentDate)!) {
            return "Yesterday"
        } else {
            let displayFormatter = DateFormatter()
            displayFormatter.dateFormat = "dd MMM YY"
            return displayFormatter.string(from: messageDate)
        }
    }
    
    
    func updateHistoryTimestamps() {
        guard !socketIOManager.chatHistory.isEmpty else {
            print("Chat history is empty.")
            return
        }
        
        historyTimestamps = socketIOManager.chatHistory.map { $0.timestamp }
        print("Original historyTimestamps: \(historyTimestamps)")
        
        var modifiedTimestamps: [String] = []
        var lastDate: Date? = nil
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        for time in historyTimestamps {
            guard let currentDate = dateFormatter.date(from: time) else {
                modifiedTimestamps.append(time)
                continue
            }
            
            if let lastDate = lastDate, Calendar.current.isDate(currentDate, inSameDayAs: lastDate) {
                modifiedTimestamps.append("")
            } else {
                modifiedTimestamps.append(getFormattedDate(time)!)
                lastDate = currentDate
            }
        }
        
        historyTimestamps = modifiedTimestamps
        print("Updated historyTimestamps: \(historyTimestamps)")
    }
    
    
}

extension Publishers {
    static var keyboardHeight: AnyPublisher<CGFloat, Never> {
        let willShow = NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)
            .map { notification -> CGFloat in
                (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
            }
        
        let willHide = NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)
            .map { _ -> CGFloat in 0 }
        
        return MergeMany(willShow, willHide)
            .eraseToAnyPublisher()
    }
}

#Preview {
    ChatRoomView(path: .constant(NavigationPath()), tabSelection: .constant(1), treatmentViewModel: TreatmentViewModel(), socketIOManager: SocketIOManager())
}
