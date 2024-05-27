//
//  Ringkasan.swift
//  kogi-fe
//
//  Created by Jonathan Axel Benaya on 20/05/24.
//

import SwiftUI

struct Ringkasan: View {
    
    var treatment: Treatment?
    
    var circleWidth: CGFloat = 130
    var circleHeight: CGFloat = 130
    var imageWidth: CGFloat = 67
    var imageHeight: CGFloat = 72
    var headerHeight: CGFloat = 191
    
    @Binding var path : NavigationPath
    
//    @ObservedObject var treatmentViewModel: TreatmentViewModel
    @ObservedObject var treatmentViewModel: TreatmentViewModel
    
    var body: some View {
        ZStack {
            Color(Constant.Colors.baseColor)
                .ignoresSafeArea()
            Text("Ringkasan")
                .foregroundColor(Constant.Colors.baseColor)
                .zIndex(3)
                .offset(y: -350)
                .bold()
                .font(.system(size: 20))
            Circle()
                .frame(width: circleWidth, height: circleHeight)
                .offset(y: -235)
                .zIndex(1)
                .foregroundColor(Constant.Colors.systemGray)
                .overlay {
                    Image(treatmentViewModel.getTreatmentCategory())
                        .resizable()
                        .scaledToFill()
                        .frame(width: imageWidth, height: imageHeight)
                        .zIndex(2)
                        .offset(y: -235)
                }
            VStack (alignment: .leading){
                VStack {
                    Rectangle()
                        .frame(height: headerHeight)
                        .foregroundColor(Constant.Colors.primaryColor)
                        .padding(.bottom, 80)
                    
                    ContainerRingkasan(treatment: treatmentViewModel.getAnamnesisData())
                    
                    Spacer()
                    Button(action: {
                        treatmentViewModel.updateDateCreated(dateCreated: Date.now)
                        treatmentViewModel.setTreatmentStatus(treatmentStatus: "pending")
                        print(treatmentViewModel.getAnamnesisData())
                        Task {
                            await treatmentViewModel.postTreatmentData()
                            treatmentViewModel.selectedImages.removeAll()
                            treatmentViewModel.imageSelections.removeAll()
                            treatmentViewModel.clearTreatmentData()
                        }
                        path.removeLast(path.count)
                    }, label: {
                        ButtonComponent(text: "Ajukan Perawatan", buttonColors: .blue)
                    })
                    Spacer()
                }
                
            }
            .ignoresSafeArea()
        }
        .onAppear(perform: {
            treatmentViewModel.imageSelections.removeAll()
            treatmentViewModel.selectedImages.removeAll()
        })
    }
}

#Preview {
    Ringkasan(path: .constant(NavigationPath()), treatmentViewModel: TreatmentViewModel())
}
