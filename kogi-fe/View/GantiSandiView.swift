//
//  GantiSandiView.swift
//  kogi-fe
//
//  Created by Azella Mutyara on 22/05/24.
//

import SwiftUI

struct GantiSandiView: View {
    @Binding var path: NavigationPath
    @Binding var tabSelection: Int
    
    @State private var currentPassword = ""
    @State private var newPassword = ""
    @State private var confirmPassword = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isCurrentPasswordVisible: Bool = false
    @State private var isNewPasswordVisible: Bool = false
    @State private var isConfirmPasswordVisible: Bool = false
    @AppStorage("isPatient") var isPatient = false
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    @AppStorage("userID") var userID = "P2"
    @AppStorage("username") var username = "Axel"
    @AppStorage("dob") var dob = "2002-07-20"
    @AppStorage("email") var email_ = "1@2.com"
    @AppStorage("password") var password_ = "123"
    @AppStorage("profilePicture") var profilePicture: String = ""
    @AppStorage("certificate") var certificate: String = ""
    @AppStorage("isEligible") var isEligible: Bool = false
    
    @ObservedObject var loginViewModel: LoginViewModel
    
    var body: some View {
        
        ZStack {
            Color(Constant.Colors.baseColor)
                .ignoresSafeArea()
            
            VStack(spacing: 15) {
                HeaderViewWithTitle(title: "Ganti Sandi")
                    .padding(.top, -100)
                
                HStack {
                        if isCurrentPasswordVisible {
                            TextField("Current Password", text: $currentPassword)
                        } else {
                            SecureField("Current Password", text: $currentPassword)
                        }
                        Button(action: {
                            isCurrentPasswordVisible.toggle()
                        }) {
                            Image(systemName: isCurrentPasswordVisible ? "eye" : "eye.slash")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20.0)
                    .padding()
                
                HStack {
                        if isNewPasswordVisible {
                            TextField("New Password", text: $newPassword)
                        } else {
                            SecureField("New Password", text: $newPassword)
                        }
                        Button(action: {
                            isNewPasswordVisible.toggle()
                        }) {
                            Image(systemName: isNewPasswordVisible ? "eye" : "eye.slash")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20.0)
                    .padding()
                
                HStack {
                        if isConfirmPasswordVisible {
                            TextField("Confirm New Password", text: $confirmPassword)
                        } else {
                            SecureField("Confirm New Password", text: $confirmPassword)
                        }
                        Button(action: {
                            isConfirmPasswordVisible.toggle()
                        }) {
                            Image(systemName: isConfirmPasswordVisible ? "eye" : "eye.slash")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20.0)
                    .padding()
                
                Spacer()
                
                Button(action: {
                    // Check if the new password and confirm password match
                    if (currentPassword == password_){
                        if newPassword == confirmPassword {
                            Task {
                                if !isPatient {
                                    if let coass = await loginViewModel.updateCoassData(coass: Coass(coassID: userID, name: username, certificate: certificate, email: email_, password: newPassword, isEligible: isEligible)) {
                                        password_ = newPassword
                                        alertMessage = "Password berhasil diganti!"
                                        showAlert = true
                                    } else {
                                        alertMessage = "Password tidak berhasil diganti!"
                                        showAlert = true
                                    }
                                } else {
                                    if let patient = await loginViewModel.updatePatientData(patient: Patient(patientID: userID, name: username, dateOfBirth: dob, email: email_, password: newPassword)) {
                                        password_ = newPassword
                                        alertMessage = "Password berhasil diganti!"
                                        showAlert = true
                                    } else {
                                        alertMessage = "Password tidak berhasil diganti!"
                                        showAlert = true
                                    }
                                }
                            }
                        } else {
                            alertMessage = "New password and confirm password is not matched!"
                            showAlert = true
                        }
                    } else {
                        alertMessage = "Current Pasword Invalid"
                        showAlert = true
                    }
                }) {
                    ButtonComponent(text: "Ganti Sandi", buttonColors: .blue)
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Ganti Sandi"), message: Text(alertMessage), dismissButton: .default(Text("OK")) {
                        path.removeLast()
                    })
                }
            }
        }
    }
}

#Preview {
    GantiSandiView(path: .constant(NavigationPath()), tabSelection: .constant(2), loginViewModel: LoginViewModel())
}
