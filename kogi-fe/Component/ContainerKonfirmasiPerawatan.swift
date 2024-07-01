//
//  ContainerKonfirmasiPerawatan.swift
//  kogi-fe
//
//  Created by Jonathan Axel Benaya on 28/05/24.
//

import SwiftUI

struct ContainerKonfirmasiPerawatan: View {
    
    @ObservedObject var treatmentViewModel: TreatmentViewModel
    var message: ChatHistory
    
    @State var isAccepted = false
    
    @AppStorage("isPatient") var isPatient = false
    
//    var formattedTimestamp: String {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
//        if let date = formatter.date(from: message.timestamp) {
//            let timeFormatter = DateFormatter()
//            timeFormatter.dateFormat = "h:mm a"
//            return timeFormatter.string(from: date)
//        }
//        return "Invalid time"
//    }
//    
    private var departemen: String {
        if message.message[2] == "Karang Gigi" || message.message[2] == "Gusi Bengkak" {
            return "Periodonsia"
        } else if message.message[2] == "Sakit Gigi" {
            return "Konservasi Gigi"
        } else if message.message[2] == "Sariawan"{
            return "Ilmu Penyakit Mulut"
        } else if message.message[2] == "Kawat Lepasan" {
            return "Orthodonsia"
        } else if message.message[2] == "Gigi Palsu" {
            return "Prostodonsia"
        } else if message.message[2] == "Gigi Tiruan" {
            return "Bedah Mulut"
        } else {
            return "Tidak Ditemukan"
        }
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 349, height: 186)
                .foregroundColor(.white)
                .cornerRadius(20)
                .shadow(radius: 3)
            
            VStack (alignment: .center) {
                HStack {
                    Text("Konfirmasi Perawatan")
                        .bold()
                    Spacer()
                }
                Divider()
                VStack(alignment: .center) {
                    HStack {
                        Text("Departemen \(departemen)")
                            .fontWeight(.medium)
                            .padding(.bottom, 5)
                        Spacer()
                    }
                    HStack {
                        Text("Kategori")
                        Spacer()
                        Text(message.message[2])
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
                            
//                            Text("\(formatDateString(message.message[0])) (\(message.message[1]))")
//                                .font(.system(size: 12))
                            Text(message.message[0])
                                .font(.system(size: 12))
                        }
                    }
                    .padding(.bottom, 5)
                    
                    if isPatient {
                        Button(action: {
                            Task {
                                //Kyknya method updatenya harus diganti
                                await treatmentViewModel.updateTreatmentStatus(treatmentStatus: "ongoing")
                                isAccepted = true
                            }
                            
                        }, label: {
                            HStack {
                                Spacer()
                                Text(isAccepted ? "Diterima" : "Terima")
                                    .frame(width: 318, height: 30)
                                    .background(isAccepted ? Constant.Colors.notMyMessage :  Constant.Colors.primaryColor)
                                    .foregroundStyle(isAccepted ? Color.black : Constant.Colors.baseColor)
                                    .cornerRadius(20)
                                Spacer()
                            }
                            .shadow(color: .black.opacity(0.4), radius: 1, y:2)
                            
                        })
                        .padding(.bottom, 5)
                    } else {
                        HStack {
                            Spacer()
                            Text(isAccepted ? "Diterima" : "Menunggu Diterima")
                                .frame(width: 318, height: 30)
                                .background(isAccepted ? Constant.Colors.notMyMessage :  Constant.Colors.primaryColor)
                                .foregroundStyle(isAccepted ? Color.black : Constant.Colors.baseColor)
                                .cornerRadius(20)
                            Spacer()
                        }
                    }
                }
                .padding(.horizontal, 5)
                .frame(maxWidth: 340)
            }
            .padding(10)
            .frame(maxWidth: 349)
        }
        .onAppear {
            if treatmentViewModel.fetchedTreatmentData?.treatmentStatus == "pending" {
                isAccepted = false
            } else {
                isAccepted = true
            }
        }
    }
}

extension DateFormatter {
    static let customDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}

func formatDateString(_ dateString: String) -> String {
    guard let date = DateFormatter.customDateFormatter.date(from: dateString) else {
        return "Invalid date"
    }
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd MMM yy"
    return dateFormatter.string(from: date)
}

#Preview {
    ContainerKonfirmasiPerawatan(treatmentViewModel: TreatmentViewModel(), message: ChatHistory(messageID: "M1", type: "treatment", roomID: "R1", senderID: "C1", timestamp: "2024-05-29T12:12:12", message: ["2024-06-24", "09:01", "Sakit Gigi", "pending"]))
}
