//
//  UpdateTreatment.swift
//  kogi-fe
//
//  Created by Jonathan Axel Benaya on 26/05/24.
//

import Foundation


struct UpdateTreatment: Codable {
    var treatmentID: String
    var coassID: String?
    var problemCategory: String
    var status: String
    var date: String
}
