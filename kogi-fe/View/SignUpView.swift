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
    @State private var createPassword: String = ""
    @State private var verifyPassword: String = ""
    @State private var isPasswordVisible: Bool = false
    @State private var isVerifyPasswordVisible: Bool = false
    
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
                    
                    
                    
//                    ImagePicker(placeholder: "Maukkan Foto Ijazah")
                }
                
            }
            
            
            // Create Account Button
            Button(action: {
                // Handle create account action
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
                    // Handle sign in action
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
    }
}

#Preview {
    SignUpView()
}
