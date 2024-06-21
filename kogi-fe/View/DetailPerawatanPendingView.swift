//
//  DetailPerawatanPendingView.swift
//  kogi-fe
//
//  Created by Azella Mutyara on 28/05/24.
//

import SwiftUI

struct DetailPerawatanPendingView: View {
    @Binding var path: NavigationPath
    @Binding var tabSelection: Int
    
    var treatment : FetchedTreatmentData
    
    @StateObject var sessionViewModel = SessionViewModel()
    @StateObject var treatmentViewModel = TreatmentViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(Constant.Colors.baseColor)
                    .ignoresSafeArea()
                VStack {
                    HeaderViewComponent()
                    
                    Spacer()
                    
                    HStack {
                        if let uiImage = UIImage(data: Data(base64Encoded: treatment.patientProfilePicture ?? "")!) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .frame(width: 73, height: 73)
                                .clipShape(Circle())
                                .padding(.trailing, 10)
                        } else {
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .frame(width: 73, height: 73)
                                .clipShape(Circle())
                                .padding(.trailing, 10)
                        }
                       
                        VStack(alignment: .leading) {
                            Text(treatment.patientName ?? "No Name")
                                .font(.system(size: 24))
                                .fontWeight(.bold)
                            Text(treatment.problemCategory)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                    }
                    .overlay(alignment: .bottomTrailing) {
                        Button(action: {
                            
                        }) {
                            Text("Chat")
                                .foregroundColor(.white)
                                .padding(.vertical, 5)
                                .padding(.horizontal, 20)
                                .background(Color("primaryColor"))
                                .cornerRadius(10)
                                .shadow(radius: 4, y: 4)
                        }
                    }
                    .padding()
                    
                    
                    Divider()
                    
                        
                        // Complaint Details Section
                        VStack(alignment: .leading, spacing: 25) {
                            HStack {
                                Text("Kategori")
                                    .fontWeight(.semibold)
                                Spacer()
                                Text(": \(treatment.problemCategory)")
                            }
                            HStack {
                                Text("Posisi Keluhan")
                                    .fontWeight(.semibold)
                                Spacer()
                                
                                HStack{
                                    Text(": ")
                                    Text("\(treatment.areaOfSymptom?.joined(separator: ", ") ?? "No symptoms")")
                                }
                            }
                            HStack {
                                Text("Rentang Waktu")
                                    .fontWeight(.semibold)
                                Spacer()
                                Text(": \(treatment.totalDaysOfSymptom) hari")
                            }
                            VStack(alignment: .leading) {
                                Text("Deskripsi Keluhan")
                                    .fontWeight(.semibold)
                                Text(treatment.symptomsDesc)
                                    .padding(.top, 5)
                            }
                            
                            VStack(alignment: .leading) {
                                Text("Foto Kondisi Awal: ")
                                    .fontWeight(.semibold)
                                
                                let imagesData = treatment.images
                                    ScrollView(.horizontal) {
                                        HStack {
                                            ForEach(imagesData, id: \.self) { imageData in
                                                if let uiImage = UIImage(data: Data(base64Encoded: imageData)!) {
                                                    Image(uiImage: uiImage)
                                                        .resizable()
                                                        .frame(width: 80, height: 80)
                                                        .cornerRadius(15)
                                                }
                                            }
                                        }
                                    }
                            }
                            
                            Spacer()
                        }
                        .padding()
                        .font(.system(size: 12))
                    
                    Spacer()
                }
                .ignoresSafeArea()
            }
        }
    }
    
    func formatDate(_ date: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        if let date = formatter.date(from: date) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd, yyyy"
            return dateFormatter.string(from: date)
        }
        return "Invalid date"
    }
}

struct DetailPerawatanPendingView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleTreatment = FetchedTreatmentData(
            treatmentID: "12345",
            patientID: "patient123",
            coassID: "coass123",
            problemCategory: "Sakit Gigi",
            areaOfSymptom: ["Taring atas", "Geraham atas", "Taring bawah", "Geraham bawah"],
            symptomsDesc: "Gigi saya terasa sakit sejak beberapa hari lalu, dan semakin parah ketika saya makan atau minum sesuatu yang dingin atau panas. Rasa nyerinya tajam dan berdenyut, menyebar hingga ke rahang dan kadang-kadang membuat kepala saya pusing.",
            totalDaysOfSymptom: 3,
            dateCreated: "2023-06-20T09:41:00Z",
            requestedDate: "2023-06-29T09:41:00Z",
            treatmentStatus: "pending",
            images: ["iVBORw0KGgoAAAANSUhEUgAAADoAAAA6CAYAAADhu0ooAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAABiSURBVGhD7c+xEYAwEMCwDyuQO/aflDRMIazGtde9n3d+4PrKa1TTqKZRTaOaRjWNahrVNKppVNOoplFNo5pGNY1qGtU0qmlU06imUU2jmkY1jWoa1TSqaVTTqKZRTaOWmQOItwGxNvzd9QAAAA5lWElmTU0AKgAAAAgAAAAAAAAA0lOTAAAAAElFTkSuQmCC"]
        )
        
        DetailPerawatanPendingView(path: .constant(NavigationPath()), tabSelection: .constant(0), treatment: sampleTreatment)
    }
}
