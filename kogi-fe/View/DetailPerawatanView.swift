//
//  DetailPerawatanView.swift
//  kogi-fe
//
//  Created by Azella Mutyara on 23/05/24.
//

import SwiftUI

struct DetailPerawatanView: View {
    
    var treatment: Treatment
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(Constant.Colors.baseColor)
                    .ignoresSafeArea()
                VStack {
                    HeaderViewComponent()
                        .padding(.top, -60)
                    
                    Spacer()
                    
                    HStack {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 73, height: 73)
                            .clipShape(Circle())
                            .padding(.trailing, 10)
                        VStack(alignment: .leading) {
                            Text("Jonathan")
                                .font(.system(size: 24))
                                .fontWeight(.bold)
                            Text("Sakit Gigi")
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
                    
                    ScrollView {
                        VStack {
                            
                            // Complaint Details Section
                            VStack(alignment: .leading, spacing: 15) {
                                HStack {
                                    Text("Kategori")
                                        .fontWeight(.semibold)
                                    Spacer()
                                    Text(": Sakit Gigi")
                                }
                                HStack {
                                    Text("Posisi Keluhan")
                                        .fontWeight(.semibold)
                                    Spacer()
                                    Text(": Geraham atas")
                                }
                                HStack {
                                    Text("Rentang Waktu")
                                        .fontWeight(.semibold)
                                    Spacer()
                                    Text(": 3 Hari")
                                }
                                VStack(alignment: .leading) {
                                    Text("Deskripsi Keluhan")
                                        .fontWeight(.semibold)
                                    Text(treatment.symptomsDesc)
                                        .padding(.top, 5)
                                }
                            }
                            .padding()
                            .font(.system(size: 12))
                            
                            
                            Divider()
                            
                            HStack{
                                Text("Detil Sesi")
                                Spacer()
                                
                                Button(action:{
                                    
                                }) {
                                    Text("Tambah Sesi +")
                                        .foregroundColor(.blue)
                                }
                            }
                            .padding()
                            .font(.system(size: 12))
                            
                            
                            Button(action: {
                                
                            }) {
                                ContainerDetilSesi(status: .done, date: "dece")
                                    .frame(width: geometry.size.width, height: geometry.size.height)
                                    .foregroundColor(.black)
                            }
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        
                    }) {
                        ButtonComponent(text: "Selesaikan Perawatan", buttonColors: .blue)
                    }
                }
            }
        }
    }
}

struct DetailPerawatanView_Previews: PreviewProvider {
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
            treatmentStatus: "pending",
            images: nil
        )
        
        DetailPerawatanView(treatment: sampleTreatment)
    }
}
