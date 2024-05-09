//
//  AnamnesisRadioButton.swift
//  kogi-fe
//
//  Created by Azella Mutyara on 09/05/24.
//

import SwiftUI

struct AnamnesisRadioButton: View {
    
    @State var posisiGigi: [String] = []
    @State var isSelectedSeriAtas: Bool = false
    @State var isSelectedSeriBawah: Bool = false
    @State var isSelectedTaringAtas: Bool = false
    @State var isSelectedTaringBawah: Bool = false
    @State var isSelectedGerahamDepanAtas: Bool = false
    @State var isSelectedGerahamDepanBawah: Bool = false
    @State var isSelectedGerahamBlkngAtas: Bool = false
    @State var isSelectedGerahamBlkngBawah: Bool = false
    
    var height :CGFloat = 230
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 352, height: height)
                .cornerRadius(20)
                .foregroundColor(.white)
            
            VStack {
                
                Text("Di mana letak keluhanmu?")
                    .font(.system(size: 18, weight: .bold))
                    .offset(y: -20)
                
                HStack(spacing: 15) {
                    
                    VStack(alignment: .leading) {
                        Text("Atas")
                            .font(.system(size: 14, weight: .medium))
                            .padding(.top, 15)
                        Text("Bawah")
                            .font(.system(size: 14, weight: .medium))
                            .padding(.top, 15)
                    }
                    .padding(.top, 25)
                    
                    VStack {
                        Text("Seri")
                            .font(.system(size: 14, weight: .medium))
                        
                        Image(systemName: isSelectedSeriAtas ? "checkmark.square.fill" : "checkmark.square")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 18)
                            .foregroundColor(Color("primaryColor"))
                            .onTapGesture {
                                isSelectedSeriAtas.toggle()
                                if isSelectedSeriAtas {
                                    posisiGigi.append("seri atas")
                                } else {
                                    posisiGigi.removeAll(where: { $0 == "seri atas" })
                                }
                            }
                            .padding(.top, 15)
                        
                        Image(systemName: isSelectedSeriBawah ? "checkmark.square.fill" : "checkmark.square")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 18)
                            .foregroundColor(Color("primaryColor"))
                            .onTapGesture {
                                isSelectedSeriBawah.toggle()
                                if isSelectedSeriBawah {
                                    posisiGigi.append("seri bawah")
                                } else {
                                    posisiGigi.removeAll(where: { $0 == "seri bawah" })
                                }
                            }
                            .padding(.top, 15)
                    }
                    
                    VStack {
                        Text("Taring")
                            .font(.system(size: 14, weight: .medium))
                        
                        Image(systemName: isSelectedTaringAtas ? "checkmark.square.fill" : "checkmark.square")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 18)
                            .foregroundColor(Color("primaryColor"))
                            .onTapGesture {
                                isSelectedTaringAtas.toggle()
                                if isSelectedTaringAtas {
                                    posisiGigi.append("taring atas")
                                } else {
                                    posisiGigi.removeAll(where: { $0 == "taring atas" })
                                }
                            }
                            .padding(.top, 15)
                        
                        Image(systemName: isSelectedTaringBawah ? "checkmark.square.fill" : "checkmark.square")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 18)
                            .foregroundColor(Color("primaryColor"))
                            .onTapGesture {
                                isSelectedTaringBawah.toggle()
                                if isSelectedTaringBawah {
                                    posisiGigi.append("taring bawah")
                                } else {
                                    posisiGigi.removeAll(where: { $0 == "taring bawah" })
                                }
                            }
                            .padding(.top, 15)
                    }
                    .padding(.leading, 20)
                    .padding(.trailing, 5)
                    
                    VStack {
                        Text("Geraham \nDepan")
                            .font(.system(size: 14, weight: .medium))
                            .multilineTextAlignment(.center)
                            .offset(y: -10)
                        
                        Image(systemName: isSelectedGerahamDepanAtas ? "checkmark.square.fill" : "checkmark.square")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 18)
                            .foregroundColor(Color("primaryColor"))
                            .onTapGesture {
                                isSelectedGerahamDepanAtas.toggle()
                                if isSelectedGerahamDepanAtas {
                                    posisiGigi.append("geraham depan atas")
                                } else {
                                    posisiGigi.removeAll(where: { $0 == "geraham depan atas" })
                                }
                            }
                        
                        Image(systemName: isSelectedGerahamDepanBawah ? "checkmark.square.fill" : "checkmark.square")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 18)
                            .foregroundColor(Color("primaryColor"))
                            .onTapGesture {
                                isSelectedGerahamDepanBawah.toggle()
                                if isSelectedGerahamDepanBawah {
                                    posisiGigi.append("geraham depan bawah")
                                } else {
                                    posisiGigi.removeAll(where: { $0 == "geraham depan bawah" })
                                }
                            }
                            .padding(.top, 15)
                    }
                    
                    VStack {
                        Text("Geraham \nBelakang")
                            .font(.system(size: 14, weight: .medium))
                            .multilineTextAlignment(.center)
                            .offset(y: -10)
                        
                        Image(systemName: isSelectedGerahamBlkngAtas ? "checkmark.square.fill" : "checkmark.square")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 18)
                            .foregroundColor(Color("primaryColor"))
                            .onTapGesture {
                                isSelectedGerahamBlkngAtas.toggle()
                                if isSelectedGerahamBlkngAtas {
                                    posisiGigi.append("geraham belakang atas")
                                } else {
                                    posisiGigi.removeAll(where: { $0 == "geraham belakang atas" })
                                }
                            }
                        
                        Image(systemName: isSelectedGerahamBlkngBawah ? "checkmark.square.fill" : "checkmark.square")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 18)
                            .foregroundColor(Color("primaryColor"))
                            .onTapGesture {
                                isSelectedGerahamBlkngBawah.toggle()
                                if isSelectedGerahamBlkngBawah {
                                    posisiGigi.append("geraham belakang bawah")
                                } else {
                                    posisiGigi.removeAll(where: { $0 == "geraham belakang bawah" })
                                }
                            }
                            .padding(.top, 15)
                    }
                }
                .offset(y: 15)
            }
        }
    }
}

#Preview {
    AnamnesisRadioButton()
}
