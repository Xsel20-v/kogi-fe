//
//  kogi_feApp.swift
//  kogi-fe
//
//  Created by Jonathan Axel Benaya on 07/05/24.
//

import SwiftUI

@main
struct kogi_feApp: App {
    
    @AppStorage("isLoggedIn") var isLoggedIn = false
    @StateObject var loginViewModel = LoginViewModel()
    
    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                ContentView(loginViewModel: loginViewModel)
            } else {
                OnBoardingView(loginViewModel: loginViewModel)
            }
            
        }
    }
}
