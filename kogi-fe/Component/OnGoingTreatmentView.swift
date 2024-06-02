//
//  OnGoingTreatmentView.swift
//  kogi-fe
//
//  Created by Jonathan Axel Benaya on 26/05/24.
//

import SwiftUI

struct OnGoingTreatmentView: View {
    
    @State var showAlert = false
    @Binding var showSheet: Bool
    @ObservedObject var treatmentViewModel: TreatmentViewModel
    
    var body: some View {
        ZStack {
            Color(Constant.Colors.systemYellow)
                .ignoresSafeArea()
            VStack {
                Image("swipeDownIndicator")
                    .padding(.bottom, 20)
                Spacer()
                ContainerRingkasan(treatment: treatmentViewModel.fetchedTreatmentData ?? Treatment(treatmentID: "", patientID: "", problemCategory: "", symptomsDesc: "", dateCreated: "", requestedDate: "", treatmentStatus: "", images: []))
                    .padding(.bottom, 50)
                Spacer()
                Button(action: {
                    showAlert = true
                }, label: {
                    ButtonComponent(text: "Batalkan Perawatan", buttonColors: .red)
                })
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Apakah anda yakin?"),
                        message: Text("Apakah anda ingin membatalkan pengajuan perawatan anda?"),
                        primaryButton: .destructive(Text("Batalkan")) {
                            Task {
                                await treatmentViewModel.updateTreatmentStatus(treatmentStatus: "canceled")
                            }
                            showSheet = false
                        },
                        secondaryButton: .cancel(Text("Tidak"))
                    )
                }
            }
            .padding()
            .padding(.top, 30)
            .animation(.default, value: showSheet)
            
        }
    }
}

#Preview {
    OnGoingTreatmentView(showSheet: .constant(true), treatmentViewModel: TreatmentViewModel())
}
