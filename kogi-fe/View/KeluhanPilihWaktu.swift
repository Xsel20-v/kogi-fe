//
//  KeluhanPilihWaktu.swift
//  kogi-fe
//
//  Created by Jonathan Axel Benaya on 14/05/24.
//

import SwiftUI
import PhotosUI

struct KeluhanPilihWaktu: View {
    
    @Binding var path : NavigationPath
    @ObservedObject var treatmentViewModel: TreatmentViewModel
    
    @State var lamaKeluhan : Int = 1
    @State var keluhan : String = ""
    @State var tanggalWaktu = Date.now
    @FocusState private var isFocused: Bool
    
    var keluhanWidth : CGFloat = 348
    var keluhanHeight : CGFloat = 200
    
    let minimumDate = Date.now
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(Constant.Colors.baseColor)
                    .ignoresSafeArea()
                
                VStack (alignment : .leading) {
                    HeaderViewAnamnesis(category: "")
                    ScrollView {
                        VStack (alignment : .leading){
                            if treatmentViewModel.getTreatmentCategory() ==  Constant.Categories.sakitGigi || treatmentViewModel.getTreatmentCategory() == Constant.Categories.gigiTiruan || treatmentViewModel.getTreatmentCategory() ==  Constant.Categories.cabutGigi {
                                HStack {
                                    Text("Berapa hari keluhan muncul?")
                                        .fontWeight(.semibold)

                                    Spacer()
                                    HStack {
                                        Button(action: {
                                            self.lamaKeluhan -= 1
                                        }) {
                                            Image(systemName: "minus.circle")
                                        }
                                        .padding(.trailing, 5)
                                        
                                        Text("\(lamaKeluhan)")
                                            .foregroundColor(.blue)
                                        
                                        Button(action: {
                                            self.lamaKeluhan += 1
                                        }) {
                                            Image(systemName: "plus.circle")
                                        }
                                        .padding(.leading, 5)
                                    }
                                }
                                .padding(.bottom, 20)
                            }
                            
                            Text("Ceritakan keluhan yang anda rasakan")
                                .fontWeight(.semibold)
                            ScrollView {
                                TextEditor(text: $keluhan)
                                    .font(.system(size: 12))
                                    .padding()
                                    .frame(width: keluhanWidth, height: keluhanHeight)
                                    .overlay(alignment: .topLeading) {
                                        if keluhan.isEmpty {
                                            Text("Tuliskan keluhan anda...")
                                                .font(.system(size: 12))
                                                .foregroundColor(.gray)
                                                .padding()
                                                .padding(.top, 8)
                                                .padding(.leading, 4)
                                        }
                                    }
                            }
                            .frame(width: keluhanWidth, height: keluhanHeight) // Fixed frame for ScrollView
                            .background(Color.white) // Set background color to white if needed
                            .cornerRadius(20)
                            .padding(.bottom, 20)
                            
                            Text("Pilih tanggal dan waktu perawatan")
                                .fontWeight(.semibold)
                            HStack {
                                DatePicker(selection: $tanggalWaktu, in: minimumDate...) {
                                    Text("")
                                }
                                .labelsHidden()
                            }
                            .padding(.bottom, 20)
                            
                            Text("Foto Kondisi")
                                .fontWeight(.semibold)
                            
                            if !treatmentViewModel.selectedImages.isEmpty{
                                ScrollView(.horizontal){
                                    HStack {
                                        ForEach(treatmentViewModel.selectedImages, id: \.self) { image in
                                            Image(uiImage: image)
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width : 80, height: 80)
                                                .cornerRadius(10)
                                                .overlay(alignment: .topTrailing, content: {
                                                    Text("x")
                                                        .font(.system(size: 24))
                                                        .foregroundColor(.white)
                                                        .padding(.trailing, 3)
                                                        .onTapGesture {
                                                            treatmentViewModel.removeImage(selection: image)
                                                        }
                                                })

                                        }
                                    }
                                }
                            }
                            
                            PhotosPicker(selection: $treatmentViewModel.imageSelections, matching: .images) {
                                HStack {
                                    Spacer()
                                    Rectangle()
                                        .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [10, 5]))
                                        .frame(width: keluhanWidth, height: 75)
                                        .foregroundColor(Constant.Colors.primaryColor)
                                        .overlay {
                                            ZStack {
                                                Color(Constant.Colors.primaryColor)
                                                    .opacity(0.075)
                                                VStack {
                                                    Image(systemName: "camera")
                                                        .padding(.bottom,5)
                                                    Text("Ambil foto gigi anda")
                                                        .font(.system(size: 12))
                                                }
                                            }
                                           
                                        }
                                    Spacer()
                                }
                                
                            }
                            
                        }
                        .padding()
                    }
                    Spacer()
                    Button(action: {
                        treatmentViewModel.updateTotalDaysOfSymptom(totalDaysOfSymptom: lamaKeluhan)
                        treatmentViewModel.updateSymptomDesc(symptomDesc: keluhan)
                        treatmentViewModel.updateRequestedDate(requestedDate: tanggalWaktu)
                        path.append("Ringkasan")
//                        print(treatmentViewModel.getAnamnesisData())
                    }, label: {
                        ButtonComponent(text: "Selanjutnya", buttonColors: treatmentViewModel.selectedImages.isEmpty || keluhan.isEmpty ? .gray : .blue)
                    })
                    .padding()
                    .padding(.bottom,20)
                    .disabled(keluhan.isEmpty || treatmentViewModel.selectedImages.isEmpty)
                       
                }
                .ignoresSafeArea()
                .onTapGesture {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
            }
        }
    }
    
}

#Preview {
    KeluhanPilihWaktu(path: .constant(NavigationPath()), treatmentViewModel: TreatmentViewModel())
}
