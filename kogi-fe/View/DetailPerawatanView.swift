//
//  DetailPerawatanView.swift
//  kogi-fe
//
//  Created by Azella Mutyara on 23/05/24.
//

import SwiftUI

struct DetailPerawatanView: View {
    
    @State var sessionList: [SessionModel]?
    @State var hasSession = false
    @State var isFinishAlert = false
    
    @State private var showSheet = false
    @State private var showAlert = false
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    @Binding var path: NavigationPath
    @Binding var tabSelection: Int
    @ObservedObject var treatmentViewModel: TreatmentViewModel
    
    @AppStorage("isPatient") var isPatient = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(Constant.Colors.baseColor)
                    .ignoresSafeArea()
                VStack {
                    HeaderViewComponent()
                    
                    HStack {
                        if let uiImage = UIImage(data: Data(base64Encoded: (isPatient ? treatmentViewModel.fetchedTreatmentData?.patientProfilePicture : treatmentViewModel.fetchedTreatmentData?.coassProfilePicture ?? "") ?? "")!) {
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
                            Text((isPatient ? treatmentViewModel.fetchedTreatmentData?.coassName : treatmentViewModel.fetchedTreatmentData?.patientName) ?? "")
                                .font(.system(size: 24))
                                .fontWeight(.bold)
                            Text(treatmentViewModel.fetchedTreatmentData?.problemCategory ?? "")
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
                    
                    
                    VStack {
                        
                        // Complaint Details Section
                        VStack(alignment: .leading, spacing: 15) {
                            HStack {
                                Text("Kategori")
                                    .fontWeight(.semibold)
                                Spacer()
                                Text(": \(treatmentViewModel.fetchedTreatmentData?.problemCategory ?? "")")
                            }
                            HStack {
                                Text("Posisi Keluhan")
                                    .fontWeight(.semibold)
                                Spacer()
                                
                                HStack{
                                    Text(": ")
                                    Text("\(treatmentViewModel.fetchedTreatmentData?.areaOfSymptom?.joined(separator: ", ") ?? "No symptoms")")
                                }
                            }
                            HStack {
                                Text("Rentang Waktu")
                                    .fontWeight(.semibold)
                                Spacer()
                                Text(": \(treatmentViewModel.fetchedTreatmentData?.totalDaysOfSymptom ?? 0) hari")
                            }
                            VStack(alignment: .leading) {
                                Text("Deskripsi Keluhan")
                                    .fontWeight(.semibold)
                                Text(treatmentViewModel.fetchedTreatmentData?.symptomsDesc ?? "")
                                    .padding(.top, 5)
                            }
                        }
                        .padding()
                        .font(.system(size: 12))
                        
                        
                        Divider()
                        
                        HStack{
                            Text("Detil Sesi")
                            Spacer()
                            
                            if !isPatient {
                                Button(action:{
                                    if treatmentViewModel.fetchedSessionList?.last?.sessionStatus != "ongoing" {
                                        showSheet = true
                                    } else {
                                        alertTitle = "Anda tidak dapat menambahkan sesi"
                                        alertMessage = "Mohon selesaikan sesi yang berjalan terlebih dahulu"
                                        isFinishAlert = false
                                        showAlert = true
                                    }
                                }) {
                                    Text("Tambah Sesi +")
                                        .foregroundColor(.blue)
                                }
                            }
                        }
                        .padding()
                        .font(.system(size: 12))
                        
                        if hasSession {
                            ScrollView {
                                VStack{
                                    ForEach(Array(treatmentViewModel.fetchedSessionList!.enumerated()), id: \.element.sessionID) { index, session in
                                        VStack {
                                            Button(action: {
                                                treatmentViewModel.fetchedSession = session
                                                if isPatient {
                                                    if session.sessionStatus != "done" {
                                                        alertTitle = "Anda belum dapat melihat detil sesi"
                                                        alertMessage = "Mohon selesaikan terlebih dahulu sesi anda untuk melihat catatan KOAS dokter gigi"
                                                        isFinishAlert = false
                                                        showAlert = true
                                                    } else {
                                                        path.append("Detail Sesi \(index)")
                                                    }
                                                } else {
                                                    if session.sessionStatus != "done" {
                                                        
                                                    } else {
                                                        path.append("Detail Sesi \(index)")
                                                    }
                                                }
                                                
                                            }) {
                                                ContainerDetilSesi(session: session, index: index + 1)
                                                    .foregroundColor(.black)
                                                    .padding(.bottom)
                                            }
                                        }
                                    }
                                }
                            }
                        } else {
                            Text("Anda tidak memiliki jadwal sesi")
                                .opacity(0.3)
                                .font(.system(size: 12))
                                .padding(.top, 30)
                        }
                        
                    }
                    Spacer()
                    if !isPatient {
                        Button(action: {
                            alertTitle = "Apakah anda ingin mengakhiri perawatan?"
                            alertMessage = "Apakah anda yakin untuk mengakhiri perawatan?"
                            isFinishAlert = true
                            showAlert = true
                        }) {
                            ButtonComponent(text: "Selesaikan Perawatan", buttonColors: .blue)
                        }
                        .padding(.bottom, 50)
                    }
                    
                    
                    
                }
                .ignoresSafeArea()
                BottomSheetView(isPresented: $showSheet, maxHeight: 200) {
                    SheetTambahSesi(showSheet: $showSheet, hasSession: $hasSession, treatmentViewModel: treatmentViewModel)
                        .zIndex(1.0)
                }
                
            }
            .alert(isPresented: $showAlert, content: {
                if !isFinishAlert {
                    Alert(
                        title: Text(alertTitle),
                        message: Text(alertMessage),
                        dismissButton: .default(Text("Tutup")) {
                            self.showAlert = false
                        }
                    )
                } else {
                    Alert(
                        title: Text(alertTitle),
                        message: Text(alertMessage),
                        primaryButton: .destructive(Text("Ya")) {
                            Task {
                                await treatmentViewModel.updateTreatmentStatus(treatmentStatus: "done")
                            }
                            showAlert = false
                        },
                        secondaryButton: .cancel(Text("Tidak"))
                    )
                }
                
            })
        }
        .onAppear {
            Task {
                hasSession = await treatmentViewModel.getSessionList()
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
            dateCreated: "2023-06-20T09:41:00",
            requestedDate: "2023-06-29T09:41:00",
            treatmentStatus: "pending",
            images: []
        )
        
        DetailPerawatanView(path: .constant(NavigationPath()), tabSelection: .constant(0), treatmentViewModel: TreatmentViewModel())
    }
}
