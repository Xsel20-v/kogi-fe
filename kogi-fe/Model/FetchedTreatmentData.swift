//
//  fetchedTreatmentData.swift
//  kogi-fe
//
//  Created by Jonathan Axel Benaya on 20/06/24.
//

import Foundation

struct FetchedTreatmentData: Codable {
    var treatmentID: String?
    var patientID: String
    var coassID: String?
    var problemCategory: String
    var areaOfSymptom: [String]?
    var symptomsDesc: String
    var totalDaysOfSymptom: Int
    var dateCreated: String
    var requestedDate: String
    var treatmentStatus: String
    var images: [String]
    var patientName: String?
    var patientProfilePicture: String?
    var coassName: String?
    var coassProfilePicture: String?
}
