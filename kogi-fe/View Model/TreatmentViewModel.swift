//
//  TreatmentViewModel.swift
//  kogi-fe
//
//  Created by Jonathan Axel Benaya on 16/05/24.
//

import Foundation
import _PhotosUI_SwiftUI
import SwiftUI

@MainActor
class TreatmentViewModel: ObservableObject {
    @Published private var treatment: Treatment
    @Published var fetchedTreatmentData: Treatment?
    @Published var selectedImages : [UIImage] = []
    @Published var imageSelections : [PhotosPickerItem] = [] {
        didSet {
            setImages(from : imageSelections)
        }
    }
    
    var networkService: NetworkService?
    
    init() {
        treatment = Treatment(patientID: "", problemCategory: "", areaOfSymptom: [], symptomsDesc: "", totalDaysOfSymptom: 0, dateCreated: "", requestedDate: "", treatmentStatus: "")
    }
    
    func getTreatmentData() async -> Bool {
        networkService = NetworkService()
        do {
            if let treatment = try await networkService?.fetchOnGoingTreatment()?.first {
                fetchedTreatmentData = treatment
                print(fetchedTreatmentData)
                return true
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
    
    
    func getAnamnesisData() -> Treatment {
        return treatment
    }
    
    func getTreatmentCategory() -> String {
        return treatment.problemCategory
    }
    
    func getImages() -> [Data]? {
        return treatment.images
    }
    
    func getUserID() -> String {
        return treatment.patientID
    }
    
    func getAreaOfSymptom() -> [String]? {
        if let areaOfSymptom = treatment.areaOfSymptom {
            return areaOfSymptom
        }
        return []
    }
    
    func getTotalDaysOfSymptom() -> Int {
        return treatment.totalDaysOfSymptom
    }
    
    func getDateCreated() -> String {
        return treatment.dateCreated
    }
    
    func getSymptomDesc() -> String {
        return treatment.symptomsDesc
    }
    
    func getRequestedDate() -> String {
        return treatment.requestedDate
    }
    
    func getStatus() -> String {
        return treatment.treatmentStatus
    }
    
    func updateUserID(userID: String) {
        treatment.patientID = userID
    }
    
    func updateProblemCategory(problemCategory: String) {
        treatment.problemCategory = problemCategory
    }
    
    func updateAreaOfSymptom(areaOfSymptom: [String]) {
        treatment.areaOfSymptom = areaOfSymptom
    }
    
    func updateTotalDaysOfSymptom(totalDaysOfSymptom: Int){
        treatment.totalDaysOfSymptom = totalDaysOfSymptom
    }
    
    func updateDateCreated(dateCreated: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        treatment.dateCreated = formatter.string(from: dateCreated)
    }
    
    func updateSymptomDesc(symptomDesc: String){
        treatment.symptomsDesc = symptomDesc
    }
    
    func updateRequestedDate(requestedDate: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        treatment.requestedDate = formatter.string(from: requestedDate)
    }
    
    func updateTreatmentStatus(treatmentStatus: String){
        treatment.treatmentStatus = treatmentStatus
    }
    
    func setImages(from selections: [PhotosPickerItem]) {
        Task {
            var images : [UIImage] = []
            for selection in selections {
                if let data = try? await selection.loadTransferable(type: Data.self){
                    if let uiImage = UIImage(data: data){
                        images.append(uiImage)
                        print(data)
                    }
                }
            }
            self.selectedImages = images
            updateImages(from: imageSelections)
        }
    }
    
    func updateImages(from selections: [PhotosPickerItem]) {
        Task {
            var images : [Data] = []
            for selection in selections {
                if let data = try? await selection.loadTransferable(type: Data.self){
                    images.append(data)
                }
            }
            treatment.images = images
        }
    }
    
    func removeImage(selection : UIImage) {
        if let index = selectedImages.firstIndex(of: selection) {
            selectedImages.remove(at: index)
            imageSelections.remove(at: index)
        }
        updateImages(from: imageSelections)
    }
    
    func postTreatmentData() async {
        networkService = NetworkService()
        do {
            try await networkService?.sendPostTreatment(treatment: treatment)
        }catch NError.invalidURL {
            print("invalid URL")
        }catch NError.invalidResponse {
            print("invalid Response")
        }catch NError.invalidData {
            print("invalid Data")
        }catch NError.invalidEncodingData {
            print("invalid Encoding Data")
        }catch {
            print("unexpected error.")
        }
    }

}

