//
//  Patient.swift
//  kogi-fe
//
//  Created by Azella Mutyara on 25/05/24.
//

import Foundation

struct Patient: Codable {
    var patientID: String
    var name: String
    var dateOfBirth: String
    var email: String
    var password: String
    var profilePicture: String?
}
