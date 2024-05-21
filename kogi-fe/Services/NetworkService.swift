//
//  NetworkService.swift
//  kogi-fe
//
//  Created by Jonathan Axel Benaya on 21/05/24.
//

import Foundation

class NetworkService {
    func fetchOnGoingTreatment() async throws -> [Treatment]? {
        let endpoint = "https://kogi-api.onrender.com/api/getTreatmentList"
        
        guard let url = URL(string: endpoint) else { throw NError.invalidURL }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST" // Set HTTP method to POST
        request.addValue("application/json", forHTTPHeaderField: "Content-Type") // Specify content type
        
        let bodyData = "{\"uid\": \"P12345\",\"status\": \"current\"}"
        
        
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
    
    func createTreatment(treatment: Treatment) async throws {
        
    }

}

enum NError : Error {
    case invalidURL
    case invalidResponse
    case invalidData
}
