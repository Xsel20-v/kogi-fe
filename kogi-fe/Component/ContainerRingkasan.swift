//
//  ContainerRingkasan.swift
//  kogi-fe
//
//  Created by Azella Mutyara on 09/05/24.
//

import SwiftUI

struct ContainerRingkasan: View {
    
    var treatment: Treatment
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 352, height: 453)
                .cornerRadius(20)
                .foregroundColor(.white)
                .shadow(radius: 3)
            
            ScrollView {
                
                Text(treatment.problemCategory)
                    .font(.system(size: 16, weight: .bold))
                    .padding(.bottom, 10)
                
                VStack(alignment: .leading, spacing: 20) {
                    ZStack(alignment: .leading) {
                        Text("Tanggal Pengajuan")
                            .font(.system(size: 14, weight: .semibold))
                            .padding(.trailing, 40)
                        Text(": ")
                            .font(.system(size: 14, weight: .semibold))
                            .offset(x: 175)
                        Text(formatDate(treatment.requestedDate))
                            .font(.system(size: 14))
                            .offset(x: 185)
                    }
                    
                    ZStack(alignment: .leading) {
                        Text("Waktu Pengajuan")
                            .font(.system(size: 14, weight: .semibold))
                            .padding(.trailing, 51)
                        Text(": ")
                            .font(.system(size: 14, weight: .semibold))
                            .offset(x: 175)
                        Text(formatTime(treatment.dateCreated))
                            .font(.system(size: 14))
                            .offset(x: 185)
                    }
                    
                    ZStack(alignment: .leading) {
                        Text("Posisi Keluhan")
                            .font(.system(size: 14, weight: .semibold))
                            .padding(.trailing, 70)
                        Text(": ")
                            .font(.system(size: 14, weight: .semibold))
                            .offset(x: 175)
                        Text(treatment.areaOfSymptom?.joined(separator: ", ") ?? "")
                            .font(.system(size: 14))
                            .offset(x: 185)
                            .frame(maxWidth: 110)
                            .multilineTextAlignment(.leading)
                    }
                    
                    ZStack(alignment: .leading) {
                        Text("Rentang Waktu")
                            .font(.system(size: 14, weight: .semibold))
                            .padding(.trailing, 65)
                        Text(": ")
                            .font(.system(size: 14, weight: .semibold))
                            .offset(x: 175)
                        Text("\(treatment.totalDaysOfSymptom) Hari")
                            .font(.system(size: 14))
                            .offset(x: 185)
                    }
                    
                    VStack(alignment: .leading, spacing: 10){
                        Text("Deskripsi Keluhan")
                            .font(.system(size: 14, weight: .semibold))
                        
                        Text(treatment.symptomsDesc)
                            .font(.system(size: 14))
                    }
                    
                    Text("Foto Kondisi Awal")
                        .font(.system(size: 14, weight: .semibold))
                    
                    if let imagesData = treatment.images {
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(imagesData, id: \.self) { imageData in
                                    if let uiImage = UIImage(data: imageData) {
                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .frame(width: 80, height: 80)
                                    }
                                }
                            }
                        }
                        .padding(.top, -10)
                    } else {
                        Text("No Image Available")
                            .font(.system(size: 14))
                            .padding(.top, -10)
                    }
                }
            }
            .frame(width: 320, height: 430)
            .clipped()
        }
    }
    
    // Helper function to format date
    func formatDate(_ date: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = formatter.date(from: date) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd, yyyy"
            return dateFormatter.string(from: date)
        }
        return "Invalid date"
    }
    
    // Helper function to format time
    func formatTime(_ date: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = formatter.date(from: date) {
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "h:mm a"
            return timeFormatter.string(from: date)
        }
        return "Invalid time"
    }
}

//#Preview {
//    let sampleTreatment = Treatment(
//            treatmentID: "12345",
//            patientID: "patient123",
//            coassID: "coass123",
//            problemCategory: "Dental",
//            areaOfSymptom: ["Taring atas", "Geraham atas", "Taring bawah", "Geraham bawah"],
//            symptomsDesc: "Severe tooth pain in multiple areas.",
//            totalDaysOfSymptom: 3,
//            dateCreated: "2023-06-20T09:41:00Z",
//            requestedDate: "2023-06-20T09:41:00Z",
//            treatmentStatus: "Pending",
//            image: nil // Provide image data if available
//        )
//
//        ContainerRingkasan(treatment: sampleTreatment)
//}
struct ContainerRingkasan_Previews: PreviewProvider {
    static var previews: some View {
        let sampleTreatment = Treatment(
            treatmentID: "12345",
            patientID: "patient123",
            coassID: "coass123",
            problemCategory: "Sakit Gigi",
            areaOfSymptom: ["Taring atas", "Geraham atas", "Taring bawah", "Geraham bawah"],
            symptomsDesc: "Gigi saya terasa sakit sejak beberapa hari lalu, dan semakin parah ketika saya makan atau minum sesuatu yang dingin atau panas. Rasa nyerinya tajam dan berdenyut, menyebar hingga ke rahang dan kadang-kadang membuat kepala saya pusing.",
            totalDaysOfSymptom: 3,
            dateCreated: "2023-06-20T09:41:00Z",
            requestedDate: "2023-06-29T09:41:00Z",
            treatmentStatus: "Pending",
            images: nil
        )
        
        ContainerRingkasan(treatment: sampleTreatment)
    }
}
