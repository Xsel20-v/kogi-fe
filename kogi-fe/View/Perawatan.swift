import SwiftUI

struct Perawatan: View {
    
    
    @State private var categoryPerawatan: String = "Sakit Gigi"
    @State private var statusPerawatan: String = "pending"
    @State private var namaKOAS: String = "Azella"
    @State private var departemen: String = "Konservasi Gigi"
    
    @Binding var path: NavigationPath
    @ObservedObject var treatmentViewModel: TreatmentViewModel
    
    var body: some View {
        VStack (alignment: .leading){
            HomeBackground()
                .padding(.bottom, 15)
            VStack {
                HStack {
                    Text("Kategori")
                        .fontWeight(.semibold)
                    Spacer()
                   
                }
                .padding(.leading, 30)
                HStack {
                    Button(action: {
                        path.append(Constant.Categories.sakitGigi)
                    }, label: {
                        CategoryButton(text: Constant.Categories.sakitGigi, image: Constant.Images.sakitGigi)
                    })
                    Spacer()
                    Button(action: {
                        path.append(Constant.Categories.karangGigi)
                    }, label: {
                        CategoryButton(text: Constant.Categories.karangGigi, image: Constant.Images.karangGigi)
                    })
                    
                    Spacer()
                    Button(action: {
                        path.append(Constant.Categories.cabutGigi)
                    }, label: {
                        CategoryButton(text: Constant.Categories.cabutGigi, image: Constant.Images.cabutGigi)
                    })
                    
                    Spacer()
                    Button(action: {
                        path.append(Constant.Categories.gigiTiruan)
                    }, label: {
                        CategoryButton(text: Constant.Categories.gigiTiruan, image: Constant.Images.gigiTiruan)
                    })
              
                }
                .padding(.leading, 30)
                .padding(.trailing, 30)
                
                HStack {
                    Button(action: {
                        path.append(Constant.Categories.kawatLepasan)
                    }, label: {
                        CategoryButton(text: Constant.Categories.kawatLepasan, image: Constant.Images.kawatLepasan)
                    })
                    
                    Spacer()
                    Button(action: {
                        path.append(Constant.Categories.gusiBengkak)
                    }, label: {
                        CategoryButton(text: Constant.Categories.gusiBengkak, image: Constant.Images.gusiBengkak)
                    })
                    
                    Spacer()
                    Button(action: {
                        path.append(Constant.Categories.sariawan)
                    }, label: {
                        CategoryButton(text: Constant.Categories.sariawan, image: Constant.Images.sariawan)
                    })
                    
                    Spacer()
                    CategoryButton(text: Constant.Categories.sakitGigi, image: Constant.Images.sakitGigi)
                        .disabled(true)
                        .opacity(0)
              
                }
                .padding(.leading, 30)
                .padding(.trailing, 30)
            }
                .padding(.bottom, 15)
            
            VStack {
                HStack {
                    Text("Perawatan")
                        .fontWeight(.semibold)
                    Spacer()
                   
                }
                .padding(.leading, 30)
                ContainerPerawatan(
                    status: .pending,
                    category: treatmentViewModel.fetchedTreatmentData?.problemCategory ?? "",
                    nama: treatmentViewModel.fetchedTreatmentData?.coassID ?? "",
                    departemen: "teuing",
                    jumlahSesi: "0")
            }
            .ignoresSafeArea()
            .background(Constant.Colors.baseColor)
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        }
        .ignoresSafeArea()
        .background(Constant.Colors.baseColor)
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .onAppear(perform: {
            Task {
                await treatmentViewModel.getTreatmentData()
            }
        })
        
    }
}

struct HomeBackground: View {
    private var name : String = "Dicky"
    private var homeBackgroundWidth: CGFloat = 393
    private var homeBackgroundHeight: CGFloat = 277.69
    
    var body: some View{
        ZStack (alignment : .topLeading) {
            Image(Constant.Images.homeBackground)
                .resizable()
                .frame(width: homeBackgroundWidth, height: homeBackgroundHeight)
            
            HStack {
                VStack (alignment: .leading) {
                    Text("Halo, " + name + "!")
                        .bold()
                    Text("Bagaimana kondisi gigi kamu?")
                        .opacity(0.6)
                }
                
                Spacer()
                
                Button(action: {}, label: {
                    Image(systemName: "clock.fill")
                })
            }
            .foregroundColor(Constant.Colors.baseColor)
            .padding(.top, 70)
            .padding(.leading, 30)
            .padding(.trailing, 30)
        }
    }
}


#Preview {
    Perawatan(path: .constant(NavigationPath()), treatmentViewModel: TreatmentViewModel())
}
