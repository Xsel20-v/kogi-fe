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

        var body: some View {
            VStack(spacing: 25) {
                
                Spacer()
                
                Image("kogiLogo")
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
                    print("Log in button tapped")
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
                        print("Sign Up button tapped")
                    }) {
                        Text("Sign Up")
                            .font(.headline)
                    }
                }
                .padding(.top, 8)
            }
            .padding(.top, 64)
        }
}

#Preview {
    LogInView()
}
