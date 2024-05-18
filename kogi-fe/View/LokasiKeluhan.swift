//
//  LokasiKeluhan.swift
//  kogi-fe
//
//  Created by Jonathan Axel Benaya on 14/05/24.
//

import SwiftUI

struct LokasiKeluhan: View {
    
    var category: String
    var rectangleWidth : CGFloat = 352
    var bentukGigiHeight : CGFloat = 303
    var answerContainerHeight : CGFloat = 233
    var height : CGFloat = 230
    @AppStorage("userID") var userID = "P2"
    
    @State var posisiGigi: [String] = []
    @State var isSelectedSeriAtas: Bool = false
    @State var isSelectedSeriBawah: Bool = false
    @State var isSelectedTaringAtas: Bool = false
    @State var isSelectedTaringBawah: Bool = false
    @State var isSelectedGerahamDepanAtas: Bool = false
    @State var isSelectedGerahamDepanBawah: Bool = false
    @State var isSelectedGerahamBlkngAtas: Bool = false
    @State var isSelectedGerahamBlkngBawah: Bool = false
    
    @State var isPindah: Bool = false
    
    var anamnesisViewModel: AnamnesisViewModel = AnamnesisViewModel()
    
    var body: some View {
        ZStack {
            Color(Constant.Colors.baseColor)
                .ignoresSafeArea()
            VStack{
                HeaderViewAnamnesis(category: "")
                Rectangle()
                    .frame(width: rectangleWidth, height: bentukGigiHeight)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .overlay {
                        VStack () {
                            Image("Bentuk Gigi")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 156)
                            Image("Jenis Gigi")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 265)
                            HStack {
                                Text("Seri")
                                    .offset(x : 45)
                                Spacer()
                                Text("Taring")
                                    .offset(x : 50)
                                Spacer()
                                Text("Geraham Depan")
                                    .multilineTextAlignment(.center)
                                    .frame(width: 53)
                                    .offset(x : 40)
                                Spacer()
                                Text("Geraham Belakang")
                                    .multilineTextAlignment(.center)
                                    .frame(width: 53)
                                    .offset(x : 15)
                                Spacer()
                            }
                            .font(.system(size: 12))
                            Spacer()
                        }
                    }
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
                .padding(.top, 30)

                
                Button(action: {
                    anamnesisViewModel.updateUserID(userID: userID )
                    anamnesisViewModel.updateDateCreated(dateCreated: Date())
                    anamnesisViewModel.updateAreaOfSymptom(areaOfSymptom: posisiGigi)
                    isPindah.toggle()
                    print(anamnesisViewModel.treatment)
                }, label: {
                    ButtonComponent(text: "Selanjutnya", buttonColors: .blue
                    )
                })
                .background {
                    NavigationLink(destination: LamaKeluhan(), isActive: $isPindah, label: {EmptyView()})
                }

                Spacer()
            }
            .ignoresSafeArea()
            
        }
    }
}

#Preview {
    LokasiKeluhan(category: "Sakit Gigi", anamnesisViewModel: AnamnesisViewModel())
}
