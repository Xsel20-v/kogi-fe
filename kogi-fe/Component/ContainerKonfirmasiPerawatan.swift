//
//  ContainerKonfirmasiPerawatan.swift
//  kogi-fe
//
//  Created by Jonathan Axel Benaya on 28/05/24.
//

import SwiftUI

struct ContainerKonfirmasiPerawatan: View {
    
    @ObservedObject var treatmentViewModel: TreatmentViewModel
    var message: Message
    
    @State var isAccepted = false
    
    var formattedTimestamp: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        if let date = formatter.date(from: message.timestamp) {
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "h:mm a"
            return timeFormatter.string(from: date)
        }
        return "Invalid time"
    }
    
    private var departemen: String {
        if treatmentViewModel.fetchedTreatmentData?.problemCategory == "Karang Gigi" || treatmentViewModel.fetchedTreatmentData?.problemCategory == "Gusi Bengkak" {
            return "Periodonsia"
        } else if treatmentViewModel.fetchedTreatmentData?.problemCategory == "Sakit Gigi" {
            return "Konservasi Gigi"
        } else if treatmentViewModel.fetchedTreatmentData?.problemCategory == "Sariwan"{
            return "Ilmu Penyakit Mulut"
        } else if treatmentViewModel.fetchedTreatmentData?.problemCategory == "Kawat Lepasan" {
            return "Orthodonsia"
        } else if treatmentViewModel.fetchedTreatmentData?.problemCategory == "Gigi Palsu" {
            return "Prostodonsia"
        } else if treatmentViewModel.fetchedTreatmentData?.problemCategory == "Gigi Tiruan" {
            return "Bedah Mulut"
        } else {
            return "Tidak Ditemukan"
        }
    }
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("Konfirmasi Perawatan")
                .bold()
            Divider()
            VStack(alignment: .leading) {
                Text("Departemen \(departemen)")
                    .fontWeight(.medium)
                    .padding(.bottom, 5)
                HStack {
                    Text("KOAS")
                    Spacer()
                    Text(message.message[2])
                        .fontWeight(.light)
                }
                .padding(.bottom, 5)
                HStack {
                    Text("Kategori")
                    Spacer()
                    Text(message.message[1])
                        .fontWeight(.light)
                }
                .padding(.bottom, 5)
                HStack {
                    HStack{
                        Image(systemName: "mappin")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 12, height: 12)
                            .aspectRatio(contentMode: .fit)
                        
                        Text("RSGM UNPAD, Kota Bandung")
                            .font(.system(size: 12))
                    }
                    Spacer()
                    HStack{
                        Image(systemName: "clock.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 12, height: 12)
                            .aspectRatio(contentMode: .fit)
                        
                        Text("\(message.message[0].dateToString()) (\(message.message[0].timeToString()))")
                            .font(.system(size: 12))
                    }
                }
                .padding(.bottom, 5)
                Button(action: {
                    Task {
                        await treatmentViewModel.updateTreatmentStatus(treatmentStatus: "ongoing")
                        isAccepted = true
                    }
                   
                }, label: {
                    HStack {
                        Spacer()
                        Text("Terima")
                            .frame(width: 352, height: 30)
                            .background(isAccepted ? Constant.Colors.notMyMessage :  Constant.Colors.primaryColor)
                            .foregroundStyle(Constant.Colors.baseColor)
                            .cornerRadius(10)
                        Spacer()
                    }
                    
                })
                .padding(.bottom, 5)
            }
        }
        .padding(.horizontal, 10)
        .shadow(radius: 10)
    }
}

#Preview {
    ContainerKonfirmasiPerawatan(treatmentViewModel: TreatmentViewModel(), message: Message(id: "M1", type: "treatment", roomID: "R1", sender: "C1", timestamp: "2024-05-29T12:12:12", message: ["2024-06-24T09:01:24", "Sakit Gigi", "Azella"]))
}
