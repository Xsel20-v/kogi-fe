//
//  Treatment.swift
//  kogi-fe
//
//  Created by Jonathan Axel Benaya on 09/05/24.
//

import Foundation

struct Treatment: Codable {
    var treatmentID: String
    var patientID: String
    var dentistID: String
    var problemCategory: String
    var symptomsDesc: String
    var totalDaysOfSymptom: Int
    var dateCreated: Date
    var requestedDate: Date
    var requestedHour: Date
    var treatmentStatus: String
    var imageID: String
}
