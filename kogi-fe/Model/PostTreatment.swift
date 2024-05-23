//
//  PostTreatment.swift
//  kogi-fe
//
//  Created by Jonathan Axel Benaya on 21/05/24.
//

import Foundation

struct PostTreatment : Codable {
    var patientID: String
    var problemCategory: String
    var areaOfSymptom: [String]?
    var symptomsDesc: String
    var totalDaysOfSymptom: Int = 0
    var requestedDate: String
    var images: [Data]
}
