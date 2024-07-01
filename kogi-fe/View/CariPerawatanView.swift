//
//  CariPerawatanView.swift
//  kogi-fe
//
//  Created by Azella Mutyara on 24/05/24.
//

import SwiftUI

struct CariPerawatanView: View {
    
    @State private var searchText = ""
    @State var isFilterSheetPresented = false
    @State var dataIsRetrieved = false
    
    @Binding var path: NavigationPath
    
    @ObservedObject var treatmentViewModel: TreatmentViewModel
    
    var category: String
    var treatments : [FetchedTreatmentData] = []
    
    var body: some View {
        ZStack {
            Color(Constant.Colors.baseColor)
                .ignoresSafeArea()
            VStack {
                HeaderViewWithTitle(title: "Cari Perawatan")
                
                HStack {
                    SearchBar(text: $searchText)
                    
                    Spacer()
                    
                    Button(action: {
                        isFilterSheetPresented.toggle()
                    }) {
                        Image(systemName: "line.horizontal.3.decrease.circle")
                            .font(.system(size: 25))
                            .foregroundColor(.gray)
                    }
                    .padding(.trailing)
                }
                
                HStack{
                    Text("Recommended Perawatan")
                        .font(.headline)
                        .padding([.top, .horizontal])
                    Button(action: {
                        Task {
                            dataIsRetrieved = await treatmentViewModel.getTreatmentListByCategory(category: category)
                        }
                    }, label: {
                        Image(systemName: "arrow.clockwise")
                            .foregroundColor(Constant.Colors.primaryColor)
                    })
                    
                    Spacer()
                }
                
                if dataIsRetrieved {
                    ScrollView {
                        LazyVStack {
                            ForEach(treatmentViewModel.treatmentList ?? treatments, id: \.treatmentID) { treatment in
                                ContainerCariPerawatan(treatment: treatment, treatmentViewModel: treatmentViewModel, path: $path)
                                    .padding(.vertical, 10)
                            }
                        }
                    }
                } else {
                    Text("Tidak ada perawatan tersedia saat ini")
                        .opacity(0.5)
                        .padding(.top, 50)
                }
                    
                Spacer()
            }
            .ignoresSafeArea()
            
            BottomSheetView(isPresented: $isFilterSheetPresented, maxHeight: 500) {
                FilterSheet(treatmentViewModel: treatmentViewModel, dataIsRetrieved: $dataIsRetrieved, category: category, isPresented: $isFilterSheetPresented)
            }
        }
        .onAppear(perform: {
            Task {
                dataIsRetrieved = await treatmentViewModel.getTreatmentListByCategory(category: category)
            }
        })
    }
}

#Preview {
    CariPerawatanView(path: .constant(NavigationPath()), treatmentViewModel: TreatmentViewModel(), category: "Konservasi Gigi")
}
