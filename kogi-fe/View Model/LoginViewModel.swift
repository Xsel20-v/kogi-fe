//
//  LoginViewModel.swift
//  kogi-fe
//
//  Created by Jonathan Axel Benaya on 27/05/24.
//

import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {
    
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    
    
    var networkService: NetworkService?
    
    func signUpNewPatient(nama: String, birthDate: String, email: String, password: String) async -> Patient? {
        networkService = NetworkService()
        
        let newPatient = NewPatient(name: nama, date: birthDate, email: email, password: password)
        
        do {
            if let patient = try await networkService?.createNewPatient(patient: newPatient) {
                return patient
            }
        }catch NError.invalidURL {
            print("invalid URL")
            return nil
        }catch NError.emailIsUsed {
            alertTitle = "Sign Up Tidak Berhasil"
            alertMessage = "Email telah terpakai, lakukan log in atau gunakan email lain"
            print("emailIsUsed")
            return nil
        }catch NError.invalidData {
            print("invalid Data")
            return nil
        }catch NError.invalidDecodingData{
            print("invalid Decoding Data")
            return nil
        }catch {
            print("unexpected error")
            return nil
        }
        
        return nil
        
    }
    
    func signUpNewCoass(nama: String, email: String, password: String, certificate: String) async -> Coass? {
        networkService = NetworkService()
        
        let newCoass = NewCoass(name: nama, email: email, password: password, certificate: certificate)
        
        do {
            if let coass = try await networkService?.createNewCoass(coass: newCoass) {
                return coass
            }
        }catch NError.invalidURL {
            print("invalid URL")
            return nil
        }catch NError.emailIsUsed {
            alertTitle = "Sign Up Tidak Berhasil"
            alertMessage = "Email telah terpakai, lakukan log in atau gunakan email lain"
            print("emailIsUsed")
            return nil
        }catch NError.invalidData {
            print("invalid Data")
            return nil
        }catch NError.invalidDecodingData{
            print("invalid Decoding Data")
            return nil
        }catch {
            print("unexpected error")
            return nil
        }
        
        return nil
        
    }
    
    func logInUser<T: Decodable>(email: String, password: String, isPatient: Bool) async -> T? {
        networkService = NetworkService()
        
        let loginInfo = LoginInfo(email: email, password: password, isPatient: isPatient)
        
        do {
            if let user: T = try await networkService?.logIn(loginInfo: loginInfo) {
                return user
            }
        }catch NError.invalidURL {
            print("invalid URL")
            return nil
        }catch NError.emailOrPasswordWrong {
            alertTitle = "Log In Tidak Berhasil"
            alertMessage = "Email atau password salah"
            print("emailOrPasswordWrong")
            return nil
        }catch NError.invalidData {
            print("invalid Data")
            return nil
        }catch NError.invalidDecodingData{
            print("invalid Decoding Data")
            return nil
        }catch {
            print("unexpected error")
            return nil
        }
        return nil
    }
    
    func checkEligibility(coassID: String) async -> Bool {
        networkService = NetworkService()
        
        do {
            if let isEligible = try await networkService?.checkCoassEligibility(coassID: coassID){
                return isEligible
            }
        }catch NError.invalidURL {
            print("invalid URL")
        }catch NError.invalidResponse {
            print("invalid Response")
        }catch NError.invalidData {
            print("invalid Data")
        }catch {
            print("unexpected error")
        }
        return false
    }
    
    func updateCoassData(coass: Coass) async -> Coass? {
        networkService = NetworkService()
        do {
            if let coass = try await networkService?.updateCoassData(coass: coass){
                return coass
            }
        }catch NError.invalidURL {
            print("invalid URL")
        }catch NError.invalidResponse {
            print("invalid Response")
        }catch NError.invalidData {
            print("invalid Data")
        }catch {
            print("unexpected error")
        }
        return nil
    }
    
    func updatePatientData(patient: Patient) async -> Patient? {
        networkService = NetworkService()
        do {
            if let patient = try await networkService?.updatePatientData(patient: patient){
                return patient
            }
        }catch NError.invalidURL {
            print("invalid URL")
        }catch NError.invalidResponse {
            print("invalid Response")
        }catch NError.invalidData {
            print("invalid Data")
        }catch {
            print("unexpected error")
        }
        return nil
    }
}
