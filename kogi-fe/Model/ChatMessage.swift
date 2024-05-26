//
//  ChatMessage.swift
//  kogi-fe
//
//  Created by Jonathan Axel Benaya on 23/05/24.
//

import Foundation

struct ChatMessage: Codable, Identifiable {
    let id = UUID()
    let destination: String
    let message: String
}
