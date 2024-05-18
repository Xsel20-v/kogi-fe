//
//  Treatment.swift
//  kogi-fe
//
//  Created by Jonathan Axel Benaya on 09/05/24.
//

import Foundation

struct Treatment: Codable {
    var treatmentID: String?
    var patientID: String
    var coassID: String?
    var problemCategory: String
    var areaOfSymptom: [String]
    var symptomsDesc: String
    var totalDaysOfSymptom: Int
    var dateCreated: String
    var requestedDate: String
    var treatmentStatus: String
    var image: Data?
}
