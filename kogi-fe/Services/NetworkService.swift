//
//  NetworkService.swift
//  kogi-fe
//
//  Created by Jonathan Axel Benaya on 21/05/24.
//

import Foundation

class NetworkService {
    
    func fetchOnGoingTreatment(userID: String) async throws -> [FetchedTreatmentData]? {
        let endpoint = "https://kogi-api.onrender.com/api/getCurrentTreatment"
        
        guard let url = URL(string: endpoint) else { throw NError.invalidURL }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST" // Set HTTP method to POST
        request.addValue("application/json", forHTTPHeaderField: "Content-Type") // Specify content type
        
        let bodyData = "{\"uid\": \"\(userID)\"}"
        
        print(bodyData)
        request.httpBody = bodyData.data(using: .utf8)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw NError.invalidResponse}
        
        do {
            let jsonDecoder = JSONDecoder()
            return try jsonDecoder.decode([FetchedTreatmentData].self, from: data)
        } catch {
            throw NError.invalidData
        }
    }
    
    func fetchTreatmentByFilter(problemCategory: String, selectedDate: String, startTime: String, endTime : String, selectedVariants: [String]?) async throws -> [FetchedTreatmentData]? {
        let endpoint = "https://kogi-api.onrender.com/api/getTreatmentFilter"
        
        guard let url = URL(string: endpoint) else { throw NError.invalidURL }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST" // Set HTTP method to POST
        request.addValue("application/json", forHTTPHeaderField: "Content-Type") // Specify content type
        
        let bodyData = "{\"problemCategory\": \"\(problemCategory)\", \"selectedDate\": \"\(selectedDate)\", \"startTime\": \"\(startTime)\", \"endTime\": \"\(endTime)\", \"selectedCaseVariants\": \(selectedVariants ?? [""])}"
        
        print(bodyData)
        request.httpBody = bodyData.data(using: .utf8)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw NError.invalidResponse}
        
        do {
            let jsonDecoder = JSONDecoder()
            return try jsonDecoder.decode([FetchedTreatmentData].self, from: data)
        } catch {
            throw NError.invalidData
        }
    }
    
    func fetchTreatmentByStatus(userID: String, status: String) async throws -> [FetchedTreatmentData]? {
        let endpoint = "https://kogi-api.onrender.com/api/getTreatmentList"
        
        guard let url = URL(string: endpoint) else { throw NError.invalidURL }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST" // Set HTTP method to POST
        request.addValue("application/json", forHTTPHeaderField: "Content-Type") // Specify content type
        
        let bodyData = "{\"uid\": \"\(userID)\", \"status\": \"\(status)\"}"
        
        print(bodyData)
        request.httpBody = bodyData.data(using: .utf8)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw NError.invalidResponse}
        
        do {
            let jsonDecoder = JSONDecoder()
            return try jsonDecoder.decode([FetchedTreatmentData].self, from: data)
        } catch {
            throw NError.invalidData
        }
    }
    
    func fetchPatientData(userID: String) async throws -> [Patient]? {
        let endpoint = "https://kogi-api.onrender.com/api/users"
        
        guard var urlComponents = URLComponents(string: endpoint) else { throw NError.invalidURL }
        
        // Add query parameter for the user ID
        urlComponents.queryItems = [URLQueryItem(name: "uid", value: userID)]
        
        guard let url = urlComponents.url else { throw NError.invalidURL }
        
        var request = URLRequest(url: url)
        
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
    
    func fetchTreatmentList(category: String) async throws -> [FetchedTreatmentData]? {
        let endpoint = "https://kogi-api.onrender.com/api/getTreatment"
        
        guard let url = URL(string: endpoint) else { throw NError.invalidURL }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST" // Set HTTP method to POST
        request.addValue("application/json", forHTTPHeaderField: "Content-Type") // Specify content type
        
        let bodyData = "{\"problemCategory\": \"\(category)\"}"
        
        print(bodyData)
        request.httpBody = bodyData.data(using: .utf8)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw NError.invalidResponse}
        
        do {
            let jsonDecoder = JSONDecoder()
            return try jsonDecoder.decode([FetchedTreatmentData].self, from: data)
        } catch {
            throw NError.invalidData
        }
    }
    
    func fetchSessionList(treatmentID: String) async throws -> [SessionModel]? {
        let endpoint = "https://kogi-api.onrender.com/api/getSession"
        
        guard let url = URL(string: endpoint) else { throw NError.invalidURL }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Create the request body with the treatmentID
        request.httpMethod = "POST" // Set HTTP method to POST
        request.addValue("application/json", forHTTPHeaderField: "Content-Type") // Specify content type
        
        let bodyData = "{\"treatmentID\": \"\(treatmentID)\"}"
        
        print(bodyData)
        request.httpBody = bodyData.data(using: .utf8)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw NError.invalidResponse}
        
        do {
            let jsonDecoder = JSONDecoder()
            return try jsonDecoder.decode([SessionModel].self, from: data)
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
    
    func updateTreatmentData(treatment: FetchedTreatmentData) async throws {
        
        if let treatmentID = treatment.treatmentID {
            var updateTreatment = UpdateTreatment(
                treatmentID: treatmentID,
                coassID: treatment.coassID,
                problemCategory: treatment.problemCategory,
                status: treatment.treatmentStatus,
                Date: treatment.requestedDate)
            
            guard let jsonData = try? JSONEncoder().encode(updateTreatment) else { throw NError.invalidEncodingData }
            
            let endpoint = "https://kogi-api.onrender.com/api/UpdateTreatment"
            
            guard let url = URL(string: endpoint) else { throw NError.invalidURL }
            
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
    
    func updateSessionData(session: SessionModel) async throws {
            
            guard let jsonData = try? JSONEncoder().encode(session) else { throw NError.invalidEncodingData }
            
            let endpoint = "https://kogi-api.onrender.com/api/UpdateSesion"
            
            guard let url = URL(string: endpoint) else { throw NError.invalidURL }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
        
//        print("BODY : \(request.httpBody?.base64EncodedString())")
            
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
    
    func createNewPatient(patient: NewPatient) async throws -> Patient {
        let newPatient = patient
        
        guard let jsonData = try? JSONEncoder().encode(newPatient) else { throw NError.invalidEncodingData }
        
        let endpoint = "https://kogi-api.onrender.com/api/insertPatient"
        
        guard let url = URL(string: endpoint) else { throw NError.invalidURL }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        do {
            // Perform the network request
            let (data, response) = try await URLSession.shared.data(for: request)
            
            // Ensure the response is an HTTPURLResponse and has a status code of 200
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 201 :
                    throw NError.emailIsUsed
                case 200 :
                    break
                default :
                    throw NError.invalidResponse
                }
            }
            
            
            if let responseString = String(data: data, encoding: .utf8) {
                print("Response: \(responseString)")
            }
            
            // Decode the response data into a Patient model
            guard let patient = try? JSONDecoder().decode(Patient.self, from: data) else {
                throw NError.invalidDecodingData
            }
            
            return patient
            
            
        } catch {
            // Handle any errors that occurred during the network request
            print("Error: \(error)")
            throw error
        }

    }
    
    func createNewCoass(coass: NewCoass) async throws -> Coass {
        let newCoass = coass
        
        guard let jsonData = try? JSONEncoder().encode(newCoass) else { throw NError.invalidEncodingData }
        
        let endpoint = "https://kogi-api.onrender.com/api/insertcoass"
        
        guard let url = URL(string: endpoint) else { throw NError.invalidURL }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        do {
            // Perform the network request
            let (data, response) = try await URLSession.shared.data(for: request)
            
            // Ensure the response is an HTTPURLResponse and has a status code of 200
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 201 :
                    throw NError.emailIsUsed
                case 200 :
                    break
                default :
                    throw NError.invalidResponse
                }
            }
            
            
            if let responseString = String(data: data, encoding: .utf8) {
                print("Response: \(responseString)")
            }
            
            // Decode the response data into a Patient model
            guard let coass = try? JSONDecoder().decode(Coass.self, from: data) else {
                throw NError.invalidDecodingData
            }
            
            return coass
            
            
        } catch {
            // Handle any errors that occurred during the network request
            print("Error: \(error)")
            throw error
        }

    }
    
    func createNewSession(treatmentID: String, date: String) async throws -> SessionModel? {
        
        // Define the endpoint URL
        let endpoint = "https://kogi-api.onrender.com/api/newSession"
        
        // Ensure the URL is valid
        guard let url = URL(string: endpoint) else { throw NError.invalidURL }
        
        // Create and configure the URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let bodyData = "{\"treatmentID\": \"\(treatmentID)\", \"date\": \"\(date)\"}"
        
        print(bodyData)
        request.httpBody = bodyData.data(using: .utf8)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw NError.invalidResponse}
        
        do {
            let jsonDecoder = JSONDecoder()
            print(String(data: data, encoding: .utf8))
            return try jsonDecoder.decode(SessionModel.self, from: data)
        } catch {
            throw NError.invalidData
        }
    }
    
    func logIn<T: Decodable>(loginInfo: LoginInfo) async throws -> T {
        
        guard let jsonData = try? JSONEncoder().encode(loginInfo) else { throw NError.invalidEncodingData }
        
        let endpoint = "https://kogi-api.onrender.com/api/getLogin"
        
        guard let url = URL(string: endpoint) else { throw NError.invalidURL }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        do {
            // Perform the network request
            let (data, response) = try await URLSession.shared.data(for: request)
            
            // Ensure the response is an HTTPURLResponse and has a status code of 200
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 201 :
                    throw NError.emailOrPasswordWrong
                case 200 :
                    break
                default :
                    throw NError.invalidResponse
                }
            }
            
            
            if let responseString = String(data: data, encoding: .utf8) {
                print("Response: \(responseString)")
            }
            
            // Decode the response data into a User model
            if loginInfo.isPatient {
                let user = try JSONDecoder().decode(Patient.self, from: data)
                guard let typedUser = user as? T else {
                    throw NError.invalidDecodingData
                }
                return typedUser
            } else {
                let user = try JSONDecoder().decode(Coass.self, from: data)
                guard let typedUser = user as? T else {
                    throw NError.invalidDecodingData
                }
                return typedUser
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
    case invalidDecodingData
    case emailIsUsed
    case emailOrPasswordWrong
}
