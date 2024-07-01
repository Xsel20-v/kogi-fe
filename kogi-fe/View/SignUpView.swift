//
//  SignUpView.swift
//  kogi-fe
//
//  Created by Azella Mutyara on 25/05/24.
//

import SwiftUI

struct SignUpView: View {
    
    @State private var fullName: String = ""
    @State private var birthDate: Date = Date()
    @State private var isDatePickerVisible = false
    @State private var email: String = ""
    @State private var createPassword: String = ""
    @State private var verifyPassword: String = ""
    @State private var isPasswordVisible: Bool = false
    @State private var isVerifyPasswordVisible: Bool = false
    @State private var showAlert: Bool = false
    
    @ObservedObject var loginViewModel: LoginViewModel
    
    @Binding var path: NavigationPath
    
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    @AppStorage("isPatient") var isPatient: Bool = false
    @AppStorage("userID") var userID = "P2"
    @AppStorage("username") var username = "Axel"
    @AppStorage("dob") var dob = "2002-07-20"
    @AppStorage("email") var email_ = "1@2.com"
    @AppStorage("password") var password = "123"
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
    
    var body: some View {
        VStack(spacing: 16) {
            
            // Header
            VStack(alignment: .leading) {
                Spacer()
                
                Text("Buat Akun")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Text("Yuk buat akun buat akses fitur lengkap")
                    .foregroundColor(.white)
            }
            .padding(.bottom)
            .frame(maxWidth: .infinity, maxHeight: 208)
            .background(Color("primaryColor"))
            
            ScrollView {
                
                VStack(spacing: 25) {
                    // Full Name Input
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Nama")
                        TextField("Nama Lengkap", text: $fullName)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(20.0)
                    }
                    .padding(.horizontal, 16)
                    
                    // Birth Date Input
                    if isPatient {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Tanggal Lahir")
                            
                            Button(action: {
                                self.isDatePickerVisible.toggle()
                            }) {
                                HStack {
                                    let calendar = Calendar.current
                                    let currentDate = calendar.startOfDay(for: Date())
                                    let birthDateStartOfDay = calendar.startOfDay(for: birthDate)
                                    
                                    if calendar.isDate(currentDate, equalTo: birthDateStartOfDay, toGranularity: .day) {
                                        Text("DD/MM/YYYY")
                                            .padding()
                                    } else {
                                        Text(dateFormatter.string(from: birthDate))
                                            .foregroundStyle(.black)
                                            .padding()
                                    }
                                    
                                    Spacer()
                                    
                                    Image(systemName: isDatePickerVisible ? "chevron.up" : "chevron.down")
                                        .padding()
                                }
                                .foregroundColor(.gray)
                                .background(Color(.systemGray6))
                                .cornerRadius(20)
                            }
                            
                            if isDatePickerVisible {
                                DatePicker("Tanggal Lahir", selection: $birthDate, displayedComponents: .date)
                                    .datePickerStyle(WheelDatePickerStyle())
                                    .labelsHidden()
                                    .background(Color(.systemGray6))
                                    .cornerRadius(20.0)
                                    .padding(.horizontal, 16)
                            }
                            
                        }
                        .padding(.horizontal, 16)
                    }
                    
                    // Create Email Input
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Email")
                        TextField("Email", text: $email)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(20.0)
                    }
                    .padding(.horizontal, 16)
                    
                    // Create Password Input
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Password")
                        HStack {
                            if isPasswordVisible {
                                TextField("Create Password", text: $createPassword)
                            } else {
                                SecureField("Create Password", text: $createPassword)
                            }
                            Button(action: {
                                isPasswordVisible.toggle()
                            }) {
                                Image(systemName: isPasswordVisible ? "eye" : "eye.slash")
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(20.0)
                    }
                    .padding(.horizontal, 16)
                    
                    // Verify Password Input
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Password")
                        
                        HStack {
                            if isVerifyPasswordVisible {
                                TextField("Verify Password", text: $verifyPassword)
                            } else {
                                SecureField("Verify Password", text: $verifyPassword)
                            }
                            Button(action: {
                                isVerifyPasswordVisible.toggle()
                            }) {
                                Image(systemName: isVerifyPasswordVisible ? "eye" : "eye.slash")
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(20.0)
                    }
                    .padding(.horizontal, 16)
                    
                    
                    
//                    ImagePicker(placeholder: "Masukkan Foto Ijazah")
                }
                
            }
            
            
            // Create Account Button
            Button(action: {
                // Handle create account action
                
                if isFilled() {
                    Task {
                        if isPatient {
                            if let patient = await loginViewModel.signUpNewPatient(nama: fullName, birthDate: birthDate.toString(), email: email, password: createPassword) {
                                self.userID = patient.patientID
                                self.username = patient.name
                                self.dob = patient.dateOfBirth
                                self.email_ = patient.email
                                self.password = patient.password
                                self.isLoggedIn = true
                            } else {
                                showAlert = true
                            }
                        } else {
                            if let coass = await loginViewModel.signUpNewCoass(nama: fullName, email: email, password: createPassword) {
                                self.userID = coass.coassID
                                self.username = coass.name
                                self.email_ = coass.email
                                self.password = coass.password
                                self.isLoggedIn = true
                            } else {
                                showAlert = true
                            }
                        }
                        
                        
                    }
                } else {
                    showAlert = true
                }
                print("Create Account button tapped")
            }) {
                ButtonComponent(text: "Buat Akun", buttonColors: .blue)
            }
            .padding(.horizontal, 16)
            
            // Sign In Link
            HStack {
                Text("Sudah Punya Akun?")
                    .foregroundColor(.gray)
                Button(action: {
                    path.removeLast()
                    print("Sign In button tapped")
                }) {
                    Text("Masuk Disini")
                        .font(.headline)
                        .foregroundColor(Color("primaryColor"))
                }
            }
            .padding(.top, 8)
            .padding(.bottom, 16)
            .padding(.horizontal, 16)
            
            Spacer()
        }
        .background(Color.white)
        .edgesIgnoringSafeArea(.top)
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(loginViewModel.alertTitle),
                message: Text(loginViewModel.alertMessage),
                dismissButton: .default(Text("Tutup")) {
                    self.showAlert = false
                }
            )
        }
    }
    
    func isFilled() -> Bool {
        if isPatient {
            if !fullName.isEmpty && birthDate != Date.now && !createPassword.isEmpty && !verifyPassword.isEmpty {
                
                if createPassword == verifyPassword {
                    return true
                } else {
                    loginViewModel.alertMessage = "Password tidak sama"
                    return false
                }
            } else {
                loginViewModel.alertMessage = "Pastikan anda mengisi seluruh data yang diperlukan"
                return false
            }
        } else {
            if !fullName.isEmpty && !createPassword.isEmpty && !verifyPassword.isEmpty {
                
                if createPassword == verifyPassword {
                    return true
                } else {
                    loginViewModel.alertMessage = "Password tidak sama"
                    return false
                }
            } else {
                loginViewModel.alertMessage = "Pastikan anda mengisi seluruh data yang diperlukan"
                return false
            }
        }
        
    }
}

#Preview {
    SignUpView(loginViewModel: LoginViewModel(), path: .constant(NavigationPath()))
}
