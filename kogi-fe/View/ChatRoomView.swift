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
    @State private var fetchedTreatment: Treatment?
    @ObservedObject var socketIOManager : SocketIOManager
//        @ObservedObject var chatRoomViewModel = ChatRoomViewModel()
    //    var lastDateShown: String = ""
    @State private var currentRoomID: String = "R1"
    
    @State private var shouldScrollToBottom: Bool = true
    @State private var keyboardHeight: CGFloat = 0
    @State var isTreatmentSheetPresented : Bool = false
    
    
    var body: some View {
        ZStack {
            VStack {
                // Header
                ChatRoomHeader(name: socketIOManager.currentChatRoom.receiver, imageBase64: socketIOManager.currentChatRoom.profilePicture)
                    .padding(.top, -100)
                //                .offset(y: -100)
                
                // ScrollView in the middle
                ScrollViewReader { scrollViewProxy in
                    ScrollView {
                        ForEach(socketIOManager.getChatHistory(), id: \.id) { history in
                            
//                             if chatRoomViewModel.shouldShowDateHeader(history.timestamp) {
//                                 Text(chatRoomViewModel.getFormattedDate(history.timestamp))
//                                     .foregroundColor(.gray)
//                                     .padding(.vertical, 5)
//                             } JANGAN DI UNCOMMENT INFINITE LOOP
                            if history.type == "treatment" {
                                ContainerKonfirmasiPerawatan(treatmentViewModel: treatmentViewModel, message: history, isAccepted: false)
                                    .padding(.bottom, 20)
                            } else {
                                MessageCell(type: history.type, message: history.message[0], timeStamp: history.timestamp, isMyMessage: history.senderID != "C1")
                            }
                        }
                    }
                    .onChange(of: socketIOManager.chatHistory) { _ in
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
                    .onTapGesture {
                        hideKeyboard()
                    }
                }
                .frame(height: 595 - keyboardHeight)
                .background(Color.clear)
                .onReceive(Publishers.keyboardHeight) { keyboardHeight in
                    // Update keyboard height
                    self.keyboardHeight = keyboardHeight - 27
                }
                .padding(.vertical, -5)
                
                ChatBar(isTreatmentSheetPresented: $isTreatmentSheetPresented, socketIOManager: socketIOManager)
                    .background(Color("PrimaryColor"))
                
            }
            
            BottomSheetView(isPresented: $isTreatmentSheetPresented, maxHeight: 250){
                SheetKonfirmasiPerawatan(tanggal: convertToDate(fetchedTreatment?.requestedDate ?? "2024-06-04T21:39:50") ?? Date(), problemCategory: fetchedTreatment?.problemCategory ?? "", selectedOption: fetchedTreatment?.problemCategory ?? "", isTreatmentSheetPresented: $isTreatmentSheetPresented, socketIOManager: socketIOManager, fetchedTreatment: $fetchedTreatment)
                    .transition(.move(edge: .bottom))
                    .zIndex(1)
            }
            
        }
        .onAppear {
            socketIOManager.emitChatHistory(socketIOManager.currentChatRoom.roomID)
            socketIOManager.connect()
            
//            fetchTreatmentData()
        }
        .onChange(of: socketIOManager.isConnected) { isConnected in
            if isConnected {
                socketIOManager.emitChatHistory("R1")
            }
        }
        .animation(.default, value: isTreatmentSheetPresented)
    }
    
    func scrollToBottom(_ scrollViewProxy: ScrollViewProxy) {
        withAnimation {
            if let lastMessageID = socketIOManager.chatHistory.last?.id {
                scrollViewProxy.scrollTo(lastMessageID, anchor: .bottom)
            }
        }
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
//    func fetchTreatmentData() {
//        Task {
//            if await treatmentViewModel.getTreatmentDataByStatus(userID: "P4", status: "pending") {
//                self.fetchedTreatment = treatmentViewModel.fetchedTreatmentData
//                print(fetchedTreatment)
//            } else {
//                print("Cannot get treatment data in chat room")
//            }
//        }
//    }
    
    func convertToDate(_ dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return dateFormatter.date(from: dateString)
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
