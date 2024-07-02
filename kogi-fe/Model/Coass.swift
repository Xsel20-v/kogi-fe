//
//  Coass.swift
//  kogi-fe
//
//  Created by Jonathan Axel Benaya on 27/05/24.
//

import Foundation

struct Coass: Codable {
    var coassID: String
    var name: String
    var profilePicture: String?
    var certificate: String
    var email: String
    var password: String
    var isEligible: Bool
}

struct EligibilityResponse: Decodable {
    let isEligible: Bool
}
