//
//  LoginInfo.swift
//  kogi-fe
//
//  Created by Jonathan Axel Benaya on 28/05/24.
//

import Foundation


struct LoginInfo: Codable {
    let email: String
    let password: String
    let isPatient: Bool
}
