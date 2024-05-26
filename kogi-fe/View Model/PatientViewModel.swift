//
//  PatientViewModel.swift
//  kogi-fe
//
//  Created by Azella Mutyara on 25/05/24.
//

import Foundation
import _PhotosUI_SwiftUI
import SwiftUI

@MainActor
class PatientViewModel: ObservableObject {
    @Published private var patient: Patient
    @Published var fetchedPatientData: Patient?
//    @Published var selectedImages : [UIImage] = []
//    @Published var imageSelections : [PhotosPickerItem] = [] {
//        didSet {
//            setImages(from : imageSelections)
//        }
//    }
    
    @AppStorage("userID") var userID = "P2"
    
    var networkService: NetworkService?
    
    init() {
        patient = Patient(patientID: "", name: "", dateOfBirth: "", email: "", password: "")
    }
    
    func getPatientData() async -> Bool {
        networkService = NetworkService()
//        do {
//            if let patient = try await networkService?.fetchPatientData()?.first {
//                fetchedPatientData = patient
//                print(fetchedPatientData)
//                return true
//            }
//        }catch NError.invalidURL {
//            print("invalid URL")
//        }catch NError.invalidResponse {
//            print("invalid Response")
//        }catch NError.invalidData {
//            print("invalid Data")
//        }catch {
//            print("unexpected error")
//        }
        
        do {
            if let patient = try await networkService?.fetchPatientData()?.first {
                fetchedPatientData = patient
                print("Patient Data Response: \(patient)")
                return true
            }
        } catch {
            print("Error fetching patient data: \(error)")
        }
        
        return false
    }
    
//    func getImages() async -> [UIImage]? {
//        
//        if let images = fetchedTreatmentData?.images {
//            var dataImages: [Data] = []
//            var uiImages: [UIImage] = []
//            
//            for image in images {
//                if let dataImage = Data(base64Encoded: image){
//                    dataImages.append(dataImage)
//                }
//            }
//            
//            for dataImage in dataImages {
//                if let uiImage = UIImage(data: dataImage){
//                    uiImages.append(uiImage)
//                }
//            }
//            return uiImages
//        }
//        return nil
//    }
    
    func getPatientProfileData() -> Patient {
        return patient
    }
    
    func getPatientID() -> String {
        return patient.patientID
    }
    
    func getPatientName() -> String {
        return patient.name
    }
    
    func getPatientDateOfBirth() -> String {
        return patient.dateOfBirth
    }
    
    func getPatientEmail() -> String {
        return patient.email
    }
    
    func getPatientPassword() -> String {
        return patient.password
    }
    
    
    
//    func setImages(from selections: [PhotosPickerItem]) {
//        Task {
//            var images : [UIImage] = []
//            for selection in selections {
//                if let data = try? await selection.loadTransferable(type: Data.self){
//                    if let uiImage = UIImage(data: data){
//                        images.append(uiImage)
//                        print(data)
//                    }
//                }
//            }
//            self.selectedImages = images
//            updateImages(from: imageSelections)
//        }
//    }
    
//    func updateImages(from selections: [PhotosPickerItem]) {
//        Task {
//            var images : [Data] = []
//            for selection in selections {
//                if let data = try? await selection.loadTransferable(type: Data.self){
//                    images.append(data)
//                }
//            }
//            for image in images {
//                treatment.images.append(image.base64EncodedString())
//            }
//            
//        }
//    }
//    
//    func removeImage(selection : UIImage) {
//        if let index = selectedImages.firstIndex(of: selection) {
//            selectedImages.remove(at: index)
//            imageSelections.remove(at: index)
//        }
//        treatment.images = []
//        updateImages(from: imageSelections)
//    }
    
//    func postPatientData() async {
//        networkService = NetworkService()
//        do {
//            try await networkService?.sendPostTreatment(treatment: treatment)
//        }catch NError.invalidURL {
//            print("invalid URL")
//        }catch NError.invalidResponse {
//            print("invalid Response")
//        }catch NError.invalidData {
//            print("invalid Data")
//        }catch NError.invalidEncodingData {
//            print("invalid Encoding Data")
//        }catch {
//            print("unexpected error.")
//        }
//    }
//    
//    func clearTreatmentData() {
//        treatment = Treatment(treatmentID: "", patientID: "", problemCategory: "", symptomsDesc: "", dateCreated: "", requestedDate: "", treatmentStatus: "", images: [])
//    }

}


