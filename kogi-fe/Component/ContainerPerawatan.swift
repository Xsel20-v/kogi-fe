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
    
    @State var status: Status = .ongoing
    var treatment: Treatment
    
    var shadowRadius : CGFloat = 4
    var shadowY : CGFloat = 4
    var color1 : Color = .white
    
    var nama : String = "Azella"
    var jumlahSesi: String = "2"
    
    var body: some View {
        GeometryReader { geometry in
            
            let width : CGFloat = geometry.size.width * 0.9
            let height : CGFloat = geometry.size.height * 0.235
            let height2: CGFloat = geometry.size.height * 0.052
            let cornerRadius : CGFloat = 20
            
            let chevronRightOffset = geometry.size.width * 0.8
            let padding25 = geometry.size.height * 0.033
            
            
            let fontSize16 = geometry.size.width * 0.04
            let fontSize12 = geometry.size.width * 0.03
            
            ZStack{
                Rectangle()
                    .frame(width: width, height: height)
                    .cornerRadius(cornerRadius)
                    .foregroundColor(color1)
                    .shadow(radius: shadowRadius, y: shadowY)
                    .overlay(
                        GeometryReader { geometry in
                            Path { path in
                                path.move(to: CGPoint(x: 0, y: 38))
                                path.addLine(to: CGPoint(x: geometry.size.width, y: 38))
                            }
                            .stroke(Color.gray, lineWidth: 1)
                        }
                    )
                
                Rectangle()
                    .frame(width: width, height: height2)
                    .cornerRadius(cornerRadius)
                    .offset(y: height/2 - height2/2)
                    .foregroundColor(statusColor())
                
                Rectangle()
                    .frame(width: width, height: height2/2)
                    .offset(y: height/2 - height2/2 - height2/4)
                    .foregroundColor(statusColor())
                
                VStack(alignment: .leading) {
                    ZStack(alignment: .leading) {
                        Text(treatment.problemCategory)
                            .font(.system(size: fontSize16, weight: .semibold))
                        
                        Image(systemName: "chevron.right")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: fontSize16)
                            .offset(x: chevronRightOffset)
                    }
                    .padding(.top, -padding25)
                    
                    ZStack(alignment: .leading) {
                        Circle()
                            .frame(width: geometry.size.width * 0.187)
                        
                        VStack(alignment: .leading) {
                            Text(nama)
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
                        .offset(x: geometry.size.width * 0.22)
                    }
                    .padding(.top, geometry.size.height * 0.0065)
                    
                    HStack{
                        
                        Image(systemName: "mappin")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: fontSize16, height: fontSize16)
                            .foregroundColor(foregroundIcon())
                        
                        Text("RSGM UNPAD, Kota Bandung")
                            .font(.system(size: fontSize12))
                            .padding(.leading, geometry.size.height * -0.0065)
                            .foregroundColor(foregroundLocationAndDate())
                        
                        
                        Image(systemName: "clock.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: fontSize16, height: fontSize16)
                            .foregroundColor(foregroundIcon())
                        
                        Text("\(formatDate(treatment.requestedDate)) \(formatTime(treatment.requestedDate))")
                            .font(.system(size: fontSize12))
                            .padding(.leading, geometry.size.height * -0.0065)
                            .foregroundColor(foregroundLocationAndDate())
                    }
                    .offset(y: geometry.size.width * 0.06)
                    
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .onAppear {
                getStatus()
            }
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
        } else {
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
        let sampleTreatment = Treatment(
            treatmentID: "12345",
            patientID: "patient123",
            coassID: "coass123",
            problemCategory: "Sakit Gigi",
            areaOfSymptom: ["Taring atas", "Geraham atas", "Taring bawah", "Geraham bawah"],
            symptomsDesc: "Gigi saya terasa sakit sejak beberapa hari lalu, dan semakin parah ketika saya makan atau minum sesuatu yang dingin atau panas. Rasa nyerinya tajam dan berdenyut, menyebar hingga ke rahang dan kadang-kadang membuat kepala saya pusing.",
            totalDaysOfSymptom: 3,
            dateCreated: "2023-06-20T09:41:00",
            requestedDate: "2023-06-29T09:41:00",
            treatmentStatus: "pending",
            images: []
        )
        
        ContainerPerawatan(treatment: sampleTreatment)
    }
}

