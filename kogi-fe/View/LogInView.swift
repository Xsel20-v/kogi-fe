//
//  LogInView.swift
//  kogi-fe
//
//  Created by Azella Mutyara on 25/05/24.
//

import SwiftUI

struct LogInView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showAlert: Bool = false
    
    @Binding var path: NavigationPath
    
    @AppStorage("isPatient") var isPatient = false
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    @AppStorage("userID") var userID = "P2"
    @AppStorage("username") var username = "Axel"
    @AppStorage("dob") var dob = "2002-07-20"
    @AppStorage("email") var email_ = "1@2.com"
    @AppStorage("password") var password_ = "123"
    @AppStorage("profilePicture") var profilePicture: String = ""
    @AppStorage("certificate") var certificate: String = ""
    
    @ObservedObject var loginViewModel: LoginViewModel
    
    var body: some View {
        VStack(spacing: 25) {
            
            Spacer()
            
            Image("KogiLogo")
                .shadow(radius: 2)
            
            Spacer()
            
            // Email Input
            VStack(alignment: .leading, spacing: 4) {
                Text("Email")
                    .font(.headline)
                TextField("Input Email", text: $email)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(20.0)
            }
            .padding(.horizontal, 16)
            
            // Password Input
            VStack(alignment: .leading, spacing: 4) {
                Text("Password")
                    .font(.headline)
                SecureField("Input Password", text: $password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(20.0)
            }
            .padding(.horizontal, 16)
            
            // Log In Button
            Button(action: {
                // Handle login action
                if !email.isEmpty && !password.isEmpty {
                    Task {
                        if isPatient {
                            if let patient = await loginViewModel.logInUser(email: email, password: password, isPatient: isPatient) as Patient? {
                                isPatient = true
                                userID = patient.patientID
                                username = patient.name
                                dob = patient.dateOfBirth
                                email_ = patient.email
                                password_ = patient.password
                                if let profilePicture = patient.profilePicture {
                                    self.profilePicture = profilePicture
                                }
                                isLoggedIn = true
                            }else {
                                // Handle login failure
                                showAlert = true
                                print("Failed to log in as patient")
                            }
                        } else {
                            if let coass = await loginViewModel.logInUser(email: email, password: password, isPatient: isPatient) as Coass? {
                                isPatient = false
                                userID = coass.coassID
                                username = coass.name
                                email_ = coass.email
                                password_ = coass.password
                                if let certificate = coass.certificate {
                                    self.certificate = certificate
                                }
                                if let profilePicture = coass.profilePicture {
                                    self.profilePicture = profilePicture
                                }
                                isLoggedIn = true
                                
                            } else {
                                // Handle login failure
                                showAlert = true
                                print("Failed to log in as coass")
                            }
                        }
                    }
                } else {
                    loginViewModel.alertTitle = "Log In Tidak Berhasil"
                    loginViewModel.alertMessage = "Pastikan anda mengisi seluruh data yang diperlukan"
                    showAlert = true
                }
                
            }) {
                ButtonComponent(text: "Log in", buttonColors: .blue)
            }
            .padding(.horizontal, 16)
            .padding(.top, 29)
            
            // Sign Up Link
            HStack {
                Text("Belum Punya Akun?")
                    .foregroundColor(.gray)
                Button(action: {
                    // Handle sign up action
                    path.append("SignUp")
                    print("Sign Up button tapped")
                }) {
                    Text("Sign Up")
                        .font(.headline)
                }
            }
            .padding(.top, 8)
        }
        .padding(.top, 64)
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(loginViewModel.alertTitle),
                message: Text(loginViewModel.alertMessage),
                dismissButton: .default(Text("Tutup")) {
                    self.showAlert = false
                })
        }
    }
}

#Preview {
    LogInView(path: .constant(NavigationPath()), loginViewModel: LoginViewModel())
}
