//
//  Pengaturan.swift
//  kogi-fe
//
//  Created by Azella Mutyara on 07/05/24.
//

import SwiftUI

struct Pengaturan: View {
    
    @Binding var path: NavigationPath
    @Binding var tabSelection: Int
    //    @StateObject var treatmentViewModel = TreatmentViewModel()
    
    @State var patient: Patient?
    @StateObject var patientViewModel: PatientViewModel
    
    var body: some View {
        ZStack{
            Color("primaryColor")
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Pengaturan")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.white)
                
                
                Image("sariawan1")
                    .resizable()
                    .frame(width: 140, height: 140)
                    .cornerRadius(70)
                    .overlay(alignment: .bottomTrailing) {
                        Button(action: {
                            
                            
                        }) {
                            Image(systemName: "pencil.circle.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.white)
                        }
                    }
                
                Form{
                    Section {
                        HStack {
                            Text("Nama")
                                .foregroundColor(.gray)
                            Spacer()
                            if let patientName = patientViewModel.fetchedPatientData?.name {
                                Text(patientName)
                            } else {
                                ProgressView()
                            }
                        }
                        HStack {
                            Text("Lahir")
                                .foregroundColor(.gray)
                            Spacer()
                            if let dateOfBirth = patientViewModel.fetchedPatientData?.dateOfBirth {
                                Text(dateOfBirth)
                            } else {
                                ProgressView()
                            }
                        }
                        HStack {
                            Text("Email")
                                .foregroundColor(.gray)
                            Spacer()
                            if let email = patientViewModel.fetchedPatientData?.email {
                                Text(email)
                            } else {
                                ProgressView()
                            }
                        }
                        
                        Button(action: {
                            path.append("Ijazah")
                        }, label: {
                            HStack{
                                Text("Ijazah")
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                            .foregroundColor(.black)
                        })
                        
                        Button(action: {
                            path.append("Ganti Sandi")
                        }, label: {
                            HStack{
                                Text("Ganti Sandi")
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                            .foregroundColor(.black)
                        })
                        
                        
                    }
                    
                    Section {
                        
                        Button(action: {
                            path.append("")
                        }, label: {
                            HStack{
                                Image(systemName: "questionmark.circle")
                                Text("Pusat Bantuan")
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                            .foregroundColor(.black)
                        })
                        
                        Button(action: {
                            path.append("")
                        }, label: {
                            HStack{
                                Image(systemName: "rectangle.portrait.and.arrow.right")
                                Text("Keluar")
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                            .foregroundColor(.red)
                        })
                    }
                    
                }
                .cornerRadius(20)
                .frame(width: 390, height: 536)
                .offset(y: 35)
            }
            .onAppear {
                Task {
                    await patientViewModel.getPatientData()
                }
            }
            .ignoresSafeArea()
        }
        
    }
}


#Preview {
    Pengaturan(path: .constant(NavigationPath()), tabSelection: .constant(2), patientViewModel: PatientViewModel())
}
