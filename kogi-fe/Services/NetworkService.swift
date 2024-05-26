//
//  NetworkService.swift
//  kogi-fe
//
//  Created by Jonathan Axel Benaya on 21/05/24.
//

import Foundation

class NetworkService {
    let userID = UserDefaults.standard.string(forKey: "userID") ?? "P2"
    
    func fetchOnGoingTreatment() async throws -> [Treatment]? {
        let endpoint = "https://kogi-api.onrender.com/api/getTreatmentList"
        
        guard let url = URL(string: endpoint) else { throw NError.invalidURL }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST" // Set HTTP method to POST
        request.addValue("application/json", forHTTPHeaderField: "Content-Type") // Specify content type
        
        let bodyData = "{\"uid\": \"\(userID)\",\"status\": \"pending\"}"
        
        print(bodyData)
        request.httpBody = bodyData.data(using: .utf8)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw NError.invalidResponse}
        
        do {
            let jsonDecoder = JSONDecoder()
            return try jsonDecoder.decode([Treatment].self, from: data)
        } catch {
            throw NError.invalidData
        }
    }
    
//    func fetchPatientData() async throws -> [Patient]? {
//        let endpoint = "https://kogi-api.onrender.com/api/users"
//        
//        guard let url = URL(string: endpoint) else { throw NError.invalidURL }
//        
//        var request = URLRequest(url: url)
//        
//        request.httpMethod = "POST" // Set HTTP method to POST
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type") // Specify content type
//        
//        let bodyData = "{\"uid\": \"\(userID)\"}"
//        
//        print(bodyData)
//        request.httpBody = bodyData.data(using: .utf8)
//        
//        let (data, response) = try await URLSession.shared.data(for: request)
//        
//        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw NError.invalidResponse}
//        
//        do {
//            let jsonDecoder = JSONDecoder()
//            return try jsonDecoder.decode([Patient].self, from: data)
//        } catch {
//            throw NError.invalidData
//        }
//    }
    
    func fetchPatientData() async throws -> [Patient]? {
        let endpoint = "https://kogi-api.onrender.com/api/users"
        
        guard var urlComponents = URLComponents(string: endpoint) else { throw NError.invalidURL }
        
        // Add query parameter for the user ID
        urlComponents.queryItems = [URLQueryItem(name: "uid", value: userID)]
        
        guard let url = urlComponents.url else { throw NError.invalidURL }
        
        var request = URLRequest(url: url)
        
        // Set HTTP method to GET
        request.httpMethod = "GET"
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NError.invalidResponse
        }
        
        do {
            let jsonDecoder = JSONDecoder()
            return try jsonDecoder.decode([Patient].self, from: data)
        } catch {
            throw NError.invalidData
        }
    }

    
    func sendPostTreatment(treatment: Treatment) async throws {
        
        var postTreatment = PostTreatment(
            patientID: treatment.patientID,
            problemCategory: treatment.problemCategory,
            areaOfSymptom: treatment.areaOfSymptom,
            symptomsDesc: treatment.symptomsDesc,
            totalDaysOfSymptom: treatment.totalDaysOfSymptom,
            requestedDate: treatment.requestedDate,
            images: treatment.images
        )
        
        // Encode the postTreatment object to JSON
        guard let jsonData = try? JSONEncoder().encode(postTreatment) else { throw NError.invalidEncodingData }
        
        // Define the endpoint URL
        let endpoint = "https://kogi-api.onrender.com/api/insertTreatment" // Replace with actual endpoint
        
        // Ensure the URL is valid
        guard let url = URL(string: endpoint) else { throw NError.invalidURL }
        
        // Create and configure the URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        do {
            // Perform the network request
            let (data, response) = try await URLSession.shared.data(for: request)
            
            // Ensure the response is an HTTPURLResponse and has a status code of 200
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw NError.invalidResponse
            }
            
            // Print the response data if it can be converted to a string
            if let responseString = String(data: data, encoding: .utf8) {
                print("Response: \(responseString)")
            }
        } catch {
            // Handle any errors that occurred during the network request
            print("Error: \(error)")
            throw error
        }
    }
}

enum NError : Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case invalidEncodingData
}
