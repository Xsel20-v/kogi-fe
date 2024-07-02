//
//  Pengaturan.swift
//  kogi-fe
//
//  Created by Azella Mutyara on 07/05/24.
//

import SwiftUI

struct Pengaturan: View {
    
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    @AppStorage("isPatient") var isPatient: Bool = false
    @AppStorage("userID") var userID = "P2"
    @AppStorage("username") var username = "Axel"
    @AppStorage("dob") var dob = "2002-07-20"
    @AppStorage("email") var email_ = "1@2.com"
    @AppStorage("password") var password = "123"
    
    @Binding var path: NavigationPath
    @Binding var tabSelection: Int
    //    @StateObject var treatmentViewModel = TreatmentViewModel()
    
    @State var patient: Patient?
    @State var showAlert = false
    @State var alertTitle = ""
    @State var alertMessage = ""
    
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
                            Text(username)
                        }
                        HStack {
                            Text("Lahir")
                                .foregroundColor(.gray)
                            Spacer()
                            Text(dob)
                        }
                        HStack {
                            Text("Email")
                                .foregroundColor(.gray)
                            Spacer()
                            Text(email_)
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
                            path.append("FAQ View")
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
                            alertTitle = "Apakah anda ingin keluar?"
                            alertMessage = "Apakah anda ingin mengganti akun?"
                            showAlert = true
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
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text(alertTitle),
                    message: Text(alertMessage),
                    primaryButton: .destructive(Text("Keluar")) {
                        isLoggedIn = false
                        isPatient = false
                        userID = ""
                        username = ""
                        dob = ""
                        email_ = ""
                        password = ""
                    },
                    secondaryButton: .cancel(Text("Tidak"))
                )
            }
        }
        
    }
}


#Preview {
    Pengaturan(path: .constant(NavigationPath()), tabSelection: .constant(2), patientViewModel: PatientViewModel())
}
