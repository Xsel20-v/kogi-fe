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
    
    var body: some View {
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
                    self.sendMessage()
                }) {
                    Image(systemName: "paperplane.fill")
                        .font(.title)
                        .foregroundColor(Constant.Colors.baseColor)
                }
            }
        }
        .frame(minHeight: 94)
        .background {
            Color(Constant.Colors.primaryColor)
        }
        .alert(isPresented: $showAlert, content: {
            Alert(title: Text("Fitur Belum Tersedia"),
                     message: Text("Maaf, fitur ini masih dalam pengembangan dan akan segera tersedia."),
                     dismissButton: .default(Text("Tutup")) {
                         self.showAlert = false
            })
        })
    }
    
    func sendMessage() {
        // kasih ke view model untuk send message
    
        // seudah dikirim oleh view model, kosongin textfieldnya
        messageText = ""
    }
}


#Preview {
    ChatBar()
}
