//
//  LoginViewModel.swift
//  kogi-fe
//
//  Created by Jonathan Axel Benaya on 27/05/24.
//

import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {
    
    @AppStorage("userID") var userID = "P2"
    @AppStorage("username") var username = "Axel"
    @AppStorage("isLoggedIn") var isLoggedIn = false
    @AppStorage("dob") var dob = "2002-07-20"
    @AppStorage("email") var email = "1@2.com"
    @AppStorage("password") var password = "123"
    
    @Published var alertMessage = ""
    
    var networkService: NetworkService?
    
    func signUpNewPatient(nama: String, birthDate: String, email: String, password: String) async -> Bool {
        networkService = NetworkService()
        
        let newPatient = NewPatient(name: nama, date: birthDate, email: email, password: password)
        
        do {
            if let patient = try await networkService?.createNewPatient(patient: newPatient) {
                self.userID = patient.patientID
                self.username = patient.name
                self.dob = patient.dateOfBirth
                self.email = patient.email
                self.password = patient.password
                return true
            }
        }catch NError.invalidURL {
            print("invalid URL")
            return false
        }catch NError.invalidResponse {
            print("invalid Response")
            return false
        }catch NError.invalidData {
            print("invalid Data")
            alertMessage = "Email telah terpakai, coba log in"
            return false
        }catch {
            print("unexpected error")
            return false
        }
        
        return false
        
    }
    
}
