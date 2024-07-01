//
//  ReportFormView.swift
//  kogi-fe
//
//  Created by Azella Mutyara on 01/07/24.
//

import SwiftUI

struct ReportFormView: View {
    
    @State var catatan : String = ""
    @State var imageBefore: [Data] = []
    @State var imageAfter: [Data] = []
    @State var dataIsRetrieved = false
    
    @Binding var path: NavigationPath
    
    @ObservedObject var treatmentViewModel: TreatmentViewModel
    var index: Int
    
    var body: some View {
        ZStack{
            Color(Constant.Colors.baseColor)
                .ignoresSafeArea()
            VStack {
                HeaderViewComponent()
                
                Spacer()
                
                ScrollView{
                    VStack(alignment: .leading, spacing: 20){
                        
                        VStack(alignment:.leading) {
                            Text("Sesi \(index + 1)")
                                .font(.system(size: 14, weight: .bold))
                            
                            HStack{
                                Image(systemName: "mappin")
                                    .foregroundColor(Constant.Colors.primaryColor)
                                Text("RSGM UNPAD, Kota Bandung")
                            }
                            
                            HStack{
                                Image(systemName: "clock.fill")
                                    .foregroundColor(Constant.Colors.primaryColor)
                                
                                Text("24 Jun 2024 (11.00)")
                            }
                        }
                        .font(.system(size: 14))
                        
                        Divider()
                        
                        VStack(alignment: .leading) {
                            HStack{
                                Text("Catatan KOAS")
                                Text("*")
                                    .foregroundColor(.red)
                            }
                            .font(.system(size: 14))
                            .bold()
                            
                            ScrollView {
                                TextEditor(text: $catatan)
                                    .font(.system(size: 14))
                                    .padding()
                                    .cornerRadius(20)
                                    .frame(width: 360, height: 221)
                                    .overlay(alignment: .topLeading) {
                                        if catatan.isEmpty {
                                            Text("Tuliskan Catatan Perawatan...")
                                                .font(.system(size: 14))
                                                .foregroundColor(.gray)
                                                .padding()
                                                .padding(.top, 7)
                                                .padding(.leading, 2)
                                        }
                                    }
                            }
                            .background(Color.white)
                            .cornerRadius(20)
                            .shadow(radius: 0.6)
                        }
                        
                        
                        VStack(alignment: .leading) {
                            HStack{
                                Image(systemName: "photo.on.rectangle")
                                Text("Foto Kondisi Awal")
                            }
                            .fontWeight(.semibold)
                            
                            ImagePicker(imagesData: $imageBefore, placeholder: "Masukkan Foto Kondisi Awal")
                        }
                        
                        
                        
                        VStack(alignment: .leading) {
                            HStack{
                                Image(systemName: "photo.fill.on.rectangle.fill")
                                Text("Foto Kondisi Akhir")
                            }
                            .fontWeight(.semibold)
                            
                            
                            ImagePicker(imagesData: $imageAfter, placeholder: "Masukkan Foto Kondisi Akhir")
                        }
                        
                    }
                    .padding()
                }
                Button(action: {
                    treatmentViewModel.fetchedSession.reportText = catatan
                    treatmentViewModel.fetchedSession.imageBefore = convertDataArrayToStringArray(imageBefore)
                    treatmentViewModel.fetchedSession.imageAfter = convertDataArrayToStringArray(imageAfter)
                    if checkCompletion() {
                        treatmentViewModel.fetchedSession.sessionStatus = "done"
                    }
                    Task {
                        await treatmentViewModel.updateSession()
                        dataIsRetrieved = await treatmentViewModel.getSessionList()
                        if dataIsRetrieved {
                            path.removeLast()
                        }
                    }
                }, label: {
                    ButtonComponent(text: checkCompletion() ? "Selesaikan Sesi" : "Simpan Perubahan", buttonColors: .blue)
                        .padding(.bottom, 50)
                })
            }
            .ignoresSafeArea()
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }
        .font(.system(size: 14))
    }
    
    func checkCompletion() -> Bool {
        if !catatan.isEmpty && !imageBefore.isEmpty && !imageAfter.isEmpty {
            return true
        } else {
            return false
        }
    }
    
    func convertDataArrayToStringArray(_ dataArray: [Data]) -> [String] {
        var stringArray: [String] = []
        
        for data in dataArray {
            stringArray.append(data.base64EncodedString())
        }
        
        return stringArray
    }
}

#Preview {
    ReportFormView(path: .constant(NavigationPath()), treatmentViewModel: TreatmentViewModel(), index: 0)
}
