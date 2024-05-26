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
    var userPassword = ""
    
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
                    if (currentPassword == userPassword){
                        if newPassword == confirmPassword {
                            showAlert = true
                            alertMessage = "Password changed successfully!"
                        } else {
                            showAlert = true
                            alertMessage = "New password and confirm password do not match!"
                        }
                    } else {
                        showAlert = true
                        alertMessage = "Current Pasword Invalid"
                    }
                }) {
                    ButtonComponent(text: "Ganti Sandi", buttonColors: .blue)
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Ganti Sandi"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
            }
        }
    }
}

#Preview {
    GantiSandiView(path: .constant(NavigationPath()), tabSelection: .constant(2))
}
