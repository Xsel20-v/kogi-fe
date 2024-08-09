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
    @Published var fetchedTreatmentData: FetchedTreatmentData?
    @Published var treatmentList: [FetchedTreatmentData]?
    @Published var onGoingTreatmentList: [FetchedTreatmentData]?
    @Published var selectedTreatment: FetchedTreatmentData?
    @Published var selectedImages : [UIImage] = []
    @Published var imageSelections : [PhotosPickerItem] = [] {
        didSet {
            setImages(from : imageSelections)
        }
    }
    
    @Published var fetchedSessionList: [SessionModel]?
    @Published var fetchedSession: SessionModel
    
    var networkService: NetworkService?
    
    init() {
        treatment = Treatment(patientID: "", problemCategory: "", areaOfSymptom: [], symptomsDesc: "", totalDaysOfSymptom: 0, dateCreated: "", requestedDate: "", treatmentStatus: "", images: [])
        fetchedSession = SessionModel(sessionID: "", treatmentID: "", dateOfSession: "")
    }
    
    func getTreatmentListByCategory(category: String) async -> Bool {
        networkService = NetworkService()
        do {
            if let treatments = try await networkService?.fetchTreatmentList(category: category) {
                treatmentList = treatments
                print(treatments)
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
    
    func getOnGoingTreatmentData(userID: String) async -> Bool {
        networkService = NetworkService()
        do {
            if let treatment = try await networkService?.fetchOnGoingTreatment(userID: userID)?.first {
                fetchedTreatmentData = treatment
                print(fetchedTreatmentData as Any)
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
    
    func getOnGoingTreatmentList(userID: String) async -> Bool {
        networkService = NetworkService()
        do {
            if let treatments = try await networkService?.fetchOnGoingTreatment(userID: userID) {
                onGoingTreatmentList = treatments
                print(onGoingTreatmentList as Any)
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
    
    func getTreatmentUsingFilter(category: String, date: String, start: String, end: String, variants: [String]?) async -> Bool {
        networkService = NetworkService()
        do {
            if let treatments = try await networkService?.fetchTreatmentByFilter(problemCategory: category, selectedDate: date, startTime: start, endTime: end, selectedVariants: variants) {
                treatmentList = treatments
                print(treatmentList as Any)
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
    
    func getTreatmentDataByStatus(userID: String, status: String, isSingle: Bool) async -> Bool {
        networkService = NetworkService()
        do {
            if isSingle {
                if let treatment = try await networkService?.fetchTreatmentByStatus(userID: userID, status: status)?.first {
                    fetchedTreatmentData = treatment
                    print(fetchedTreatmentData as Any)
                    return true
                }
            } else {
                if let treatments = try await networkService?.fetchTreatmentByStatus(userID: userID, status: status) {
                    treatmentList = treatments
                    print(treatmentList as Any)
                    return true
                }
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
    
    
    func getAnamnesisData() -> FetchedTreatmentData {
        let anamnesisData =
        FetchedTreatmentData(
            patientID: treatment.patientID,
            problemCategory: treatment.problemCategory,
            symptomsDesc: treatment.symptomsDesc,
            totalDaysOfSymptom: treatment.totalDaysOfSymptom,
            dateCreated: treatment.dateCreated,
            requestedDate: treatment.requestedDate,
            treatmentStatus: treatment.treatmentStatus,
            images: treatment.images)
        return anamnesisData
    }
    
    func getSessionList() async -> Bool {
        networkService = NetworkService()
        
        do {
            if let sessionList = try await networkService?.fetchSessionList(treatmentID: fetchedTreatmentData?.treatmentID ?? "T1") {
                fetchedSessionList = sessionList
                print(fetchedSessionList)
                return true // Return true if session list is fetched successfully
            } else {
                print("Failed to fetch session list.")
                return false // Return false if session list is not fetched successfully
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
    
    func getSessionListNumber(treatment: FetchedTreatmentData) async -> Int {
        networkService = NetworkService()
        
        do {
            if let sessionList = try await networkService?.fetchSessionList(treatmentID: treatment.treatmentID ?? "T1") {
                fetchedSessionList = sessionList
                return fetchedSessionList?.count ?? 0
            } else {
                print("Failed to fetch session list.")
                return 0
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
        return 0
    }
    
    func getTreatmentCategory() -> String {
        return treatment.problemCategory
    }
    
    func getImages() async -> [UIImage]? {
        
        if let images = fetchedTreatmentData?.images {
            var dataImages: [Data] = []
            var uiImages: [UIImage] = []
            
            for image in images {
                if let dataImage = Data(base64Encoded: image){
                    dataImages.append(dataImage)
                }
            }
            
            for dataImage in dataImages {
                if let uiImage = UIImage(data: dataImage){
                    uiImages.append(uiImage)
                }
            }
            return uiImages
        }
        return nil
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
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        treatment.dateCreated = formatter.string(from: dateCreated)
    }
    
    func updateSymptomDesc(symptomDesc: String){
        treatment.symptomsDesc = symptomDesc
    }
    
    func updateRequestedDate(requestedDate: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        treatment.requestedDate = formatter.string(from: requestedDate)
    }
    
    func setTreatmentStatus(treatmentStatus: String){
        treatment.treatmentStatus = treatmentStatus
    }
    
    func updateTreatmentStatus(treatmentStatus: String) async{
        networkService = NetworkService()
        if treatmentStatus == "pending" {
            fetchedTreatmentData?.treatmentStatus = treatmentStatus
        } else {
            fetchedTreatmentData?.treatmentStatus = treatmentStatus
            if let treatment = fetchedTreatmentData {
                do {
                    try await networkService?.updateTreatmentData(treatment: treatment)
                }catch NError.invalidURL {
                    print("invalid URL")
                }catch NError.invalidResponse {
                    print("invalid Response")
                }catch NError.invalidData {
                    print("invalid Data")
                }catch {
                    print("unexpected error")
                }
            }
            
        }
    }
    
    func updateSession() async {
        networkService = NetworkService()
        do {
            try await networkService?.updateSessionData(session: fetchedSession)
        }catch NError.invalidURL {
            print("invalid URL")
        }catch NError.invalidResponse {
            print("invalid Response")
        }catch NError.invalidData {
            print("invalid Data")
        }catch {
            print("unexpected error")
        }
    }

    func updateTreatmentConfirmation(date: String, category: String, status: String, coassID: String) async{
        fetchedTreatmentData?.requestedDate = date
        fetchedTreatmentData?.problemCategory = category
        fetchedTreatmentData?.treatmentStatus = status
        fetchedTreatmentData?.coassID = coassID
        if let treatment = fetchedTreatmentData {
            do {
                try await networkService?.updateTreatmentData(treatment: treatment)
            }catch NError.invalidURL {
                print("invalid URL")
            }catch NError.invalidResponse {
                print("invalid Response")
            }catch NError.invalidData {
                print("invalid Data")
            }catch {
                print("unexpected error")
            }
        }
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
            for image in images {
                treatment.images.append(image.base64EncodedString())
            }
            
        }
    }
    
    func removeImage(selection : UIImage) {
        if let index = selectedImages.firstIndex(of: selection) {
            selectedImages.remove(at: index)
            imageSelections.remove(at: index)
        }
        treatment.images = []
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
    
    func createSession(date: String) async {
        networkService = NetworkService()
        do {
            let session = try await networkService?.createNewSession(treatmentID: fetchedTreatmentData?.treatmentID ?? "", date: date)
            print(session as Any)
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
    
    func clearTreatmentData() {
        treatment = Treatment(treatmentID: "", patientID: "", problemCategory: "", symptomsDesc: "", dateCreated: "", requestedDate: "", treatmentStatus: "", images: [])
    }
}

