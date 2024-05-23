//
//  DeskripsiKeluhan.swift
//  kogi-fe
//
//  Created by Jonathan Axel Benaya on 09/05/24.
//

import SwiftUI

struct DeskripsiKeluhan: View {
    
    @ObservedObject var treatmentViewModel: TreatmentViewModel
    
    let userID = UserDefaults.standard.string(forKey: "userID") ?? "P2"
    
    var category: String
    @Binding var path : NavigationPath
    
    var needExtraQuestion : Bool {
        if category == Constant.Categories.sakitGigi || category == Constant.Categories.gigiTiruan || category == Constant.Categories.cabutGigi {
            return true
        } else {
            return false
        }
    }
    
    var body: some View {
        ZStack{
            Color(Constant.Colors.baseColor)
                .ignoresSafeArea()
            VStack {
                HeaderViewAnamnesis(category: category)
                    .padding(.bottom, 30)
                BodyView(category: category)
                    .padding(.bottom,30)
                Button(action: {
                    treatmentViewModel.updateProblemCategory(problemCategory: category)
                    treatmentViewModel.updateUserID(userID: userID )
                    treatmentViewModel.updateDateCreated(dateCreated: Date())
                    path.append(needExtraQuestion ? "Lokasi Keluhan" : "Keluhan Pilih Waktu")
                }, label: {
                    ButtonComponent(text: "Selanjutnya", buttonColors: .blue)
                })
                Spacer()
            
            }
        }
        .ignoresSafeArea()
        
    }
}


struct BodyView : View {
    var category: String
    var descriptionWidth: CGFloat = 342
    var descriptionHeight: CGFloat = 342
    
    var body: some View {
        VStack {
            VStack {
                switch (category) {
                case Constant.Categories.karangGigi :
                    AutoScroller(imageNames: ["karangGigi1", "karangGigi2"])
                case Constant.Categories.sakitGigi :
                    AutoScroller(imageNames: ["gigiBerlubang1", "gigiBerlubang2", "gigiBerlubang3"])
                case Constant.Categories.cabutGigi :
                    AutoScroller(imageNames: ["gigiTiruan1", "gigiTiruan2"])
                case Constant.Categories.gigiTiruan :
                    AutoScroller(imageNames: ["karangGigi1", "karangGigi2"])
                case Constant.Categories.kawatLepasan :
                    AutoScroller(imageNames: ["kawatLepasan", "kawatLepasan2", "kawatLepasan3"])
                case Constant.Categories.gusiBengkak :
                    AutoScroller(imageNames: ["gusiBengkak1", "gusiBengkak2"])
                case Constant.Categories.sariawan :
                    AutoScroller(imageNames: ["sariawan1", "sariawan2"])
                default :
                    AutoScroller(imageNames: ["karangGigi1", "karangGigi2"])
                }
            }
            
            Rectangle()
                .frame(width: descriptionWidth, height: descriptionHeight)
                .foregroundColor(.white)
                .cornerRadius(10)
                .overlay {
                    ScrollView {
                        VStack{
                            switch(category){
                            case Constant.Categories.sakitGigi:
                                Text(Constant.Description.sakitGigi)
                            case Constant.Categories.karangGigi:
                                Text(Constant.Description.karangGigi)
                            case Constant.Categories.cabutGigi:
                                Text(Constant.Description.cabutGigi)
                            case Constant.Categories.gusiBengkak:
                                Text(Constant.Description.gusiBengkak)
                            case Constant.Categories.sariawan:
                                Text(Constant.Description.sariawan)
                            case Constant.Categories.gigiTiruan:
                                Text(Constant.Description.gigiTiruan)
                            case Constant.Categories.kawatLepasan:
                                Text(Constant.Description.kawatLepasan)
                            default:
                                Text("HAHAHA")
                            }
                            Spacer()
                        }
                        .padding()
                    }
                }

        }

        
        
    }
}

#Preview {
    DeskripsiKeluhan(treatmentViewModel: TreatmentViewModel(), category: "Sariawan", path: .constant(NavigationPath()))
}
