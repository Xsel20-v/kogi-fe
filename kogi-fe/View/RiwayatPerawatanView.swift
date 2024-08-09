//
//  RiwayatPerawatanView.swift
//  kogi-fe
//
//  Created by Azella Mutyara on 24/05/24.
//

import SwiftUI

struct RiwayatPerawatanView: View {
    
    @Binding var path : NavigationPath
    @Binding var tabSelection: Int
    @State var dataIsRetrieved = false
    
    @ObservedObject var treatmentViewModel: TreatmentViewModel
    @AppStorage("userID") var userID = "P1"
    
    var body: some View {
        ZStack {
            Color(Constant.Colors.baseColor)
                .ignoresSafeArea()
            VStack {
                HeaderViewWithTitle(title: "Riwayat Perawatan")
                
                ScrollView {
                    if let treatments = treatmentViewModel.treatmentList {
                        ForEach(treatments, id: \.treatmentID) { treatment in
                            ContainerPerawatan(treatment: treatment, treatmentViewModel: treatmentViewModel)
                                .onTapGesture {
                                    treatmentViewModel.fetchedTreatmentData = treatment
                                    path.append("Detail Perawatan")
                                }
                        }else {
                            Text("Tidak ada perawatan yang telah selesai")
                                .padding()
                                .padding(.top, 70)
                                .opacity(0.3)
                        }
                    }else {
                        Text("Tidak ada perawatan yang telah selesai")
                            .padding()
                            .padding(.top, 70)
                            .opacity(0.3)
                    }
                   
                }
            }
            .ignoresSafeArea()
        }
        .onAppear(perform: {
            Task {
                dataIsRetrieved = await treatmentViewModel.getTreatmentDataByStatus(userID: userID, status: "done", isSingle: false)
//                print(treatmentViewModel.treatmentList)
            }
        })
    }
}

#Preview {
    RiwayatPerawatanView(path: .constant(NavigationPath()), tabSelection: .constant(0), treatmentViewModel: TreatmentViewModel())
}
