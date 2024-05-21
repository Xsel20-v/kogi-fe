//
//  AnamnesisViewModel.swift
//  kogi-fe
//
//  Created by Jonathan Axel Benaya on 16/05/24.
//

import Foundation

class AnamnesisViewModel: ObservableObject {
    @Published var treatment: Treatment
//    @Published var currentPage = 0
    
    init() {
        treatment = Treatment(patientID: "", problemCategory: "", areaOfSymptom: [], symptomsDesc: "", totalDaysOfSymptom: 0, dateCreated: "", requestedDate: "", treatmentStatus: "")
    }
    
//    func nextPage() {
//        if currentPage < 2 {
//            
//        }
//        currentPage += 1
//    }
//    
//    func previousPage() {
//        if currentPage > 0 {
//            currentPage -= 1
//        }
//    }
    
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
}
