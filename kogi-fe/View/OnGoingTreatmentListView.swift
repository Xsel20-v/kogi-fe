//
//  OnGoingTreatmentView.swift
//  kogi-fe
//
//  Created by Jonathan Axel Benaya on 02/07/24.
//

import SwiftUI

struct OnGoingTreatmentListView: View {
    @Binding var path : NavigationPath
    @Binding var tabSelection: Int
    @State var dataIsRetrieved: Bool = false
    
    @ObservedObject var treatmentViewModel: TreatmentViewModel
    @AppStorage("userID") var userID = "P1"
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(Constant.Colors.baseColor)
                    .ignoresSafeArea()
                VStack {
                    HeaderViewWithTitle(title: "List Perawatan")
                    
                    ScrollView {
                        if let treatments = treatmentViewModel.onGoingTreatmentList {
                            ForEach(treatments, id: \.treatmentID) { treatment in
                                ContainerPerawatan(treatment: treatment)
                                    .frame(width: geometry.size.width, height: geometry.size.height)
                                    .onTapGesture {
                                        treatmentViewModel.fetchedTreatmentData = treatment
                                        path.append("Detail Perawatan")
                                    }
                            }
                        }else {
                            Text("Tidak ada perawatan")
                                .padding()
                                .padding(.top, 70)
                                .opacity(0.3)
                        }
                       
                    }
                }
                .ignoresSafeArea()
            }
            .onAppear {
                Task {
                    dataIsRetrieved = await treatmentViewModel.getOnGoingTreatmentList(userID: userID)
                    print(treatmentViewModel.onGoingTreatmentList)
                }
            }
        }
    }
}

#Preview {
    OnGoingTreatmentListView(path: .constant(NavigationPath()), tabSelection: .constant(0), treatmentViewModel: TreatmentViewModel())
}
