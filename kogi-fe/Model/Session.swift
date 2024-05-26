//
//  Session.swift
//  kogi-fe
//
//  Created by Azella Mutyara on 21/05/24.
//

import Foundation

struct Session: Codable {
    var sessionID : String
    var sessionTitle : String
    var treatmentID : String
    var dateOfSession : Date
    var reportText : String
    var imageBeforeID:  [String]
    var imageAfterID : [String]
}
