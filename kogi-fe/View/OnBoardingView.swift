//
//  OnBoardingView.swift
//  kogi-fe
//
//  Created by Jonathan Axel Benaya on 27/05/24.
//

import SwiftUI

struct OnBoardingView: View {
    
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    @AppStorage("isPatient") var isPatient: Bool = false
    @State private var currentPage = 0
    private var onBoardingItems = Constant.OnboardingItems.onboardingItems
    @State private var index = 0
    @State private var path = NavigationPath()
    @State private var showAlert = false
    
    @StateObject var loginViewModel = LoginViewModel()
    
    var body: some View {
        NavigationStack(path: $path) {
            GeometryReader { geometry in
                ZStack {
                    OnBoardingPage(data: onBoardingItems[index])
                    if index < onBoardingItems.count-1 {
                        Text("Lewati")
                            .foregroundColor(Constant.Colors.primaryColor)
                            .font(.system(size: 16))
                            .font(.headline)
                            .offset(x: geometry.size.width * (5/13), y: -geometry.size.height * (11/24))
                            .onTapGesture {
                                index = onBoardingItems.count-1
                                currentPage = index
                            }
                    }
                    VStack {
                        HStack {
                            ForEach(0..<onBoardingItems.count, id: \.self) { index in
                                // Step 13: Create Navigation Dots
                                Capsule()
                                    .fill(Color.black.opacity(currentPage == index ? 1 : 0.33))
                                    .frame(width: 10, height: 10)
                            }
                        }
                        .padding(.bottom, 50)
                        if (index < onBoardingItems.count - 1) {
                            Button(action: {
                                index += 1
                                currentPage = index
                            }, label: {
                                ButtonComponent(text: "Selanjutnya", buttonColors: .blue)
                            })
                        } else {
                            Button(action: {
                                isPatient = true
                                path.append("LogIn")
                            }, label: {
                                ButtonComponent(text: "Pasien", buttonColors: .blue)
                            })
                            Button(action: {
                                isPatient = false
                                path.append("LogIn")
//                                showAlert.toggle()
                                print("DOKTER")
                            }, label: {
                                ButtonComponent(text: "Dokter", buttonColors: .blue)
                            })
                            .padding(.bottom, 30)
                        }
                        
                    }
                    .offset(y: geometry.size.height * (7/17))
                }
                .ignoresSafeArea()
                
            }
            .alert(isPresented: $showAlert, content: {
                Alert(title: Text("Fitur Belum Tersedia"),
                         message: Text("Maaf, fitur ini masih dalam pengembangan dan akan segera tersedia."),
                         dismissButton: .default(Text("Tutup")) {
                             self.showAlert = false
                })
            })
            .navigationDestination(for: String.self) { value in
                switch (value) {
                case "LogIn" :
                    LogInView(path: $path, loginViewModel: loginViewModel)
                case "SignUp" :
                    SignUpView(loginViewModel: loginViewModel, path: $path)
                default :
                    LogInView(path: $path, loginViewModel: loginViewModel)
                }
            }
            
        }

    }
}

#Preview {
    OnBoardingView()
}
