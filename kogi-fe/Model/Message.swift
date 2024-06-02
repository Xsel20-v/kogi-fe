//
//  Message.swift
//  kogi-fe
//
//  Created by Jonathan Axel Benaya on 28/05/24.
//

import Foundation

struct Message: Codable, Identifiable {
    let id: String
    let type: String
    let roomID: String
    let sender: String
    let timestamp: String
    let message: [String]
}
