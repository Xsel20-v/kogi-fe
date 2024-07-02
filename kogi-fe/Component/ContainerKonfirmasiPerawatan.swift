//
//  ContainerKonfirmasiPerawatan.swift
//  kogi-fe
//
//  Created by Jonathan Axel Benaya on 28/05/24.
//

import SwiftUI

struct ContainerKonfirmasiPerawatan: View {
    
    @ObservedObject var treatmentViewModel: TreatmentViewModel
    @ObservedObject var socketIOManager: SocketIOManager
    var message: ChatHistory
    
    @State var treatmentStatus = "pending"
    @State var buttonText = "Terima"
    @State var buttonColor: Color = .black
    @State var buttonTextColor: Color = .black
    
    var coassID : String
    
    @AppStorage("isPatient") var isPatient = false
    
    private var departemen: String {
        if message.message[1] == "Karang Gigi" || message.message[1] == "Gusi Bengkak" {
            return "Periodonsia"
        } else if message.message[1] == "Sakit Gigi" {
            return "Konservasi Gigi"
        } else if message.message[1] == "Sariawan"{
            return "Ilmu Penyakit Mulut"
        } else if message.message[1] == "Kawat Lepasan" {
            return "Orthodonsia"
        } else if message.message[1] == "Gigi Palsu" {
            return "Prostodonsia"
        } else if message.message[1] == "Gigi Tiruan" {
            return "Bedah Mulut"
        } else {
            return "Tidak Ditemukan"
        }
    }
    
    private func formatDateString(_ dateString: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        inputFormatter.timeZone = TimeZone.current
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd MMM yy (HH:mm)"
        outputFormatter.timeZone = TimeZone.current
        
        if let date = inputFormatter.date(from: dateString) {
            return outputFormatter.string(from: date)
        }
        return "Invalid date"
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
                            
                            //                            Text("\(formatDateString(message.message[0])) (\(message.message[1]))")
                            //                                .font(.system(size: 12))
                            Text(formatDateString(message.message[0]))
                                .font(.system(size: 12))
                        }
                    }
                    .padding(.bottom, 5)
                    
                    if isPatient {
                        Button(action: {
                            Task {
                                do {
                                    let result = try await treatmentViewModel.updateTreatmentConfirmation(
                                        date: message.message[0],
                                        category: message.message[1],
                                        status: "ongoing",
                                        coassID: coassID
                                    )
                                    
                                    // Assuming `updateTreatmentConfirmation` returns a result or completion
                                    treatmentStatus = "ongoing"
                                    socketIOManager.emitChatHistory("R1")
                                    
                                } catch {
                                    // Handle any errors from `updateTreatmentConfirmation` here
                                    print("Error updating treatment confirmation: \(error)")
                                }
                            }
                        }, label: {
                            HStack {
                                Spacer()
                                Text(buttonText)
                                    .frame(width: 318, height: 30)
                                    .background(buttonColor)
                                    .foregroundStyle(buttonTextColor)
                                    .cornerRadius(20)
                                Spacer()
                            }
                            .shadow(color: .black.opacity(0.4), radius: 1, y:2)
                            
                        })
                        .padding(.bottom, 5)
                    } else {
                        HStack {
                            Spacer()
                            Text(buttonText)
                                .frame(width: 318, height: 30)
                                .background(buttonColor)
                                .foregroundStyle(buttonTextColor)
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
            socketIOManager.connect()
            
            treatmentStatus = message.message[2]
            
            switch treatmentStatus{
            case "pending":
                if isPatient {
                    buttonText = "Terima"
                } else {
                    buttonText = "Menunggu Diterima"
                }
                buttonColor = Constant.Colors.primaryColor
                buttonTextColor = .white
                
            case "expired":
                buttonText = "Expired"
                buttonColor = Constant.Colors.notMyMessage
                buttonTextColor = .black
                
            case "accepted":
                buttonText = "Diterima"
                buttonColor = Constant.Colors.notMyMessage
                buttonTextColor = .black
                
            default:
                buttonText = "Terima"
                buttonColor = Constant.Colors.primaryColor
                buttonTextColor = .white
                
            }
        }
        .onChange(of: treatmentStatus) {
            
            switch treatmentStatus{
            case "pending":
                if isPatient {
                    buttonText = "Terima"
                } else {
                    buttonText = "Menunggu Diterima"
                }
                buttonColor = Constant.Colors.primaryColor
                buttonTextColor = .white
                
            case "expired":
                buttonText = "Expired"
                buttonColor = Constant.Colors.notMyMessage
                buttonTextColor = .black
                
            case "ongoing":
                buttonText = "Diterima"
                buttonColor = Constant.Colors.notMyMessage
                buttonTextColor = .black
                
            default:
                buttonText = "Terima"
                buttonColor = Constant.Colors.primaryColor
                buttonTextColor = .white
                
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
    ContainerKonfirmasiPerawatan(treatmentViewModel: TreatmentViewModel(), socketIOManager: SocketIOManager(), message: ChatHistory(messageID: "M1", type: "treatment", roomID: "R1", senderID: "C1", timestamp: "2024-05-29T12:12:12", message: ["2024-05-29T12:12:12", "Sakit Gigi", "pending"]), coassID: "C7")
}
