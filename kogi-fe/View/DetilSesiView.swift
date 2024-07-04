//
//  DetilSesiView.swift
//  kogi-fe
//
//  Created by Azella Mutyara on 23/05/24.
//

import SwiftUI

struct DetilSesiView: View {
    
    @ObservedObject var treatmentViewModel: TreatmentViewModel
    var index: Int
    @State private var isImageMaximized = false
    @State private var selectedImage: UIImage?
    
    var body: some View {
        ZStack {
            Color(Constant.Colors.baseColor)
                .ignoresSafeArea()
            VStack {
                HeaderViewComponent()
                
                Spacer()
                
                ScrollView{
                    VStack(spacing: 10){
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .foregroundColor(Color.white)
                            
                            VStack(alignment:.leading) {
                                Text("Sesi \(index + 1)")
                                    .font(.system(size: 18, weight: .bold))
                                
                                HStack{
                                    Image(systemName: "mappin")
                                        .foregroundColor(Constant.Colors.primaryColor)
                                    Text("RSGM UNPAD, Kota Bandung")
                                }
                                
                                HStack{
                                    Image(systemName: "clock.fill")
                                        .foregroundColor(Constant.Colors.primaryColor)

                                    Text("\(treatmentViewModel.fetchedSession.dateOfSession.dateToString()) \(treatmentViewModel.fetchedSession.dateOfSession.timeToString())")
                                }
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 15)
                        }
                        
                        ZStack(alignment:.leading) {
                            Rectangle()
                                .foregroundColor(Color.white)
                            
                            VStack(alignment:.leading) {
                                HStack{
                                    Image(systemName: "note.text")
                                    Text("Catatan Koas")
                                }
                                .fontWeight(.semibold)
                                
                                Text(treatmentViewModel.fetchedSession.reportText ?? "")
                                    .padding(.top, 5)
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 15)
                        }
                        
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .foregroundColor(Color.white)
                            
                            VStack(alignment: .leading) {
                                HStack{
                                    Image(systemName: "photo.on.rectangle")
                                    Text("Foto Kondisi Awal")
                                }
                                .fontWeight(.semibold)
                                
                                HStack {
                                    if let imageBefore = treatmentViewModel.fetchedSession.imageBefore {
                                        ForEach(treatmentViewModel.fetchedSession.imageBefore ?? [] , id: \.self) { image in
                                            if let uiImage = UIImage(data: Data(base64Encoded: image)!) {
                                                Image(uiImage: uiImage)
                                                    .resizable()
                                                    .frame(width: 80, height: 80)
                                                    .onTapGesture {
                                                        selectedImage = uiImage
                                                        isImageMaximized = true
                                                    }
                                            }
                                        }
                                        
                                    } else {
                                        Text("Foto tidak tersedia...")
                                            .frame(height: 70)
                                            .opacity(0.3)
                                    }
                                }
                                .padding(.top, 5)
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 15)
                        }
                        
                        ZStack(alignment: .leading){
                            Rectangle()
                                .foregroundColor(Color.white)
                            
                            VStack(alignment: .leading) {
                                    HStack{
                                        Image(systemName: "photo.fill.on.rectangle.fill")
                                        Text("Foto Kondisi Akhir")
                                    }
                                    .fontWeight(.semibold)
                                    
                                    HStack {
                                        if let imageAfter = treatmentViewModel.fetchedSession.imageAfter {
                                            ForEach(treatmentViewModel.fetchedSession.imageAfter ?? [] , id: \.self) { image in
                                                if let uiImage = UIImage(data: Data(base64Encoded: image)!) {
                                                    Image(uiImage: uiImage)
                                                        .resizable()
                                                        .frame(width: 80, height: 80)
                                                        .onTapGesture {
                                                            selectedImage = uiImage
                                                            isImageMaximized = true
                                                        }
                                                }
                                            }
                                        } else {
                                            Text("Foto tidak tersedia...")
                                                .frame(height: 70)
                                                .opacity(0.3)
                                        }
                                        
                                    }
                                    .padding(.top, 5)
                                }
                                .padding(.horizontal, 20)
                                .padding(.vertical, 15)
                        }
                    }
                }
            }
            .ignoresSafeArea()
            
            if isImageMaximized {
                MaximizedImageView(image: $selectedImage, isImageMaximized: $isImageMaximized)
                    .transition(.opacity)
            }
        }

    }
}

#Preview {
    DetilSesiView(treatmentViewModel: TreatmentViewModel(), index: 0)
}
