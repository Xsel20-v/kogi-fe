//
//  SessionViewModel.swift
//  kogi-fe
//
//  Created by Azella Mutyara on 27/05/24.
//

import Foundation
import _PhotosUI_SwiftUI
import SwiftUI

@MainActor
class SessionViewModel: ObservableObject {
    @Published private var session: SessionModel
    @Published var fetchedSessionList: [SessionModel] = []
    @Published var selectedImages : [UIImage] = []
    @Published var imageSelections : [PhotosPickerItem] = [] {
        didSet {
            setImages(from : imageSelections)
        }
    }
    
    @AppStorage("treatmentID") var userID = "T1"
    
    var networkService: NetworkService?
    
    init() {
        session = SessionModel(sessionID: "", treatmentID: "", dateOfSession: "", reportText: "", imageBefore: [], imageAfter: [], sessionStatus: "")
    }
    
    func getSessionList() async -> Bool {
        networkService = NetworkService()
        
        do {
            if let sessionList = try await networkService?.fetchSessionList() {
                fetchedSessionList = sessionList
                print("Session List: \(fetchedSessionList)")
                return true // Return true if session list is fetched successfully
            } else {
                print("Failed to fetch session list.")
                return false // Return false if session list is not fetched successfully
            }
        } catch {
            print("Error fetching session data: \(error)")
            return false // Return false if there's an error while fetching session list
        }
    }
    
    func getDateOfSession() -> String {
        return session.dateOfSession
    }
    
    func getReportText() -> String {
        return session.reportText ?? ""
    }
    
    func getSessionStatus() -> String {
        return session.sessionStatus ?? ""
    }
    
    func getImagesBefore(sessionID: String) -> [UIImage]? {
        guard let session = fetchedSessionList.first(where: { $0.sessionID == sessionID }),
              let imageBeforeStrings = session.imageBefore else {
            return nil
        }
        
        return imageBeforeStrings.compactMap { base64String in
            if let data = Data(base64Encoded: base64String),
               let image = UIImage(data: data) {
                return image
            }
            return nil
        }
    }
    
    func getImagesAfter(sessionID: String) -> [UIImage]? {
        if let session = fetchedSessionList.first(where: { $0.sessionID == sessionID }) {
            return session.imageAfter?.compactMap { Data(base64Encoded: $0).flatMap { UIImage(data: $0) } }
        }
        return nil
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
                //perlu diganti bagian update nti
                session.imageAfter?.append(image.base64EncodedString())
                session.imageAfter?.append(image.base64EncodedString())
            }
            
        }
    }
    
    
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
    
}


