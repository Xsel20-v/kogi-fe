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
    @StateObject var treatmentViewModel = TreatmentViewModel()
    
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
                            Text("Azella")
                        }
                        HStack {
                            Text("Lahir")
                                .foregroundColor(.gray)
                            Spacer()
                            Text("15 April 1997")
                        }
                        HStack {
                            Text("Email")
                                .foregroundColor(.gray)
                            Spacer()
                            Text("azella.m@email.com")
                        }
                        
                        Button(action: {
                            path.append("")
                        }, label: {
                            HStack{
                                Text("Ijazah")
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                            .foregroundColor(.black)
                        })
                        
                        Button(action: {
                            path.append("")
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
            .ignoresSafeArea()
        }
        
    }
}


#Preview {
    Pengaturan(path: .constant(NavigationPath()), tabSelection: .constant(2))
}
