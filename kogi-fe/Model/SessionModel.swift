//
//  SessionModel.swift
//  kogi-fe
//
//  Created by Azella Mutyara on 27/05/24.
//

import Foundation

struct SessionModel: Codable {
    var sessionID: String
    var treatmentID: String
    var dateOfSession: String
    var reportText: String?
    var imageBefore: [String]?
    var imageAfter: [String]?
    var sessionStatus: String?
}
