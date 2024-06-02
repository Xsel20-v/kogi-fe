//
//  ChatMessage.swift
//  kogi-fe
//
//  Created by Jonathan Axel Benaya on 23/05/24.
//

import Foundation

struct Message: Identifiable {
    let id = UUID()
    let messageID: String
    let type: String
    let roomID: String
    let senderID: String
    let timestamp: String
    let message: [String]
}

struct ChatHistory: Identifiable {
    let id = UUID()
    let messageID: String
    let type: String
    let roomID: String
    let senderID: String
    let timestamp: String
    let message: String
}

struct ChatRoom: Identifiable {
    let id = UUID()
    let roomID: String
    let patientID: String
    let cosssID: String
    let lastMessage: String
    let receiver: String
    let lastTimestamp: String
    let profilePicture: String
}
    
