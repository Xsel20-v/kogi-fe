//
//  ContainerPerawatan.swift
//  kogi-fe
//
//  Created by Azella Mutyara on 08/05/24.
//

//NOTE: PASSING PARAMETER BELUM!!!!!

import SwiftUI

struct ContainerPerawatan: View {
    
    enum Status {
        case pending, ongoing, done
    }
    
    @AppStorage("isPatient") var isPatient = false
    @State var status: Status = .pending
    var treatment: FetchedTreatmentData
    
    var shadowRadius : CGFloat = 4
    var shadowY : CGFloat = 4
    var color1 : Color = .white
    
    var nama : String = "Azella"
    var jumlahSesi: String = "2"
    
    var body: some View {
        let width: CGFloat = 360
        let height: CGFloat = 180
        let height2: CGFloat = 44
        let cornerRadius: CGFloat = 20
        
        let chevronRightOffset: CGFloat = 288
        let padding25: CGFloat = 25
        
        
        let fontSize16 : CGFloat = 16
        let fontSize12 : CGFloat = 12
        
        ZStack{
            Rectangle()
                .frame(width: width, height: height)
                .cornerRadius(cornerRadius)
                .foregroundColor(color1)
                .shadow(radius: shadowRadius, y: shadowY)
//                .overlay(
//                    GeometryReader { geometry in
//                        Path { path in
//                            path.move(to: CGPoint(x: 0, y: 38))
//                            path.addLine(to: CGPoint(x: geometry.size.width, y: 38))
//                        }
//                        .stroke(Color.gray, lineWidth: 1)
//                    }
//                )
            
            Rectangle()
                .frame(width: width, height: height2)
                .cornerRadius(cornerRadius)
                .offset(y: height/2 - height2/2)
                .foregroundColor(statusColor())
            
            Rectangle()
                .frame(width: width, height: height2/2)
                .offset(y: height/2 - height2/2 - height2/4)
                .foregroundColor(statusColor())
            
            if status == .pending{
                VStack(alignment: .leading) {
                    HStack{
                        Text(treatment.problemCategory)
                            .font(.system(size: fontSize16, weight: .semibold))
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: fontSize16)
                    }
                    .padding(.top, -padding25)
                    .padding(.horizontal)
                    
                    Divider()
                    
                    ZStack(alignment: .leading) {
                        Image(systemName: "person.crop.circle.badge.clock")
                            .resizable()
                            .frame(width: 70, height: 60)
                        
                        VStack(alignment: .leading) {
                            Text("Pengajuan sedang diproses")
                                .font(.system(size: fontSize16, weight: .semibold))
                            Text("KOGI sedang mencari KOAS untukmu")
                                .font(.system(size: fontSize12))
                                .italic()
                            
                            if status == .done {
                                Text("\(jumlahSesi) Sesi")
                                    .font(.system(size: fontSize12, weight: .thin))
                                    .italic()
                            }
                        }
                        .offset(x: 80)
                    }
                    .padding(.top, 8)
                    .padding(.horizontal)
                    
                    HStack{
                        
                        Image(systemName: "mappin")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: fontSize16, height: fontSize16)
                            .foregroundColor(foregroundIcon())
                        
                        Text("RSGM UNPAD, Kota Bandung")
                            .font(.system(size: fontSize12))
                            .padding(.leading, -8)
                            .foregroundColor(foregroundLocationAndDate())
                        
                        Spacer()
                        
                        Image(systemName: "clock.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: fontSize16, height: fontSize16)
                            .foregroundColor(foregroundIcon())
                        
                        Text("\(formatDate(treatment.requestedDate)) \(formatTime(treatment.requestedDate))")
                            .font(.system(size: fontSize12))
                            .padding(.leading, -5)
                            .foregroundColor(foregroundLocationAndDate())
                    }
                    .padding(.horizontal, 10)
                    .offset(y: 20)
                    
                }
                
            } else {
                VStack(alignment: .leading) {
                    HStack {
                        Text(treatment.problemCategory)
                            .font(.system(size: fontSize16, weight: .semibold))
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: fontSize16)
                    }
                    .padding(.top, -padding25)
                    .padding(.horizontal)
                    
                    Divider()
                    
                    ZStack(alignment: .leading) {
                        Circle()
                            .frame(width: 68)
                        
                        VStack(alignment: .leading) {
                            Text((isPatient ? treatment.coassName : treatment.patientName) ?? "No Name")
                                .font(.system(size: fontSize16, weight: .semibold))
                            Text("Departemen \(fetchDepartment())")
                                .font(.system(size: fontSize12))
                                .italic()
                            
                            if status == .done {
                                Text("\(jumlahSesi) Sesi")
                                    .font(.system(size: fontSize12, weight: .thin))
                                    .italic()
                            }
                        }
                        .offset(x: 80)
                    }
                    .padding(.top, 4)
                    .padding(.horizontal)
                    
                    HStack{
                        
                        Image(systemName: "mappin")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: fontSize16, height: fontSize16)
                            .foregroundColor(foregroundIcon())
                        
                        Text("RSGM UNPAD, Kota Bandung")
                            .font(.system(size: fontSize12))
                            .padding(.leading, -8)
                            .foregroundColor(foregroundLocationAndDate())
                        
                        Spacer()
                        
                        Image(systemName: "clock.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: fontSize16, height: fontSize16)
                            .foregroundColor(foregroundIcon())
                        
                        Text("\(formatDate(treatment.requestedDate)) \(formatTime(treatment.requestedDate))")
                            .font(.system(size: fontSize12))
                            .padding(.leading, -5)
                            .foregroundColor(foregroundLocationAndDate())
                    }
                    .padding(.horizontal, 10)
                    .offset(y: 20)
                    
                }
            }
        }
        .frame(maxWidth: width, alignment: .center)
        .onAppear {
            getStatus()
        }
    }
    
    func statusColor() -> Color {
        switch status {
        case .pending:
            return Color("systemYellow")
        case .ongoing:
            return Color("systemGreen")
        case .done:
            return Color("primaryColor")
        }
    }
    
    func foregroundLocationAndDate() -> Color {
        switch status {
        case .done:
            return Color.white
        default:
            return Color.black
        }
    }
    
    func foregroundIcon() -> Color {
        switch status {
        case .done:
            return Color.white
        default:
            return Color("primaryColor")
        }
    }
    
    func fetchDepartment() -> String {
        let category = treatment.problemCategory
        
        if category == "Karang Gigi" || category == "Gusi Bengkak" {
            return "Periodonsia"
        } else if category == "Sakit Gigi" {
            return "Konservasi Gigi"
        } else if category == "Sariwan"{
            return "Ilmu Penyakit Mulut"
        } else if category == "Kawat Lepasan" {
            return "Orthodonsia"
        } else if category == "Gigi Palsu" {
            return "Prostodonsia"
        } else if category == "Gigi Tiruan" {
            return "Bedah Mulut"
        } else if category == "Periodonsia" {
            return "Periodonsia"
        }else {
            return "Tidak Ditemukan"
        }
    }
    
    func getStatus(){
        let treatmentStatus = treatment.treatmentStatus
        
        switch treatmentStatus {
        case "pending":
            status = .pending
        case "ongoing":
            status = .ongoing
        case "done":
            status = .done
        default:
            status = .pending
        }
    }
    
    // Helper function to format date
    func formatDate(_ date: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        if let date = formatter.date(from: date) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM yyyy"
            print(dateFormatter.string(from: date))
            return dateFormatter.string(from: date)
        }
        return "Invalid date"
    }
    // Helper function to format time
    func formatTime(_ date: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        if let date = formatter.date(from: date) {
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "h:mm a"
            return timeFormatter.string(from: date)
        }
        return "Invalid time"
    }
}

//#Preview {
//    ContainerPerawatan(status: .ongoing, category: "Sakit Gigi", nama: "Azella Gania Mutyara", departemen: "Departemen Konservasi Gigi", jumlahSesi: "2")
//}

struct ContainerPerawatan_Previews: PreviewProvider {
    static var previews: some View {
        let sampleTreatment = FetchedTreatmentData(
            treatmentID: "12345",
            patientID: "patient123",
            coassID: "coass123",
            problemCategory: "Sakit Gigi",
            areaOfSymptom: ["Taring atas", "Geraham atas", "Taring bawah", "Geraham bawah"],
            symptomsDesc: "Gigi saya terasa sakit sejak beberapa hari lalu, dan semakin parah ketika saya makan atau minum sesuatu yang dingin atau panas. Rasa nyerinya tajam dan berdenyut, menyebar hingga ke rahang dan kadang-kadang membuat kepala saya pusing.",
            totalDaysOfSymptom: 3,
            dateCreated: "2023-06-20T09:41:00",
            requestedDate: "2023-06-29T09:41:00",
            treatmentStatus: "done",
            images: []
        )
        
        ContainerPerawatan(treatment: sampleTreatment)
    }
}

